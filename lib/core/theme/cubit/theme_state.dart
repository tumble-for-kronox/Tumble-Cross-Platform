import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.themeString, required this.locale, required this.themeMode});

  final ThemeMode themeMode;
  final String themeString;
  final Locale? locale;

  ThemeState copyWith({ThemeMode? themeMode, Locale? locale}) => ThemeState(
        locale: locale ?? this.locale,
        themeMode: themeMode ?? this.themeMode,
        themeString: getIt<PreferenceRepository>().theme!,
      );

  ThemeState copyWithAllowNullLocale({ThemeMode? themeMode, Locale? locale}) => ThemeState(
        locale: locale,
        themeMode: themeMode ?? this.themeMode,
        themeString: getIt<PreferenceRepository>().theme!,
      );

  @override
  List<Object?> get props => [themeMode, themeString, locale];
}
