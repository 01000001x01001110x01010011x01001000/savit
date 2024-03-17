import 'package:flutter/cupertino.dart';
import 'package:savit/helper_classes/common_context.dart';

class AppConstants {
  static final mobileHeight =
      MediaQuery.of(CommonContext.instance.currentContext).size.height;
  static final mobileWidth =
      MediaQuery.of(CommonContext.instance.currentContext).size.width;
  static final paddingHeight =
      MediaQuery.of(CommonContext.instance.currentContext).size.height * 0.03;
  static final paddingWidth =
      MediaQuery.of(CommonContext.instance.currentContext).size.width * 0.03;
  static const meets = "Meets";
  static const name = "Name";
  static const dob = "DOB";
  static const age = "Age";
  static const reason = "Reason";
  static const phoneNumber = "Phone Number";
  static const notes = "Notes";
  static const search = "Search";
  static const searchNotes = "Search Notes";
  static const searchMeets = "Search Meets";
  static const defaultDate = "15 Oct 2002";
  static const typeText = "Type";
  static const phoneNumberCopied = "Phone Number Copied";
  static const maintain = "Maintain";
  static const clickOutsideToClose = "Click Outside To Close";

}
