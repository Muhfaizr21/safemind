import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../chatbot/gemini_service.dart';
import '../chatbot/typing_indicator.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final GeminiService _geminiService = GeminiService();

  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'isBot': true,
      'text':
          'Halo! 👋 Selamat datang di SafeMind AI Support.\n\nSaya di sini untuk mendengarkan dan membantu Anda. Silakan ceritakan apa yang Anda rasakan atau tanyakan apa pun tentang kesehatan mental. 💙',
      'time': _formatTimeNow(),
    },
  ];

  final List<String> _quickReplies = [
    '😟 Saya merasa cemas',
    '😰 Cara mengatasi stres',
    '🧠 Tips kesehatan mental',
    '😴 Saya sulit tidur',
  ];

  static String _formatTimeNow() {
    final now = TimeOfDay.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    try {
      _geminiService.initialize();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showApiKeyDialog();
      });
    }
  }

  void _showApiKeyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.orange[700], size: 28),
            const SizedBox(width: 10),
            const Text('API Key Diperlukan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          'API Key Gemini belum dikonfigurasi.\n\n'
          'Silakan buka file:\nlib/chatbot/gemini_service.dart\n\n'
          'Dan ganti YOUR_GEMINI_API_KEY dengan API key dari Google AI Studio.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('Kembali',
                style: TextStyle(color: AppColors.gradientStart)),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty || _isTyping) return;

    final timeStr = _formatTimeNow();

    setState(() {
      _messages.add({'isBot': false, 'text': text.trim(), 'time': timeStr});
      _controller.clear();
      _isTyping = true;
    });

    _scrollToBottom();

    try {
      final response = await _geminiService.sendMessage(text.trim());
      if (!mounted) return;

      final responseTime = _formatTimeNow();
      setState(() {
        _isTyping = false;
        _messages.add({
          'isBot': true,
          'text': response,
          'time': responseTime,
        });
      });
    } catch (e) {
      if (!mounted) return;
      final responseTime = _formatTimeNow();
      setState(() {
        _isTyping = false;
        _messages.add({
          'isBot': true,
          'text':
              'Maaf, terjadi kesalahan saat memproses pesan Anda. Silakan coba lagi. 🙏',
          'time': responseTime,
        });
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  void _resetChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Mulai Percakapan Baru?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: const Text(
          'Semua pesan akan dihapus dan percakapan baru akan dimulai.',
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _geminiService.resetChat();
              setState(() {
                _messages.clear();
                _messages.add({
                  'isBot': true,
                  'text':
                      'Halo! 👋 Percakapan baru dimulai.\n\nSaya siap mendengarkan Anda. Ceritakan apa yang sedang Anda rasakan. 💙',
                  'time': _formatTimeNow(),
                });
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gradientStart,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Ya, Mulai Baru',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // HEADER
          _buildHeader(),

          // MESSAGES
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                // Show typing indicator as the last item
                if (index == _messages.length && _isTyping) {
                  return const TypingIndicator();
                }

                final msg = _messages[index];
                final isBot = msg['isBot'] as bool;
                return _ChatBubble(
                  text: msg['text'] as String,
                  isBot: isBot,
                  time: msg['time'] as String,
                );
              },
            ),
          ),

          // QUICK REPLIES
          if (_messages.length <= 2 && !_isTyping) _buildQuickReplies(),

          // INPUT AREA
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 52, left: 20, right: 12, bottom: 20),
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradientVertical,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Colors.white.withOpacity(0.3), width: 1),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 17),
            ),
          ),
          const SizedBox(width: 14),
          // Avatar bot with Gemini sparkle
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border:
                  Border.all(color: Colors.white.withOpacity(0.4), width: 2),
            ),
            child: const Icon(Icons.auto_awesome,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SafeMind AI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: _isTyping
                            ? Colors.orangeAccent
                            : const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _isTyping ? 'Mengetik...' : 'Powered by Gemini',
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Reset chat button
          GestureDetector(
            onTap: _resetChat,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Colors.white.withOpacity(0.3), width: 1),
              ),
              child: const Icon(Icons.refresh_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReplies() {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(bottom: 6),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _quickReplies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _sendMessage(_quickReplies[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: AppColors.cardBorder, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gradientStart.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                _quickReplies[index],
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientStart.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.cardBorder, width: 1.2),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLines: null,
                enabled: !_isTyping,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: _isTyping
                      ? 'Menunggu respons...'
                      : 'Ketik pesan Anda...',
                  hintStyle: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 12),
                ),
                onSubmitted: _sendMessage,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap:
                _isTyping ? null : () => _sendMessage(_controller.text),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: _isTyping
                    ? LinearGradient(
                        colors: [
                          AppColors.gradientStart.withOpacity(0.4),
                          AppColors.gradientEnd.withOpacity(0.4),
                        ],
                      )
                    : AppTheme.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: _isTyping
                    ? []
                    : [
                        BoxShadow(
                          color: AppColors.gradientStart.withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: const Icon(Icons.send_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isBot;
  final String time;

  const _ChatBubble({
    required this.text,
    required this.isBot,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment:
            isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isBot) ...[
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8, bottom: 2),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome,
                  color: Colors.white, size: 16),
            ),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.72,
                  ),
                  decoration: BoxDecoration(
                    gradient: isBot ? null : AppTheme.primaryGradient,
                    color: isBot ? Colors.white : null,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: isBot
                          ? const Radius.circular(4)
                          : const Radius.circular(18),
                      bottomRight: isBot
                          ? const Radius.circular(18)
                          : const Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isBot
                            ? Colors.black.withOpacity(0.05)
                            : AppColors.gradientStart.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isBot ? AppColors.textPrimary : Colors.white,
                      fontSize: 13.5,
                      height: 1.55,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isBot) ...[
                      Icon(Icons.auto_awesome,
                          size: 10,
                          color: AppColors.gradientStart.withOpacity(0.5)),
                      const SizedBox(width: 3),
                    ],
                    Text(
                      time,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isBot) const SizedBox(width: 4),
        ],
      ),
    );
  }
}