import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences,
        super(Locale(_resolveLanguageCode(sharedPreferences)));

  final SharedPreferences _sharedPreferences;

  static const String _languageCodeKey = 'app_language_code';

  static String _resolveLanguageCode(SharedPreferences prefs) {
    final String code = prefs.getString(_languageCodeKey) ?? 'en';
    return code == 'hi' ? 'hi' : 'en';
  }

  Future<void> setEnglish() => _setLocale(const Locale('en'));

  Future<void> setHindi() => _setLocale(const Locale('hi'));

  Future<void> _setLocale(Locale locale) async {
    if (state.languageCode == locale.languageCode) {
      return;
    }

    await _sharedPreferences.setString(_languageCodeKey, locale.languageCode);
    emit(locale);
  }
}
