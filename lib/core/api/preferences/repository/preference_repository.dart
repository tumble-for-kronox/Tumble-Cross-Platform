import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/preferences/interface/ipreference_service.dart';
import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';

class PreferenceRepository implements IPreferenceService {
  final _sharedPreferences = getIt<SharedPreferences>();

  @override
  List<BookmarkedScheduleModel> get visibleBookmarkIds => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((json) => bookmarkedScheduleModelFromJson(json))
      .where((bookmark) => bookmark.toggledValue == true)
      .toList();

  @override
  String? get theme => _sharedPreferences.getString(PreferenceTypes.theme);

  @override
  String? get defaultSchool => _sharedPreferences.getString(PreferenceTypes.school);

  @override
  List<String>? get bookmarkIds {
    if (_sharedPreferences.getStringList(PreferenceTypes.bookmarks) != null) {
      return _sharedPreferences
          .getStringList(PreferenceTypes.bookmarks)!
          .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
          .toList();
    }
    return null;
  }

  @override
  List<BookmarkedScheduleModel> get bookmarkScheduleModels => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((e) => bookmarkedScheduleModelFromJson(e))
      .toList();

  bool? get allowedNotifications => _sharedPreferences.getBool(PreferenceTypes.notificationAllowed);

  bool get userHasBookmarks => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
      .toList()
      .isNotEmpty;

  @override
  bool bookmarksHasId(String scheduleId) => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
      .contains(scheduleId);

  @override
  int? get notificationOffset => _sharedPreferences.getInt(PreferenceTypes.notificationOffset);

  @override
  bool? get autoSignup => _sharedPreferences.getBool(PreferenceTypes.autoSignup);

  @override
  String? get locale => _sharedPreferences.getString(PreferenceTypes.locale);

  @override
  Future<void> setBookmarks(List<String> bookmarks) async {
    log(name: 'preference_repository', "Updating bookmarks ..");
    await _sharedPreferences.setStringList(PreferenceTypes.bookmarks, bookmarks);
  }

  @override
  Future<void> setSchool(String schoolName) async {
    log(name: 'preference_repository', "Changing default school to $schoolName ..");
    await _sharedPreferences.setString(PreferenceTypes.school, schoolName);
  }

  @override
  Future<void> setAutoSignup(bool autoSignup) async {
    log(name: 'preference_repository', "Changing autoSignup to be ${autoSignup ? 'on' : 'off'}..");
    await _sharedPreferences.setBool(PreferenceTypes.autoSignup, autoSignup);
  }

  @override
  Future<void> setNotificationAllowed(bool allowed) async {
    log(
        name: 'preference_repository',
        "Changing permission for notifications to be ${allowed ? 'allowed' : 'not allowed'}..");
    await _sharedPreferences.setBool(PreferenceTypes.notificationAllowed, allowed);
  }

  @override
  Future<void> setNotificationOffset(int offset) async {
    log(name: 'preference_repository', "Changing notification offset to $offset ..");
    await _sharedPreferences.setInt(PreferenceTypes.notificationOffset, offset);
  }

  @override
  Future<void> setTheme(String theme) async {
    log(name: 'preference_repository', "Changing theme to $theme mode ..");
    await _sharedPreferences.setString(PreferenceTypes.theme, theme);
  }

  @override
  Future<void> setLocale(String locale) async {
    log(name: 'preference_repository', "Changing locale to $locale ..");
    await _sharedPreferences.setString(PreferenceTypes.locale, locale);
  }

  @override
  Future<void> remove(String type) async {
    log(name: 'preference_repository', "Removed $type from preferences ..");
    await _sharedPreferences.remove(type);
  }

  @override
  bool? bookmarkVisible(String? id) => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((json) => bookmarkedScheduleModelFromJson(json))
      .firstWhereOrNull((bookmark) => bookmark.scheduleId == id)
      ?.toggledValue;

  @override
  bool bookmarksContainSchedule(String id) => _sharedPreferences
      .getStringList(PreferenceTypes.bookmarks)!
      .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
      .contains(id);
}
