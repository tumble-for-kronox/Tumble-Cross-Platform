import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.themeString, required this.locale, required this.themeMode});

  final ThemeMode themeMode;
  final String themeString;
  final Locale? locale;

  ThemeState copyWith({ThemeMode? themeMode, Locale? locale}) => ThemeState(
        locale: locale ?? this.locale,
        themeMode: themeMode ?? this.themeMode,
        themeString: getIt<SharedPreferences>().getString(PreferenceTypes.theme)!,
      );

  ThemeState copyWithAllowNullLocale({ThemeMode? themeMode, Locale? locale}) => ThemeState(
        locale: locale,
        themeMode: themeMode ?? this.themeMode,
        themeString: getIt<SharedPreferences>().getString(PreferenceTypes.theme)!,
      );

  @override
  List<Object?> get props => [themeMode, themeString, locale];
}
