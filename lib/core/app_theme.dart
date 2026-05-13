import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
  );

  static const LinearGradient primaryGradientVertical = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
  );

  static BoxDecoration gradientBoxDecoration({
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      gradient: primaryGradient,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: AppColors.gradientStart.withOpacity(0.35),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static ThemeData get themeData {
    return ThemeData(
      primaryColor: AppColors.gradientStart,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.gradientStart,
        secondary: AppColors.gradientEnd,
      ),
      fontFamily: 'Poppins',
    );
  }
}
