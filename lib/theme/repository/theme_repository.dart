import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/startup/get_it_instances.dart';

abstract class ThemePersistense {
  Stream<CustomTheme> getTheme();
  Future<void> saveTheme(CustomTheme theme);
  void dispose();
}

enum CustomTheme { light, dark, system }

class ThemeRepository implements ThemePersistense {
  ThemeRepository() {
    _init();
  }

  final SharedPreferences _sharedPreferences = locator<SharedPreferences>();

  final _controller = StreamController<CustomTheme>();

  void _init() {
    final themeString = _sharedPreferences.getString(PreferenceTypes.theme);

    switch (themeString) {
      case "light":
        _controller.add(CustomTheme.light);
        break;
      case "dark":
        _controller.add(CustomTheme.dark);
        break;
      case "system":
        _controller.add(CustomTheme.system);
        break;
      default:
        _controller.add(CustomTheme.system);
        break;
    }
  }

  @override
  Stream<CustomTheme> getTheme() async* {
    yield* _controller.stream;
  }

  @override
  Future<void> saveTheme(CustomTheme theme) {
    _controller.add(theme);
    return _sharedPreferences.setString(PreferenceTypes.theme, theme.name);
  }

  @override
  void dispose() => _controller.close();
}
