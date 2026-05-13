import 'package:flutter/material.dart';

class QuickReply extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const QuickReply({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.blue,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}