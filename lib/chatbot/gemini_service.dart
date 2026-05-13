import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = 'AIzaSyBtKBjTHIMYVykSn2s2L0mLjzR4GgQy7Xs';

  static const String _systemInstruction = '''
Kamu adalah SafeMind AI Support, asisten kesehatan mental yang empatik, suportif, dan profesional.

Panduan respons:
- Selalu merespons dalam Bahasa Indonesia yang sopan dan hangat.
- Tunjukkan empati dan validasi perasaan pengguna.
- Berikan saran praktis yang dapat diterapkan (teknik pernapasan, grounding, journaling, dll).
- Jika pengguna menunjukkan tanda-tanda krisis atau bahaya serius, sarankan untuk menghubungi profesional atau hotline darurat (misalnya Into The Light: 119 ext 8).
- Jangan pernah memberikan diagnosis medis. Selalu rekomendasikan konsultasi dengan psikolog atau psikiater untuk kondisi serius.
- Jaga percakapan tetap fokus pada kesehatan mental dan kesejahteraan emosional.
- Jika ditanya tentang fitur aplikasi SafeMind, jelaskan bahwa tersedia fitur: Laporan (untuk melaporkan perundungan/kekerasan), Konsultasi Psikolog, dan Edukasi kesehatan mental.
- Berikan respons yang ringkas namun bermakna (maksimal 3-4 paragraf).
- Gunakan emoji secukupnya untuk membuat percakapan lebih hangat 💙
''';

  // Conversation history untuk context
  final List<Map<String, dynamic>> _conversationHistory = [];

  // Model yang akan dicoba
  static const List<String> _models = [
    'gemini-flash-latest',
    'gemini-2.5-flash',
    'gemini-2.0-flash',
  ];

  String _currentModel = _models[0];

  bool _isInitialized = false;

  void initialize() {
    if (_apiKey == 'YOUR_GEMINI_API_KEY') {
      throw Exception('API Key belum dikonfigurasi.');
    }
    _isInitialized = true;
    developer.log('GeminiService: Initialized with API key');
  }

  /// Kirim pesan ke Gemini REST API
  Future<String> sendMessage(String message) async {
    if (!_isInitialized) {
      initialize();
    }

    // Tambah pesan user ke history
    _conversationHistory.add({
      'role': 'user',
      'parts': [{'text': message}],
    });

    // Coba setiap model sampai berhasil
    for (int i = 0; i < _models.length; i++) {
      _currentModel = _models[i];
      developer.log('GeminiService: Trying model: $_currentModel');

      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/$_currentModel:generateContent?key=$_apiKey',
      );

      final body = jsonEncode({
        'system_instruction': {
          'parts': [{'text': _systemInstruction}],
        },
        'contents': _conversationHistory,
        'generationConfig': {
          'temperature': 0.7,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 1024,
        },
      });

      try {
        final response = await http
            .post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: body,
            )
            .timeout(const Duration(seconds: 30));

        developer.log('GeminiService: Response status: ${response.statusCode}');
        developer.log('GeminiService: Response body: ${response.body.substring(0, response.body.length > 500 ? 500 : response.body.length)}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          // Cek apakah ada candidates
          if (data['candidates'] != null &&
              (data['candidates'] as List).isNotEmpty) {
            final candidate = data['candidates'][0];

            // Cek apakah ada content
            if (candidate['content'] != null &&
                candidate['content']['parts'] != null &&
                (candidate['content']['parts'] as List).isNotEmpty) {
              final text = candidate['content']['parts'][0]['text'] as String;

              // Simpan respons bot ke history
              _conversationHistory.add({
                'role': 'model',
                'parts': [{'text': text}],
              });

              return text;
            }

            // Cek finish reason
            final finishReason = candidate['finishReason'];
            if (finishReason == 'SAFETY') {
              // Hapus pesan user terakhir dari history
              _conversationHistory.removeLast();
              return 'Saya tidak dapat merespons pesan tersebut karena alasan keamanan. Silakan coba dengan pertanyaan yang berbeda. 🙏';
            }
          }

          // Cek prompt feedback
          if (data['promptFeedback'] != null) {
            final blockReason = data['promptFeedback']['blockReason'];
            if (blockReason != null) {
              _conversationHistory.removeLast();
              return 'Pesan Anda tidak dapat diproses (alasan: $blockReason). Silakan coba pertanyaan lain. 🙏';
            }
          }

          _conversationHistory.removeLast();
          return 'Maaf, saya tidak mendapat respons yang valid. Silakan coba lagi.';
        }

        // HTTP error - parse error message
        final errorBody = jsonDecode(response.body);
        final errorMessage = errorBody['error']?['message'] ?? 'Unknown error';
        final errorStatus = errorBody['error']?['status'] ?? '';

        developer.log('GeminiService: API Error [$_currentModel]: ${response.statusCode} - $errorMessage');

        // Jika 404 (model not found), coba model berikutnya
        if (response.statusCode == 404 && i < _models.length - 1) {
          developer.log('GeminiService: Model not found, trying next...');
          continue;
        }

        // Jika 429 (rate limited), coba model berikutnya juga
        if (response.statusCode == 429 && i < _models.length - 1) {
          developer.log('GeminiService: Rate limited, trying next model...');
          continue;
        }

        // Jika error lainnya pada model terakhir
        if (i == _models.length - 1) {
          _conversationHistory.removeLast();

          if (response.statusCode == 400) {
            return 'Terjadi kesalahan pada request: $errorMessage';
          } else if (response.statusCode == 403) {
            return 'API Key tidak memiliki akses. Pastikan Gemini API sudah diaktifkan di Google Cloud Console. 🔑';
          } else if (response.statusCode == 429) {
            return 'Layanan sedang sibuk (rate limit). Silakan tunggu beberapa saat dan coba lagi. 🙏';
          } else if (response.statusCode == 404) {
            return 'Semua model tidak tersedia. Error: $errorMessage';
          } else {
            return 'Error ${response.statusCode}: $errorMessage';
          }
        }
      } catch (e) {
        developer.log('GeminiService: Exception with $_currentModel: $e');

        if (i < _models.length - 1) {
          continue;
        }

        _conversationHistory.removeLast();

        final errorStr = e.toString().toLowerCase();
        if (errorStr.contains('timeout')) {
          return 'Koneksi timeout. Pastikan internet Anda stabil dan coba lagi. ⏱️';
        } else if (errorStr.contains('socket') ||
            errorStr.contains('connection') ||
            errorStr.contains('host lookup')) {
          return 'Tidak dapat terhubung ke server. Periksa koneksi internet Anda. 📡';
        }

        return 'Terjadi kesalahan: ${e.toString().substring(0, e.toString().length > 100 ? 100 : e.toString().length)}\n\nSilakan coba lagi. 🙏';
      }
    }

    _conversationHistory.removeLast();
    return 'Maaf, semua model sedang tidak tersedia. Silakan coba lagi nanti. 🙏';
  }

  /// Reset sesi chat
  void resetChat() {
    _conversationHistory.clear();
    _currentModel = _models[0];
  }
}
