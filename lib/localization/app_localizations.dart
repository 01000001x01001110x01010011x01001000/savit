import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    final AppLocalizations? localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    return localizations ?? AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
    'en': <String, String>{
      'skip': 'SKIP',
      'continue': 'Continue',
      'next': 'Next',
      'getStarted': 'Get Started',
      'manageLeadsTitle': 'Manage Leads',
      'manageLeadsSubtitle':
          'Easily organize and track your\npotential clinic clients.',
      'evaluationsTitle': 'Run Health\nEvaluations.',
      'evaluationsSubtitle': 'Conduct thorough assessments\nwith digital tools.',
      'trackProgressTitle': 'Track Customer\nProgress.',
      'trackProgressSubtitle':
          'Monitor patient journeys and\noutcomes over time.',
      'homeTitle': 'Home Screen',
      'loginTitle': 'Clinic Diary',
      'loginSubtitle': 'Log in to manage your practice',
      'phoneNumber': 'Phone Number',
      'enterMobileNumber': 'Enter mobile number',
      'sendOtp': 'Send OTP',
      'or': 'OR',
      'enterOtp': 'Enter OTP',
      'verify': 'Verify',
      'termsLine': 'By continuing you agree to our',
      'terms': 'Terms',
      'otpSent': 'OTP sent',
      'phoneInvalid': 'Please enter a valid 10-digit mobile number',
      'otpInvalid': 'Please enter a valid 6-digit OTP',
      'otpSubmitted': 'OTP submitted',
      'english': 'English',
      'hindi': 'हिंदी',
      'hindiDisplay': 'हिन्दी',
      'enShort': 'EN',
    },
    'hi': <String, String>{
      'skip': 'छोड़ें',
      'continue': 'जारी रखें',
      'next': 'अगला',
      'getStarted': 'शुरू करें',
      'manageLeadsTitle': 'लीड्स प्रबंधित करें',
      'manageLeadsSubtitle':
          'अपनी संभावित क्लिनिक\nक्लाइंट्स को आसानी से व्यवस्थित और ट्रैक करें।',
      'evaluationsTitle': 'स्वास्थ्य\nमूल्यांकन करें।',
      'evaluationsSubtitle':
          'डिजिटल टूल्स के साथ\nविस्तृत आकलन करें।',
      'trackProgressTitle': 'ग्राहक प्रगति\nट्रैक करें।',
      'trackProgressSubtitle':
          'समय के साथ मरीज की यात्रा और\nपरिणामों की निगरानी करें।',
      'homeTitle': 'होम स्क्रीन',
      'loginTitle': 'क्लिनिक डायरी',
      'loginSubtitle': 'अपनी प्रैक्टिस संभालने के लिए लॉग इन करें',
      'phoneNumber': 'फोन नंबर',
      'enterMobileNumber': 'मोबाइल नंबर दर्ज करें',
      'sendOtp': 'ओटीपी भेजें',
      'or': 'या',
      'enterOtp': 'ओटीपी दर्ज करें',
      'verify': 'सत्यापित करें',
      'termsLine': 'जारी रखकर आप हमारी',
      'terms': 'शर्तों',
      'otpSent': 'ओटीपी भेजा गया',
      'phoneInvalid': 'कृपया सही 10-अंकों का मोबाइल नंबर दर्ज करें',
      'otpInvalid': 'कृपया सही 6-अंकों का ओटीपी दर्ज करें',
      'otpSubmitted': 'ओटीपी जमा किया गया',
      'english': 'English',
      'hindi': 'हिंदी',
      'hindiDisplay': 'हिन्दी',
      'enShort': 'EN',
    },
  };

  String _text(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']![key]!;
  }

  String get skip => _text('skip');
  String get continueText => _text('continue');
  String get next => _text('next');
  String get getStarted => _text('getStarted');
  String get manageLeadsTitle => _text('manageLeadsTitle');
  String get manageLeadsSubtitle => _text('manageLeadsSubtitle');
  String get evaluationsTitle => _text('evaluationsTitle');
  String get evaluationsSubtitle => _text('evaluationsSubtitle');
  String get trackProgressTitle => _text('trackProgressTitle');
  String get trackProgressSubtitle => _text('trackProgressSubtitle');
  String get homeTitle => _text('homeTitle');
  String get loginTitle => _text('loginTitle');
  String get loginSubtitle => _text('loginSubtitle');
  String get phoneNumber => _text('phoneNumber');
  String get enterMobileNumber => _text('enterMobileNumber');
  String get sendOtp => _text('sendOtp');
  String get or => _text('or');
  String get enterOtp => _text('enterOtp');
  String get verify => _text('verify');
  String get termsLine => _text('termsLine');
  String get terms => _text('terms');
  String get otpSent => _text('otpSent');
  String get phoneInvalid => _text('phoneInvalid');
  String get otpInvalid => _text('otpInvalid');
  String get otpSubmitted => _text('otpSubmitted');
  String get english => _text('english');
  String get hindi => _text('hindi');
  String get hindiDisplay => _text('hindiDisplay');
  String get enShort => _text('enShort');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
