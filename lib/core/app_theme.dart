import 'package:flutter/material.dart';
import 'app_constants.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.accent,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        surface: AppColors.backgroundDark,
        background: AppColors.backgroundDark,
        error: AppColors.error,
        onPrimary: AppColors.backgroundDark,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: AppColors.textPrimary,
      ),
      textTheme: _buildTextTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(),
    );
  }

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      headlineLarge: AppTextStyles.heading,
      headlineMedium: AppTextStyles.questionText,
      bodyLarge: AppTextStyles.answerText,
      bodyMedium: AppTextStyles.scoreText,
      labelLarge: AppTextStyles.buttonText,
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.backgroundDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        ),
        minimumSize: const Size(0, AppSizes.buttonHeight),
        textStyle: AppTextStyles.buttonText,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        borderSide: const BorderSide(color: AppColors.accent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        borderSide: const BorderSide(color: AppColors.accent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        borderSide: const BorderSide(color: AppColors.accent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingMedium,
      ),
    );
  }
} 