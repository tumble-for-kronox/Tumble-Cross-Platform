import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/theme/repository/theme_repository.dart';
import '../../shared/preference_types.dart';
import '../../dependency_injection/get_it_instances.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            themeString: getIt<SharedPreferences>()
                .getString(PreferenceTypes.theme)!
                .capitalize(),
            locale:
                getIt<SharedPreferences>().getString(PreferenceTypes.locale) ==
                        null
                    ? null
                    : Locale(getIt<SharedPreferences>()
                        .getString(PreferenceTypes.locale)!)));

  final ThemePersistense themeRepository = getIt<ThemeRepository>();
  late StreamSubscription<CustomTheme> _themeSubscription;
  late StreamSubscription<Locale?> _langSubscription;

  void getCurrentTheme() {
    _themeSubscription = themeRepository.getTheme().listen(updateTheme);
  }

  void getCurrentLang() {
    _langSubscription = themeRepository.getLocale().listen(updateLocale);
  }

  void updateTheme(CustomTheme theme) {
    switch (theme) {
      case CustomTheme.light:
        emit(state.copyWith(themeMode: ThemeMode.light));
        break;
      case CustomTheme.dark:
        emit(state.copyWith(themeMode: ThemeMode.dark));
        break;
      case CustomTheme.system:
        emit(state.copyWith(themeMode: ThemeMode.system));
        break;
      default:
        emit(state.copyWith(themeMode: ThemeMode.light));
        break;
    }
  }

  void updateLocale(Locale? locale) {
    log("CHANGING LOCALE!");
    log((locale?.toLanguageTag()).toString());
    emit(state.copyWith(locale: locale));
  }

  @override
  Future<void> close() {
    _themeSubscription.cancel();
    themeRepository.dispose();
    return super.close();
  }
}
