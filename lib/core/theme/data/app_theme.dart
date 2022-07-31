import 'package:flutter/material.dart';
import 'package:tumble/core/theme/data/colors.dart';

abstract class AppTheme {
  static ThemeData get lightTheme =>
      ThemeData(colorScheme: CustomColors.lightColors);

  static ThemeData get darkTheme =>
      ThemeData(colorScheme: CustomColors.darkColors);
}
