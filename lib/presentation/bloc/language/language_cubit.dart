import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:github_users_app/core/core.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final SharedPreferences prefs;

  LanguageCubit({required this.prefs}) : super(LanguageInitial());

  final String _cachedLang = 'CACHED_LANG';

  String getCachedLanguage() {
    try {
      final code = prefs.getString(_cachedLang);
      if (code != null) {
        emit(ChangeLanguage(locale: Locale(code)));
        return code;
      }

      emit(ChangeLanguage(locale: const Locale('en')));
      return 'en';
    } catch (e) {
      throw CacheExeption();
    }
  }

  Future<void> changeLanguage(String code) async {
    try {
      await prefs.setString(_cachedLang, code);
      getCachedLanguage();
    } catch (e) {
      log(e.toString());
    }
  }
}
