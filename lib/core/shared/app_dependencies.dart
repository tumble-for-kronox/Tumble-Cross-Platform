import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/repository/notification_repository.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/shared/view_types.dart';

class AppDependencies {
  ///
  /// Initializes preferences and notification channels for user.
  /// Application depends on these values.

  /// [schoolname] -> Name of school
  /// [theme] -> Theme (dark, light, system)
  /// [notificationOffset] -> Offset time for notifications
  /// [autoSignup] -> If user selected auto signup for exams
  ///
  Future<void> initDependencies({String? schoolName, String? theme, int? notificationOffset, bool? autoSignup}) async {
    await getIt<NotificationRepository>().initialize();
    _setupSharedPreferences(schoolName, theme, notificationOffset, autoSignup);
  }

  void _setupSharedPreferences(String? schoolName, String? theme, int? notificationOffset, bool? autoSignup) {
    final preferenceService = getIt<SharedPreferences>();

    preferenceService.setString(PreferenceTypes.theme, theme ?? 'system');
    preferenceService.setInt(PreferenceTypes.view, ScheduleViewTypes.list);
    preferenceService.setInt(PreferenceTypes.notificationOffset, notificationOffset ?? 60);
    preferenceService.setBool(PreferenceTypes.autoSignup, autoSignup ?? false);

    if (schoolName != null) {
      preferenceService.setString(PreferenceTypes.school, schoolName);
    }

    /// Checks if the calling function is main() and only set bookmarks to empty
    /// list if bookmarks in Shared Preferences hasn't been set
    if (preferenceService.getStringList(PreferenceTypes.bookmarks) == null) {
      preferenceService.setStringList(PreferenceTypes.bookmarks, <String>[]);
    }
  }
}
