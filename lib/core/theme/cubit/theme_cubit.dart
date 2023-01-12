import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/shared_preferences/shared_preference_service.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/theme/data/theme_strings.dart';
import 'package:tumble/core/theme/repository/theme_repository.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            themeString: getIt<SharedPreferenceService>().theme!,
            locale: getIt<SharedPreferenceService>().locale == null
                ? null
                : Locale(getIt<SharedPreferenceService>().locale!),
            themeMode: ThemeMode.values.firstWhere((theme) =>
                theme.name == getIt<SharedPreferenceService>().theme)));

  final ThemePersistence themeRepository = getIt<ThemeRepository>();
  late StreamSubscription<String> _themeSubscription;
  late StreamSubscription<Locale?> _langSubscription;

  void getCurrentTheme() {
    _themeSubscription = themeRepository.getTheme().listen(updateTheme);
  }

  void getCurrentLang() {
    _langSubscription = themeRepository.getLocale().listen(updateLocale);
  }

  void updateTheme(String theme) {
    ThemeMode themeMode;
    switch (theme) {
      case ThemeType.light:
        themeMode = ThemeMode.light;
        break;
      case ThemeType.dark:
        themeMode = ThemeMode.dark;
        break;
      case ThemeType.system:
        themeMode = ThemeMode.system;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }
    emit(state.copyWith(themeMode: themeMode));
  }

  void updateLocale(Locale? locale) {
    emit(state.copyWithAllowNullLocale(locale: locale));
  }

  @override
  Future<void> close() {
    _themeSubscription.cancel();
    _langSubscription.cancel();
    themeRepository.dispose();
    return super.close();
  }
}
