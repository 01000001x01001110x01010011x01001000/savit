import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:savit/helper_classes/app_colors.dart';

class Style{
  static TextStyle popupTextStyle = const TextStyle(
    color: AppColors.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle cardNameStyle = const TextStyle(
    color: AppColors.baseGreenColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static TextStyle descriptionTextStyle = const TextStyle(
    color: AppColors.baseGreenColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle cardPhoneNumberStyle = const TextStyle(
    color: AppColors.baseGreenColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle gainOrLossTagTextStyle = const TextStyle(
    color: AppColors.whiteColor,
    fontSize: 10,
    fontWeight: FontWeight.w700,
  );
}