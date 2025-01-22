import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/theme/data/theme_strings.dart';

abstract class ThemePersistence {
  Stream<String> getTheme();
  Stream<Locale?> getLocale();
  Future<void> saveTheme(String theme);
  Future<void> saveLocale(Locale locale);
  void dispose();
}

class ThemeRepository implements ThemePersistence {
  ThemeRepository() {
    _init();
  }

  final PreferenceRepository _preferenceService = getIt<PreferenceRepository>();

  final _themeController = StreamController<String>.broadcast();
  final _langController = StreamController<Locale?>.broadcast();

  void _init() {
    final String? themeString = _preferenceService.theme;
    final localeString = _preferenceService.locale;
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
  Future<void> saveTheme(String theme) async {
    _themeController.add(theme);
    await _preferenceService.setTheme(theme);
  }

  @override
  Future<void> saveLocale(Locale? locale) async {
    _langController.add(locale);
    locale == null
        ? await _preferenceService.remove(PreferenceTypes.locale)
        : await _preferenceService.setLocale(locale.languageCode);
  }

  @override
  void dispose() {
    _themeController.close();
    _langController.close();
  }
}
