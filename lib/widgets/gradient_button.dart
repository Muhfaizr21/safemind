import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double height;
  final double? width;
  final double borderRadius;
  final double fontSize;
  final Widget? leadingIcon;

  const GradientButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.height = 54,
    this.width,
    this.borderRadius = 16,
    this.fontSize = 16,
    this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: AppTheme.gradientBoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                leadingIcon!,
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  const GradientIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 44,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: AppTheme.gradientBoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }
}
