import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savit/helper_classes/app_colors.dart';
import 'package:savit/helper_classes/app_constants.dart';
import 'package:savit/helper_classes/app_images.dart';
import 'package:savit/helper_classes/style.dart';
import 'package:savit/helper_classes/utils.dart';
import 'dart:math' as math;

class MeetsCard extends StatefulWidget {
  const MeetsCard({
    Key? key,
    required this.name,
    required this.phoneNumber,
    this.wantToGain = AppConstants.maintain,
    required this.description,
    this.isAudioAvailable = false,
  }) : super(key: key);

  final String name;
  final String description;
  final String? wantToGain;
  final String phoneNumber;
  final bool? isAudioAvailable;
  @override
  State<MeetsCard> createState() => _MeetsCardState();
}

class _MeetsCardState extends State<MeetsCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();
  bool isPlayingAudio = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      width: AppConstants.mobileWidth,
      height: AppConstants.mobileWidth * 0.22,
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.baseGreenColor,
            width: AppConstants.mobileWidth * 0.006),
        color: AppColors.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.name,
                style: Style.cardNameStyle,
              ),
              SizedBox(width: AppConstants.paddingWidth),
              Container(
                height: AppConstants.mobileHeight * 0.03,
                width: AppConstants.mobileWidth * 0.1,
                padding: const EdgeInsets.all(
                  4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.baseGreenColor,
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.wantToGain?.toUpperCase() ?? "",
                    style: Style.gainOrLossTagTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                child: Image.asset(
                  AppImages.mobileIcon,
                  height: AppConstants.mobileHeight * 0.035,
                ),
                onTap: () async {
                  await Utils.makeACall(
                    widget.phoneNumber,
                  );
                },
              ),
              SizedBox(
                width: AppConstants.mobileWidth * 0.02,
              ),
              GestureDetector(
                onLongPress: () async => await copyTextPopup(
                  widget.phoneNumber,
                ),
                child: Text(
                  widget.phoneNumber,
                  style: Style.cardPhoneNumberStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppConstants.mobileHeight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: isPlayingAudio
                    ? AppConstants.mobileWidth * 0.7
                    : AppConstants.mobileWidth * 0.8,
                child: Text(
                  widget.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Style.descriptionTextStyle,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPlayingAudio = true;
                    controller.forward();
                  });
                },
                child: Visibility(
                  visible: (widget.isAudioAvailable ?? false) && !isPlayingAudio,
                  child: Image.asset(
                    AppImages.playIcon,
                    height: AppConstants.mobileHeight * 0.03,
                  ),
                ),
              ),
              Visibility(
                visible: isPlayingAudio,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (_, Widget? child) {
                    return Transform.rotate(
                      angle: controller.value * 2 * math.pi,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    AppImages.diskIcon,
                    height: AppConstants.mobileHeight * 0.04,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPlayingAudio = false;
                    controller.stop();
                  });
                },
                child: Visibility(
                  visible: isPlayingAudio,
                  child: Image.asset(
                    AppImages.pauseIcon,
                    height: AppConstants.mobileHeight * 0.03,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  copyTextPopup(String phoneNumber) async {
    Clipboard.setData(ClipboardData(text: phoneNumber))
        .then((value) => Utils.showToast(AppConstants.phoneNumberCopied));
  }
}
