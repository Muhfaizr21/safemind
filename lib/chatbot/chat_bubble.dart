import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isBot;
  final String time;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isBot,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(
          maxWidth: 280,
        ),
        decoration: BoxDecoration(
          color: isBot ? Colors.white : Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // PESAN
            text.contains('Klik di sini')
                ? RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: isBot
                            ? Colors.black87
                            : Colors.white,
                        fontSize: 13.5,
                        height: 1.55,
                      ),
                      children: [
                        TextSpan(
                          text:
                              text.split('Klik di sini')[0],
                        ),

                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/laporan',
                              );
                            },
                            child: const Text(
                              'Klik di sini',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight:
                                    FontWeight.bold,
                                decoration:
                                    TextDecoration
                                        .underline,
                              ),
                            ),
                          ),
                        ),

                        TextSpan(
                          text: text
                                      .split('Klik di sini')
                                      .length >
                                  1
                              ? text.split(
                                  'Klik di sini')[1]
                              : '',
                        ),
                      ],
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: isBot
                          ? Colors.black87
                          : Colors.white,
                      fontSize: 13.5,
                      height: 1.55,
                    ),
                  ),

            const SizedBox(height: 6),

            // JAM
            Text(
              time,
              style: TextStyle(
                color: isBot
                    ? Colors.grey
                    : Colors.white70,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}