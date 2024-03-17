import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:savit/helper_classes/app_colors.dart';
import 'package:savit/helper_classes/app_constants.dart';
import 'package:savit/helper_classes/app_images.dart';

class CommonSearchBar extends StatefulWidget {
  const CommonSearchBar(
      {Key? key, this.hintText, this.hintTextStyle, this.textStyle})
      : super(key: key);
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;

  @override
  State<CommonSearchBar> createState() => _CommonSearchBarState();
}

class _CommonSearchBarState extends State<CommonSearchBar> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppConstants.mobileHeight * 0.02,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.baseGreenColor,
          style: BorderStyle.solid,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: searchController,
        style: const TextStyle(color: AppColors.baseGreenColor),
        decoration: InputDecoration(
          hintText: widget.hintText ?? AppConstants.search,
          contentPadding: EdgeInsets.symmetric(
              horizontal: AppConstants.mobileWidth * 0.03,
              vertical: AppConstants.mobileHeight * 0.02),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () {
              log("search icon clicked");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 2,
              ),
              child: Image.asset(
                AppImages.searchIcon,
                height: AppConstants.mobileHeight * 0.05,
              ),
            ),
          ),
        ),
        onChanged: (value) {
          getFilteredData();
        },
      ),
    );
  }

  void getFilteredData() {}
}
