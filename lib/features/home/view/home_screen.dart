import 'package:flutter/material.dart';
import 'package:savit/localization/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Center(
        child: Text(
          l10n.homeTitle,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF10161A),
          ),
        ),
      ),
    );
  }
}
