import 'package:flutter/material.dart';

class CommonContext {
  CommonContext._();

  static final CommonContext instance = CommonContext._();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
