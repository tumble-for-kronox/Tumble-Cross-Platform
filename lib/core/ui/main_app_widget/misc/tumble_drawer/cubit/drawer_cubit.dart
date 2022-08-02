part of 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit()
      : super(DrawerState(
            theme: locator<SharedPreferences>()
                .getString(PreferenceTypes.theme)!
                .capitalize(),
            viewType: ScheduleViewTypes.viewTypesMap[
                locator<SharedPreferences>().getInt(PreferenceTypes.view)],
            schedule: locator<SharedPreferences>()
                .getString(PreferenceTypes.schedule),
            school:
                locator<SharedPreferences>().getString(PreferenceTypes.school),
            bookmarks: locator<SharedPreferences>()
                .getStringList(PreferenceTypes.favorites)));

  final _themeRepository = locator<ThemeRepository>();

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
    emit(state.copyWith(school: schoolName, bookmarks: []));
  }

  void setSchedule(String newId) {
    locator<SharedPreferences>().setString(PreferenceTypes.schedule, newId);
    emit(state.copyWith(schedule: newId));
  }

  void setView(int viewType) {
    locator<SharedPreferences>().setInt(PreferenceTypes.view, viewType);
    emit(state.copyWith(viewType: ScheduleViewTypes.viewTypesMap[viewType]));
  }

  void updateSchool(String schoolName) {
    emit(state.copyWith(school: schoolName));
  }
}
