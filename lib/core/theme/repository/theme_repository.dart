import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/theme/data/theme_strings.dart';

abstract class ThemePersistence {
  Stream<String> getTheme();
  Stream<Locale?> getLocale();
  Future<bool> saveTheme(String theme);
  Future<bool> saveLocale(Locale locale);
  void dispose();
}

class ThemeRepository implements ThemePersistence {
  ThemeRepository() {
    _init();
  }

  final SharedPreferences _sharedPreferences = getIt<SharedPreferences>();

  final _themeController = StreamController<String>.broadcast();
  final _langController = StreamController<Locale?>.broadcast();

  void _init() {
    final String? themeString = _sharedPreferences.getString(PreferenceTypes.theme);
    final localeString = _sharedPreferences.getString(PreferenceTypes.locale);
    log(themeString!);
    switch (themeString) {
      case ThemeType.light:
        _themeController.add(ThemeType.light);
        break;
      case ThemeType.dark:
        _themeController.add(ThemeType.dark);
        break;
      case ThemeType.system:
        _themeController.add(ThemeType.system);
        break;
      default:
        _themeController.add(ThemeType.system);
        break;
    }

    _langController.add(localeString == null ? null : Locale(localeString));
  }

  @override
  Stream<String> getTheme() async* {
    yield* _themeController.stream;
  }

  @override
  Stream<Locale?> getLocale() async* {
    yield* _langController.stream;
  }

  @override
  Future<bool> saveTheme(String theme) async {
    _themeController.add(theme);
    return await _sharedPreferences.setString(PreferenceTypes.theme, theme);
  }

  @override
  Future<bool> saveLocale(Locale? locale) async {
    _langController.add(locale);
    return locale == null
        ? await _sharedPreferences.remove(PreferenceTypes.locale)
        : await _sharedPreferences.setString(PreferenceTypes.locale, locale.languageCode);
  }

  @override
  void dispose() {
    _themeController.close();
    _langController.close();
  }
}
