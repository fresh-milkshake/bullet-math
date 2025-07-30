import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundDark = Color(0xFF0A0A0A);
  static const Color backgroundDarker = Color(0xFF1A1A1A);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color surfaceLight = Color(0xFF2A2A2A);
  static const Color borderGray = Color(0xFF2A2A2A);
  
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF333333);
  static const Color textHover = Color(0xFF888888);
  
  static const Color accent = Color(0xFF00E5FF);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
}

class AppSizes {
  static const double borderRadiusSmall = 12.0;
  static const double borderRadiusMedium = 16.0;
  static const double borderRadiusLarge = 20.0;
  static const double borderRadiusXLarge = 25.0;
  
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 20.0;
  static const double paddingXLarge = 32.0;
  
  static const double buttonHeight = 48.0;
  static const double numpadButtonHeight = 50.0;
  static const double enterButtonHeight = 52.0;
  
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 36.0;
}

class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 300);
  static const Duration autoAdvance = Duration(milliseconds: 800);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
    letterSpacing: 2,
  );
  
  static const TextStyle questionText = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
    letterSpacing: 4,
  );
  
  static const TextStyle answerText = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle scoreText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );
  
  static const TextStyle numpadText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle enterButtonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.backgroundDark,
    letterSpacing: 1,
  );
} 