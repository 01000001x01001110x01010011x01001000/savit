import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:savit/helper_classes/app_colors.dart';

class Utils {
  static makeACall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      textColor: AppColors.baseGreenColor,
      backgroundColor: AppColors.whiteColor,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
