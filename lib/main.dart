import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:savit/di/locator.dart';
import 'package:savit/features/home/bloc/home_bloc.dart';
import 'package:savit/features/language/bloc/language_cubit.dart';
import 'package:savit/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:savit/helper_classes/app_theme.dart';
import 'package:savit/helper_classes/common_context.dart';
import 'package:savit/localization/app_localizations.dart';
import 'package:savit/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<HomeBloc>.value(
          value: locator<HomeBloc>()..add(const HomeStarted()),
        ),
        BlocProvider<OnboardingBloc>.value(value: locator<OnboardingBloc>()),
        BlocProvider<LanguageCubit>.value(value: locator<LanguageCubit>()),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: CommonContext.instance.navigatorKey,
            title: 'ClinicCare',
            theme: AppTheme.lightTheme,
            locale: locale,
            supportedLocales: const <Locale>[
              Locale('en'),
              Locale('hi'),
            ],
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
