import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savit/features/auth/view/login_screen.dart';
import 'package:savit/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:savit/features/onboarding/view/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(const OnboardingChecked());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == OnboardingStatus.firstLaunch) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(builder: (_) => const OnboardingScreen()),
          );
        }

        if (state.status == OnboardingStatus.completed) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
          );
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
