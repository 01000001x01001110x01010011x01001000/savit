import 'package:flutter/material.dart';
import 'package:savit/helper_classes/app_colors.dart';
import 'package:savit/helper_classes/app_images.dart';

class CustomAppBar {
  PreferredSizeWidget customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.baseGreenColor,
      leadingWidth: 46,
      actions: [
        Image.asset(
          AppImages.splashImage,
          width: 60,
        ),
        const SizedBox(
          width: 20,
        ),
      ],
      leading: Padding(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          child: Image.asset(
            AppImages.appbarImage,
          )),
    );
  }
}
