import 'package:flutter/material.dart';

class CommonContext {
  CommonContext._();
  static CommonContext? _commonContext;
  static CommonContext get instance{
    return _commonContext ??= CommonContext._();
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  BuildContext get currentContext => navigatorKey.currentContext! ;
}