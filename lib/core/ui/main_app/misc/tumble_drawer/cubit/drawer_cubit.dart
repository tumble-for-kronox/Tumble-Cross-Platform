part of 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit()
      : super(DrawerState(
          theme: getIt<SharedPreferences>()
              .getString(PreferenceTypes.theme)!
              .capitalize(),
          viewType: ScheduleViewTypes.viewTypesMap[
              getIt<SharedPreferences>().getInt(PreferenceTypes.view)],
          school: getIt<SharedPreferences>().getString(PreferenceTypes.school),
          bookmarks: getIt<SharedPreferences>()
              .getStringList(PreferenceTypes.bookmarks),
          notificationTime: getIt<SharedPreferences>()
              .getInt(PreferenceTypes.notificationTime),
        ));

  final _themeRepository = getIt<ThemeRepository>();

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
        bookmarks:
            getIt<SharedPreferences>().getStringList(PreferenceTypes.bookmarks),
        notificationTime: getIt<SharedPreferences>()
            .getInt(PreferenceTypes.notificationTime)));
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
    emit(state.copyWith(
        bookmarks: bookmarkedSchedules
            .map((bookmark) => jsonEncode(bookmark))
            .toList()));
  }

  void setView(int viewType) {
    getIt<SharedPreferences>().setInt(PreferenceTypes.view, viewType);
    emit(state.copyWith(viewType: ScheduleViewTypes.viewTypesMap[viewType]));
  }

  void setNotificationTime(int time, ScheduleModel schedule) async {
    SharedPreferences sharedPreferences = getIt<SharedPreferences>();
    sharedPreferences.setInt(PreferenceTypes.notificationTime, time);
    getIt<NotificationRepository>()
        .assignWithNewDuration(Duration(minutes: time), schedule);

    emit(state.copyWith(
        notificationTime: getIt<SharedPreferences>()
            .getInt(PreferenceTypes.notificationTime)));
  }

  void updateSchool(String schoolName) {
    emit(state.copyWith(school: schoolName));
  }

  getScheduleToggleValue(String id) {}
}
