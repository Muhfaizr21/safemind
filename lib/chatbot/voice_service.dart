import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

class VoiceService {

  static final SpeechToText _speech =
      SpeechToText();

  static bool isListening = false;

  static Timer? _silenceTimer;

  static String _lastWords = '';

  static Future<void> startListening({
    required Function(String) onFinalResult,
  }) async {

    bool available =
        await _speech.initialize(
      onError: (error) async {

        print('ERROR: $error');

        await stopListening();
      },
    );

    print('AVAILABLE: $available');

    if (!available) return;

    isListening = true;

    _lastWords = '';

    await _speech.listen(

      localeId: 'id_ID',

      partialResults: true,

      listenFor: const Duration(
        minutes: 1,
      ),

      onResult: (result) {

        _lastWords =
            result.recognizedWords;

        print(_lastWords);

        // reset timer tiap user ngomong
        _silenceTimer?.cancel();

        // kalau user diam 2 detik
        _silenceTimer = Timer(
          const Duration(seconds: 2),
          () async {

            if (isListening) {

              await stopListening();

              if (_lastWords
                  .trim()
                  .isNotEmpty) {

                onFinalResult(
                  _lastWords,
                );
              }
            }
          },
        );
      },
    );
  }

  static Future<void> stopListening() async {

    _silenceTimer?.cancel();

    await _speech.stop();

    isListening = false;
  }
}