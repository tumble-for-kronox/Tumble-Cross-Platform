part of 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit()
      : super(DrawerState(
            theme: getIt<SharedPreferences>()
                .getString(PreferenceTypes.theme)!
                .capitalize(),
            viewType: ScheduleViewTypes.viewTypesMap[
                getIt<SharedPreferences>().getInt(PreferenceTypes.view)],
            school:
                getIt<SharedPreferences>().getString(PreferenceTypes.school),
            bookmarks: getIt<SharedPreferences>()
                .getStringList(PreferenceTypes.bookmarks)!
                .map((e) => bookmarkedScheduleModelFromJson(e))
                .toList(),
            notificationTime: getIt<SharedPreferences>()
                .getInt(PreferenceTypes.notificationTime),
            mapOfIdToggles: {
              for (var bookmark in getIt<SharedPreferences>()
                  .getStringList(PreferenceTypes.bookmarks)!
                  .map((json) => bookmarkedScheduleModelFromJson(json)))
                bookmark.scheduleId: bookmark.toggledValue
            }));

  final _themeRepository = getIt<ThemeRepository>();
  final _sharedPrefs = getIt<SharedPreferences>();
  final _databaseService = getIt<SharedPreferences>();

  void changeTheme(String themeString) {
    emit(state.copyWith(theme: themeString.capitalize()));
    switch (themeString) {
      case "light":
        _themeRepository.saveTheme(CustomTheme.light);
        break;
      case "dark":
        _themeRepository.saveTheme(CustomTheme.dark);
        break;
      case "system":
        _themeRepository.saveTheme(CustomTheme.system);
        break;
      default:
        _themeRepository.saveTheme(CustomTheme.system);
        break;
    }
  }

  void setupForNextSchool(String schoolName) {
    emit(DrawerState(
        theme: getIt<SharedPreferences>()
            .getString(PreferenceTypes.theme)!
            .capitalize(),
        viewType: ScheduleViewTypes.viewTypesMap[
            getIt<SharedPreferences>().getInt(PreferenceTypes.view)],
        school: getIt<SharedPreferences>().getString(PreferenceTypes.school),
        bookmarks: getIt<SharedPreferences>()
            .getStringList(PreferenceTypes.bookmarks)!
            .map((e) => bookmarkedScheduleModelFromJson(e))
            .toList(),
        notificationTime:
            getIt<SharedPreferences>().getInt(PreferenceTypes.notificationTime),
        mapOfIdToggles: {
          for (var bookmark in getIt<SharedPreferences>()
              .getStringList(PreferenceTypes.bookmarks)!
              .map((json) => bookmarkedScheduleModelFromJson(json)))
            bookmark.scheduleId: bookmark.toggledValue
        }));
  }

  /// Toggle visibility of certain schedule via settings tab
  void toggleSchedule(String scheduleId, bool toggledValue) {
    List<BookmarkedScheduleModel> bookmarkedSchedules =
        getIt<SharedPreferences>()
            .getStringList(PreferenceTypes.bookmarks)!
            .map((json) => bookmarkedScheduleModelFromJson(json))
            .toList();

    bookmarkedSchedules
        .removeWhere((bookmark) => bookmark.scheduleId == scheduleId);

    bookmarkedSchedules.add(BookmarkedScheduleModel(
        scheduleId: scheduleId, toggledValue: toggledValue));

    getIt<SharedPreferences>().setStringList(PreferenceTypes.bookmarks,
        bookmarkedSchedules.map((bookmark) => jsonEncode(bookmark)).toList());

    emit(state.copyWith(bookmarks: bookmarkedSchedules, mapOfIdToggles: {
      for (var bookmark in getIt<SharedPreferences>()
          .getStringList(PreferenceTypes.bookmarks)!
          .map((json) => bookmarkedScheduleModelFromJson(json)))
        bookmark.scheduleId: bookmark.toggledValue
    }));
  }

  Future<void> removeBookmark(String id) async {
    final bookmarks = _sharedPrefs
        .getStringList(PreferenceTypes.bookmarks)!
        .map((e) => bookmarkedScheduleModelFromJson(e))
        .toList();
    bookmarks.removeWhere((bookmark) => bookmark.scheduleId == id);

    await _databaseService.remove(id);

    emit(state.copyWith(bookmarks: bookmarks, mapOfIdToggles: {
      for (var bookmark in getIt<SharedPreferences>()
          .getStringList(PreferenceTypes.bookmarks)!
          .map((json) => bookmarkedScheduleModelFromJson(json)))
        bookmark.scheduleId: bookmark.toggledValue
    }));
  }

  void setView(int viewType) {
    getIt<SharedPreferences>().setInt(PreferenceTypes.view, viewType);
    emit(state.copyWith(viewType: ScheduleViewTypes.viewTypesMap[viewType]));
  }

  void setNotificationTime(int time) async {
    SharedPreferences sharedPreferences = getIt<SharedPreferences>();
    sharedPreferences.setInt(PreferenceTypes.notificationTime, time);
    getIt<NotificationRepository>()
        .assignWithNewDuration(Duration(minutes: time));

    emit(state.copyWith(
        notificationTime: getIt<SharedPreferences>()
            .getInt(PreferenceTypes.notificationTime)));
  }

  void updateSchool(String schoolName) {
    emit(state.copyWith(school: schoolName));
  }

  bool getScheduleToggleValue(String scheduleId) {
    log(state.bookmarks!.toString());
    return state.bookmarks!
        .firstWhere((bookmark) => bookmark.scheduleId == scheduleId)
        .toggledValue;
  }
}
