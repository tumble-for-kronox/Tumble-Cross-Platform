part of 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit(Locale locale)
      : super(DrawerState(
          locale: locale,
          theme: getIt<SharedPreferenceService>().theme!.capitalize(),
          school: getIt<SharedPreferenceService>().defaultSchool,
          bookmarks: getIt<SharedPreferenceService>().bookmarkScheduleModels,
          notificationTime: getIt<SharedPreferenceService>().notificationOffset,
          mapOfIdToggles: {
            for (var bookmark
                in getIt<SharedPreferenceService>().bookmarkScheduleModels)
              bookmark.scheduleId: bookmark.toggledValue
          },
        ));

  final textEditingControllerTitle = TextEditingController();
  final textEditingControllerBody = TextEditingController();
  final _themeRepository = getIt<ThemeRepository>();
  final _databaseService = getIt<DatabaseService>();
  final _preferenceService = getIt<SharedPreferenceService>();
  final _notificationService = getIt<NotificationService>();

  int get notificationOffset =>
      getIt<SharedPreferenceService>().notificationOffset!;

  bool isCurrentTheme(String theme) => _preferenceService.theme! == theme;

  void changeTheme(String themeString) {
    emit(state.copyWith(theme: themeString));
    _themeRepository.saveTheme(themeString);
  }

  Future<void> changeLocale(Locale? locale) async {
    log('${locale?.languageCode}');
    await _themeRepository.saveLocale(locale);
    emit(state.copyWith(locale: locale));
  }

  /// Toggle visibility of certain schedule via settings tab
  void toggleSchedule(String scheduleId, bool toggledValue) {
    List<BookmarkedScheduleModel> bookmarkedSchedules =
        getIt<SharedPreferenceService>().bookmarkScheduleModels;

    bookmarkedSchedules
        .removeWhere((bookmark) => bookmark.scheduleId == scheduleId);

    bookmarkedSchedules.add(BookmarkedScheduleModel(
        scheduleId: scheduleId, toggledValue: toggledValue));

    _preferenceService.setBookmarks(
        bookmarkedSchedules.map((bookmark) => jsonEncode(bookmark)).toList());

    emit(state.copyWith(bookmarks: bookmarkedSchedules, mapOfIdToggles: {
      for (var bookmark in _preferenceService.bookmarkScheduleModels)
        bookmark.scheduleId: bookmark.toggledValue
    }));
  }

  Future<void> removeBookmark(String id) async {
    final bookmarkScheduleModels = _preferenceService.bookmarkScheduleModels;
    bookmarkScheduleModels.removeWhere((bookmark) => bookmark.scheduleId == id);
    ScheduleModel? schedule = await _databaseService.getOneSchedule(id);
    List<String> courseIds = schedule!.days
        .expand((day) => day.events)
        .map((event) => event.course)
        .map((course) => course.id)
        .toSet()
        .toList();

    _preferenceService.setBookmarks(bookmarkScheduleModels
        .map((bookmark) => jsonEncode(bookmark))
        .toList());
    _notificationService.removeChannel(id);

    await _databaseService.removeCourseColors(courseIds);
    await _databaseService.remove(id, AccessStores.schedule_store);

    emit(state.copyWith(bookmarks: bookmarkScheduleModels, mapOfIdToggles: {
      for (var bookmark in _preferenceService.bookmarkScheduleModels)
        bookmark.scheduleId: bookmark.toggledValue
    }));
  }

  void setNotificationTime(int time) async {
    int oldOffset = _preferenceService.notificationOffset!;
    await _notificationService.assignAllNotificationsWithNewDuration(
        Duration(minutes: oldOffset), Duration(minutes: time));
    await _preferenceService.setNotificationOffset(time);

    emit(state.copyWith(
        notificationTime: _preferenceService.notificationOffset));
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
    return state.bookmarks!
        .firstWhere((bookmark) => bookmark.scheduleId == scheduleId)
        .toggledValue;
  }
}
