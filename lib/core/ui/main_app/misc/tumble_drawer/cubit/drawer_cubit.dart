part of 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit()
      : super(DrawerState(
            theme: getIt<SharedPreferences>()
                .getString(PreferenceTypes.theme)!
                .capitalize(),
            viewType: ScheduleViewTypes.viewTypesMap[
                getIt<SharedPreferences>().getInt(PreferenceTypes.view)],
            schedule: getIt<SharedPreferences>()
                .getString(PreferenceTypes.schedule),
            school:
                getIt<SharedPreferences>().getString(PreferenceTypes.school),
            bookmarks: getIt<SharedPreferences>()
                .getStringList(PreferenceTypes.favorites)));

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
        schedule:
            getIt<SharedPreferences>().getString(PreferenceTypes.schedule),
        school: getIt<SharedPreferences>().getString(PreferenceTypes.school),
        bookmarks: getIt<SharedPreferences>()
            .getStringList(PreferenceTypes.favorites)));
  }

  void setSchedule(String newId) {
    getIt<SharedPreferences>().setString(PreferenceTypes.schedule, newId);
    emit(state.copyWith(schedule: newId));
  }

  void setView(int viewType) {
    getIt<SharedPreferences>().setInt(PreferenceTypes.view, viewType);
    emit(state.copyWith(viewType: ScheduleViewTypes.viewTypesMap[viewType]));
  }

  void updateSchool(String schoolName) {
    emit(state.copyWith(school: schoolName));
  }
}
