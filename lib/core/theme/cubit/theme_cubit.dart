import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/theme/data/theme_strings.dart';
import 'package:tumble/core/theme/repository/theme_repository.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            themeString: getIt<PreferenceRepository>().theme!,
            locale: getIt<PreferenceRepository>().locale == null ? null : Locale(getIt<PreferenceRepository>().locale!),
            themeMode: ThemeMode.values.firstWhere((theme) => theme.name == getIt<PreferenceRepository>().theme)));

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
    switch (theme) {
      case ThemeType.light:
        emit(state.copyWith(themeMode: ThemeMode.light));
        break;
      case ThemeType.dark:
        emit(state.copyWith(themeMode: ThemeMode.dark));
        break;
      case ThemeType.system:
        emit(state.copyWith(themeMode: ThemeMode.system));
        break;
      default:
        emit(state.copyWith(themeMode: ThemeMode.light));
        break;
    }
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
