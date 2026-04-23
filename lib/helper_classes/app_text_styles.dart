import 'package:flutter/material.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const TextStyle onboardingSkip = TextStyle(
    color: Color(0xFF067354),
    fontSize: 16,
    letterSpacing: 1.4,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle onboardingTitle = TextStyle(
    color: Color(0xFF10161A),
    fontSize: 32,
    height: 1.15,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle onboardingTitleMedium = TextStyle(
    color: Color(0xFF10161A),
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle onboardingSubtitle = TextStyle(
    color: Color(0xFF37444A),
    fontSize: 18,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle onboardingPrimaryButton = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle homeTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color(0xFF10161A),
  );
}
