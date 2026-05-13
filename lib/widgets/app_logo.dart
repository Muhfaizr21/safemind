import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final double borderRadius;
  final bool showText;
  final double fontSize;

  const AppLogo({
    Key? key,
    this.size = 48,
    this.borderRadius = 14,
    this.showText = true,
    this.fontSize = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8062DA).withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.asset(
              'assets/images/logo_heart.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 10),
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              'SafeMind',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
