import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

abstract class ThemePersistense {
  Stream<CustomTheme> getTheme();
  Stream<Locale?> getLocale();
  Future<void> saveTheme(CustomTheme theme);
  Future<void> saveLocale(Locale locale);
  void dispose();
}

enum CustomTheme { light, dark, system }

class ThemeRepository implements ThemePersistense {
  ThemeRepository() {
    _init();
  }

  final SharedPreferences _sharedPreferences = getIt<SharedPreferences>();

  final _themeController = StreamController<CustomTheme>.broadcast();
  final _langController = StreamController<Locale?>.broadcast();

  void _init() {
    final themeString = _sharedPreferences.getString(PreferenceTypes.theme);
    final localeString = _sharedPreferences.getString(PreferenceTypes.locale);
    switch (themeString) {
      case "light":
        _themeController.add(CustomTheme.light);
        break;
      case "dark":
        _themeController.add(CustomTheme.dark);
        break;
      case "system":
        _themeController.add(CustomTheme.system);
        break;
      default:
        _themeController.add(CustomTheme.system);
        break;
    }

    _langController.add(localeString == null ? null : Locale(localeString));
  }

  @override
  Stream<CustomTheme> getTheme() async* {
    yield* _themeController.stream;
  }

  @override
  Stream<Locale?> getLocale() async* {
    yield* _langController.stream;
  }

  @override
  Future<void> saveTheme(CustomTheme theme) {
    _themeController.add(theme);
    return _sharedPreferences.setString(PreferenceTypes.theme, theme.name);
  }

  @override
  Future<void> saveLocale(Locale? locale) {
    _langController.add(locale);
    return locale == null
        ? _sharedPreferences.remove(PreferenceTypes.locale)
        : _sharedPreferences.setString(
            PreferenceTypes.locale, locale.languageCode);
  }

  @override
  void dispose() {
    _themeController.close();
    _langController.close();
  }
}
