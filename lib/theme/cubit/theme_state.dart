import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/extensions/extensions.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/startup/get_it_instances.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.themeString, this.themeMode = ThemeMode.system});

  final ThemeMode themeMode;
  final String themeString;

  ThemeState copyWith({ThemeMode? themeMode}) => ThemeState(
        themeMode: themeMode ?? this.themeMode,
        themeString: locator<SharedPreferences>().getString(PreferenceTypes.theme)!.capitalize(),
      );

  @override
  List<Object?> get props => [themeMode, themeString];
}
