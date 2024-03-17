import 'package:flutter/material.dart';
import 'package:savit/helper_classes/app_colors.dart';
import 'package:savit/helper_classes/app_constants.dart';
import 'package:savit/helper_classes/app_images.dart';
import 'package:savit/helper_classes/common_enums.dart';
import 'package:savit/helper_classes/common_search_bar.dart';
import 'package:savit/helper_classes/meets_card.dart';
import 'package:savit/helper_classes/style.dart';

class MeetsHome extends StatefulWidget {
  const MeetsHome({Key? key}) : super(key: key);

  @override
  State<MeetsHome> createState() => _MeetsHomeState();
}

class _MeetsHomeState extends State<MeetsHome> {
  TextEditingController dateController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonSearchBar(
          hintText: AppConstants.searchNotes,
        ),
        // SizedBox(
        //   height: AppConstants.paddingHeight,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: AppConstants.mobileWidth * 0.4,
              height: AppConstants.mobileHeight * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: AppColors.baseGreenColor,
              ),
              child: GestureDetector(
                child: SizedBox(
                  width: AppConstants.mobileWidth * 0.4,
                  height: AppConstants.mobileHeight * 0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppConstants.defaultDate,
                        style: Style.popupTextStyle,
                      ),
                      Image.asset(
                        AppImages.dropdownIcon,
                        width: AppConstants.mobileWidth * 0.04,
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  await pickDate();
                },
              ),
            ),
            Container(
              width: AppConstants.mobileWidth * 0.3,
              height: AppConstants.mobileHeight * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: AppColors.baseGreenColor,
              ),
              child: GestureDetector(
                child: SizedBox(
                  width: AppConstants.mobileWidth * 0.4,
                  height: AppConstants.mobileHeight * 0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppConstants.typeText,
                        style: Style.popupTextStyle,
                      ),
                      Image.asset(
                        AppImages.dropdownIcon,
                        width: AppConstants.mobileWidth * 0.04,
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  await pickDate();
                },
              ),
            ),
          ],
        ),
        MeetsCard(
          name: "Ansh Bhardwaj",
          phoneNumber: "7668013890",
          wantToGain: Types.maintain.name,
          description:
              "Want to loose Fat of himself and his momWant to loose Fat of himself and his momWant to loose Fat of himself and his momWant to loose Fat of himself and his mom",
          isAudioAvailable: true,
        ),
      ],
    );
  }
}

pickDate() {
  DatePickerDialog pickedDate = DatePickerDialog(
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(
      const Duration(
        hours: 720,
      ),
    ),
    lastDate: DateTime.now().add(
      const Duration(
        days: 360,
      ),
    ),
  );
}
