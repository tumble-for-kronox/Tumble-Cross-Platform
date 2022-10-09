part of 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit(Locale locale)
      : super(DrawerState(
          locale: locale,
          theme: getIt<SharedPreferences>()
              .getString(PreferenceTypes.theme)!
              .capitalize(),
          school: getIt<SharedPreferences>().getString(PreferenceTypes.school),
          bookmarks: getIt<SharedPreferences>()
              .getStringList(PreferenceTypes.bookmarks)!
              .map((e) => bookmarkedScheduleModelFromJson(e))
              .toList(),
          notificationTime: getIt<SharedPreferences>()
              .getInt(PreferenceTypes.notificationOffset),
          mapOfIdToggles: {
            for (var bookmark in getIt<SharedPreferences>()
                .getStringList(PreferenceTypes.bookmarks)!
                .map((json) => bookmarkedScheduleModelFromJson(json)))
              bookmark.scheduleId: bookmark.toggledValue
          },
        ));

  final textEditingControllerTitle = TextEditingController();
  final textEditingControllerBody = TextEditingController();
  final _themeRepository = getIt<ThemeRepository>();
  final _databaseService = getIt<DatabaseRepository>();

  void changeTheme(String themeString) {
    emit(state.copyWith(theme: themeString));
    switch (themeString) {
      case ThemeType.light:
        _themeRepository.saveTheme(ThemeType.light);
        break;
      case ThemeType.dark:
        _themeRepository.saveTheme(ThemeType.dark);
        break;
      case ThemeType.system:
        _themeRepository.saveTheme(ThemeType.system);
        break;
      default:
        _themeRepository.saveTheme(ThemeType.system);
        break;
    }
  }

  Future<void> changeLocale(Locale? locale) async {
    await _themeRepository.saveLocale(locale);
    emit(state.copyWith(locale: locale));
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
    final bookmarks = getIt<SharedPreferences>()
        .getStringList(PreferenceTypes.bookmarks)!
        .map((e) => bookmarkedScheduleModelFromJson(e))
        .toList();
    bookmarks.removeWhere((bookmark) => bookmark.scheduleId == id);

    getIt<SharedPreferences>().setStringList(PreferenceTypes.bookmarks,
        bookmarks.map((bookmark) => jsonEncode(bookmark)).toList());

    await _databaseService.remove(id, AccessStores.SCHEDULE_STORE);
    await _databaseService.remove(id, AccessStores.COURSE_COLOR_STORE);

    emit(state.copyWith(bookmarks: bookmarks, mapOfIdToggles: {
      for (var bookmark in getIt<SharedPreferences>()
          .getStringList(PreferenceTypes.bookmarks)!
          .map((json) => bookmarkedScheduleModelFromJson(json)))
        bookmark.scheduleId: bookmark.toggledValue
    }));
  }

  void setNotificationTime(int time) async {
    getIt<SharedPreferences>().setInt(PreferenceTypes.notificationOffset, time);
    getIt<NotificationRepository>()
        .assignAllNotificationsWithNewDuration(Duration(minutes: time));

    emit(state.copyWith(
        notificationTime: getIt<SharedPreferences>()
            .getInt(PreferenceTypes.notificationOffset)));
  }

  Map<String, int> getNotificationTimes(BuildContext context) {
    return {
      S.settingsPage.offsetTime(15): 15,
      S.settingsPage.offsetTime(30): 30,
      S.settingsPage.offsetTime(60): 60,
      S.settingsPage.offsetTime(180): 180
    };
  }

  Map<String, Locale?> getLangOptions() {
    Map<String, Locale?> localeMap = {
      "System Language": null,
    };

    localeMap.addAll({
      for (var item in AppLocalizations.supportedLocales)
        LocaleNames.getDisplayLanguage(item.languageCode): item
    });

    return localeMap;
  }

  bool getScheduleToggleValue(String scheduleId) {
    return state.bookmarks!
        .firstWhere((bookmark) => bookmark.scheduleId == scheduleId)
        .toggledValue;
  }
}
