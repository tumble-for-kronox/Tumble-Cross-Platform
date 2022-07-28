part of 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit()
      : super(DrawerState(
            theme: locator<SharedPreferences>()
                .getString(PreferenceTypes.theme)!
                .capitalize,
            viewType: ScheduleViewTypes.viewTypesMap[
                locator<SharedPreferences>().getInt(PreferenceTypes.view)],
            schedule: locator<SharedPreferences>()
                .getString(PreferenceTypes.schedule),
            school: locator<SharedPreferences>()
                .getString(PreferenceTypes.school)));

  final _themeRepository = locator<ThemeRepository>();

  void handleDrawerEvent(Enum eventType, BuildContext context) {
    switch (eventType) {
      case EventType.CANCEL_ALL_NOTIFICATIONS:

        /// Cancel all notifications
        break;
      case EventType.CANCEL_NOTIFICATIONS_FOR_PROGRAM:

        /// Cancel all notifications tied to this schedule id
        break;
      case EventType.CHANGE_SCHOOL:
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const SchoolSelectionPage()),
        );
        break;
      case EventType.CHANGE_THEME:
        Get.bottomSheet(AppThemePicker(setTheme: (String themeType) {
          emit(state.copyWith(theme: themeType.capitalize));
          changeTheme(themeType);
          Navigator.of(context).pop();
        }));
        break;
      case EventType.CONTACT:

        /// Direct user to support page
        break;
      case EventType.EDIT_NOTIFICATION_TIME:
        Get.bottomSheet(AppNotificationTimePicker(
          setNotificationTime: (int time) => locator<SharedPreferences>()
              .setInt(PreferenceTypes.notificationTime, time),
        ));
        break;
      case EventType.SET_DEFAULT_SCHEDULE:
        final List<String>? bookmarks = locator<SharedPreferences>()
            .getStringList(PreferenceTypes.favorites);
        log(bookmarks.toString());
        if (bookmarks != null && bookmarks.isNotEmpty) {
          Get.bottomSheet(AppDefaultSchedulePicker(
              scheduleIds: bookmarks,
              setDefaultSchedule: (newId) {
                locator<SharedPreferences>()
                    .setString(PreferenceTypes.schedule, newId);
                emit(state.copyWith(schedule: newId));
                Navigator.of(context).pop();
              }));
        }
        break;
      case EventType.SET_DEFAULT_VIEW:
        Get.bottomSheet(AppDefaultViewPicker(
          setDefaultView: (viewType) {
            locator<SharedPreferences>().setInt(PreferenceTypes.view, viewType);
            emit(state.copyWith(
                viewType: ScheduleViewTypes.viewTypesMap[viewType]));
            Navigator.of(context).pop();
          },
        ));
        break;
    }
  }

  void changeTheme(String themeString) {
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

  void setNameForNextSchool(String schoolName) {
    emit(state.copyWith(school: schoolName));
  }

  void refresh() {
    emit(DrawerState(
        theme: locator<SharedPreferences>()
            .getString(PreferenceTypes.theme)!
            .capitalize,
        viewType: ScheduleViewTypes.viewTypesMap[
            locator<SharedPreferences>().getInt(PreferenceTypes.view)],
        schedule:
            locator<SharedPreferences>().getString(PreferenceTypes.schedule),
        school:
            locator<SharedPreferences>().getString(PreferenceTypes.school)));
  }
}
