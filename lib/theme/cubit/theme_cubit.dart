import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/extensions/extensions.dart';
import 'package:tumble/theme/cubit/theme_state.dart';
import 'package:tumble/theme/repository/theme_repository.dart';
import '../../shared/preference_types.dart';
import '../../startup/get_it_instances.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            themeString: locator<SharedPreferences>()
                .getString(PreferenceTypes.theme)!
                .capitalize()));

  final ThemePersistense themeRepository = locator<ThemeRepository>();
  late StreamSubscription<CustomTheme> _themeSubscription;

  void getCurrentTheme() {
    _themeSubscription = themeRepository.getTheme().listen((customTheme) {
      switch (customTheme) {
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
    });
  }

  @override
  Future<void> close() {
    _themeSubscription.cancel();
    themeRepository.dispose();
    return super.close();
  }
}
