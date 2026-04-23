import 'package:flutter/material.dart';
import 'package:savit/helper_classes/app_colors.dart';
import 'package:savit/helper_classes/app_text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Inter',
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.onboardingBackground,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.baseGreenColor),
      textTheme: const TextTheme(
        titleLarge: AppTextStyles.onboardingTitle,
        titleMedium: AppTextStyles.onboardingTitleMedium,
        bodyLarge: AppTextStyles.onboardingSubtitle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.baseGreenColor,
          foregroundColor: Colors.white,
          textStyle: AppTextStyles.onboardingPrimaryButton,
          elevation: 0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(textStyle: AppTextStyles.onboardingSkip),
      ),
    );
  }
}
