import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_users_api/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  final SharedPreferences prefs;

  LangCubit(this.prefs) : super(LangInitial());

  final String _cachedLang = 'CACHED_LANG';

  String getCachedLanguage() {
    try {
      final code = prefs.getString(_cachedLang);
      if (code != null) {
        emit(ChangeLanguage(locale: Locale(code)));
        return code;
      }

      emit(const ChangeLanguage(locale: Locale('en')));
      return 'en';
    } catch (e) {
      throw CacheException();
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
