import 'package:flutter/material.dart';
import 'package:savit/helper_classes/app_colors.dart';
import 'package:savit/helper_classes/common_context.dart';
import 'package:savit/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: CommonContext.instance.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.baseGreenColor,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
