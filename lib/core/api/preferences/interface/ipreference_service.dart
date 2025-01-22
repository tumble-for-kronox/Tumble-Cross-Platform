import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';

abstract class IPreferenceService {
  List<BookmarkedScheduleModel> get visibleBookmarkIds;
  List<String>? get bookmarkIds;
  List<BookmarkedScheduleModel> get bookmarkScheduleModels;
  String? get defaultSchool;
  int? get notificationOffset;
  String? get theme;
  String? get locale;
  bool get hasRun;
  bool bookmarksHasId(String scheduleId);
  Future<void> setBookmarks(List<String> bookmarks);
  Future<void> setSchool(String schoolName);
  Future<void> setTheme(String theme);
  Future<void> setNotificationOffset(int offset);
  Future<void> setNotificationAllowed(bool allowed);
  Future<void> setLocale(String locale);
  Future<void> setHasRun(bool hasRun);
  Future<void> remove(String type);
  bool? bookmarkVisible(String? id);
  bool bookmarksContainSchedule(String id);
}
