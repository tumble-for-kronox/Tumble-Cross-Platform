import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';

class SharedPreferenceService {
  final _sharedPreferences = getIt<SharedPreferences>();

  List<BookmarkedScheduleModel> get visibleBookmarkIds => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((json) => bookmarkedScheduleModelFromJson(json))
      .where((bookmark) => bookmark.toggledValue == true)
      .toList();

  String? get theme => _sharedPreferences.getString(PreferenceTypes.theme);

  String? get defaultSchool =>
      _sharedPreferences.getString(PreferenceTypes.school);

  List<String>? get bookmarkIds {
    if (_sharedPreferences.getStringList(PreferenceTypes.bookmarks) != null) {
      return _sharedPreferences
          .getStringList(PreferenceTypes.bookmarks)!
          .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
          .toList();
    }
    return null;
  }

  List<BookmarkedScheduleModel> get bookmarkScheduleModels => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((e) => bookmarkedScheduleModelFromJson(e))
      .toList();

  bool? get allowedNotifications =>
      _sharedPreferences.getBool(PreferenceTypes.notificationAllowed);

  bool get userHasBookmarks => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
      .toList()
      .isNotEmpty;

  bool bookmarksHasId(String scheduleId) => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
      .contains(scheduleId);

  int? get notificationOffset =>
      _sharedPreferences.getInt(PreferenceTypes.notificationOffset);

  bool? get autoSignup =>
      _sharedPreferences.getBool(PreferenceTypes.autoSignup);

  String? get locale => _sharedPreferences.getString(PreferenceTypes.locale);

  Future<void> setBookmarks(List<String> bookmarks) async {
    log(name: 'preference_repository', "Updating bookmarks ..");
    await _sharedPreferences.setStringList(
        PreferenceTypes.bookmarks, bookmarks);
  }

  Future<void> setSchool(String schoolName) async {
    log(
        name: 'preference_repository',
        "Changing default school to $schoolName ..");
    await _sharedPreferences.setString(PreferenceTypes.school, schoolName);
  }

  Future<void> setAutoSignup(bool autoSignup) async {
    log(
        name: 'preference_repository',
        "Changing autoSignup to be ${autoSignup ? 'on' : 'off'}..");
    await _sharedPreferences.setBool(PreferenceTypes.autoSignup, autoSignup);
  }

  Future<void> setNotificationAllowed(bool allowed) async {
    log(
        name: 'preference_repository',
        "Changing permission for notifications to be ${allowed ? 'allowed' : 'not allowed'}..");
    await _sharedPreferences.setBool(
        PreferenceTypes.notificationAllowed, allowed);
  }

  Future<void> setNotificationOffset(int offset) async {
    log(
        name: 'preference_repository',
        "Changing notification offset to $offset ..");
    await _sharedPreferences.setInt(PreferenceTypes.notificationOffset, offset);
  }

  Future<void> setTheme(String theme) async {
    log(name: 'preference_repository', "Changing theme to $theme mode ..");
    await _sharedPreferences.setString(PreferenceTypes.theme, theme);
  }

  Future<void> setLocale(String locale) async {
    log(name: 'preference_repository', "Changing locale to $locale ..");
    await _sharedPreferences.setString(PreferenceTypes.locale, locale);
  }

  Future<void> remove(String type) async {
    log(name: 'preference_repository', "Removed $type from preferences ..");
    await _sharedPreferences.remove(type);
  }

  bool? bookmarkVisible(String? id) => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((json) => bookmarkedScheduleModelFromJson(json))
      .firstWhereOrNull((bookmark) => bookmark.scheduleId == id)
      ?.toggledValue;

  bool bookmarksContainSchedule(String id) => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
      .contains(id);

  bool get hasRun =>
      _sharedPreferences.containsKey(PreferenceTypes.hasRun) &&
      _sharedPreferences.getBool(PreferenceTypes.hasRun)!;

  Future<void> setHasRun(bool hasRun) =>
      _sharedPreferences.setBool(PreferenceTypes.hasRun, hasRun);
}
