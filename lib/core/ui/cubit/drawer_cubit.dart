part of 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit(Locale locale)
      : super(DrawerState(
          locale: locale,
          theme: getIt<PreferenceRepository>().theme!.capitalize(),
          school: getIt<PreferenceRepository>().defaultSchool,
          bookmarks: getIt<PreferenceRepository>().bookmarkScheduleModels,
          notificationTime: getIt<PreferenceRepository>().notificationOffset,
          mapOfIdToggles: {
            for (var bookmark in getIt<PreferenceRepository>().bookmarkScheduleModels)
              bookmark.scheduleId: bookmark.toggledValue
          },
        ));

  final textEditingControllerTitle = TextEditingController();
  final textEditingControllerBody = TextEditingController();
  final _themeRepository = getIt<ThemeRepository>();
  final _databaseService = getIt<DatabaseRepository>();
  final _preferenceService = getIt<PreferenceRepository>();
  final _notificationService = getIt<NotificationRepository>();

  int get notificationOffset => getIt<PreferenceRepository>().notificationOffset!;

  bool isCurrentTheme(String theme) => _preferenceService.theme! == theme;

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
    log('${locale?.languageCode}');
    await _themeRepository.saveLocale(locale);
    emit(state.copyWith(locale: locale));
  }

  /// Toggle visibility of certain schedule via settings tab
  void toggleSchedule(String scheduleId, bool toggledValue) {
    List<BookmarkedScheduleModel> bookmarkedSchedules = getIt<PreferenceRepository>().bookmarkScheduleModels;

    bookmarkedSchedules.removeWhere((bookmark) => bookmark.scheduleId == scheduleId);

    bookmarkedSchedules.add(BookmarkedScheduleModel(scheduleId: scheduleId, toggledValue: toggledValue));

    _preferenceService.setBookmarks(bookmarkedSchedules.map((bookmark) => jsonEncode(bookmark)).toList());

    emit(state.copyWith(bookmarks: bookmarkedSchedules, mapOfIdToggles: {
      for (var bookmark in _preferenceService.bookmarkScheduleModels) bookmark.scheduleId: bookmark.toggledValue
    }));
  }

  Future<void> removeBookmark(String id) async {
    final bookmarkScheduleModels = _preferenceService.bookmarkScheduleModels;
    bookmarkScheduleModels.removeWhere((bookmark) => bookmark.scheduleId == id);

    _preferenceService.setBookmarks(bookmarkScheduleModels.map((bookmark) => jsonEncode(bookmark)).toList());

    await _databaseService.remove(id, AccessStores.SCHEDULE_STORE);
    await _databaseService.remove(id, AccessStores.COURSE_COLOR_STORE);

    emit(state.copyWith(bookmarks: bookmarkScheduleModels, mapOfIdToggles: {
      for (var bookmark in _preferenceService.bookmarkScheduleModels) bookmark.scheduleId: bookmark.toggledValue
    }));
  }

  void setNotificationTime(int time) async {
    int oldOffset = _preferenceService.notificationOffset!;
    await _notificationService.assignAllNotificationsWithNewDuration(
        Duration(minutes: oldOffset), Duration(minutes: time));
    await _preferenceService.setNotificationOffset(time);

    emit(state.copyWith(notificationTime: _preferenceService.notificationOffset));
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
      for (var item in const [
        Locale('en'),
        Locale('sv'),
        Locale('fr'),
        Locale('de'),
        Locale('zh'),
      ])
        LocaleNames.getDisplayLanguage(item.languageCode): item
    });
    //  AppLocalizations.supportedLocales
    return localeMap;
  }

  bool getScheduleToggleValue(String scheduleId) {
    return state.bookmarks!.firstWhere((bookmark) => bookmark.scheduleId == scheduleId).toggledValue;
  }
}
