// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/database/database_response.dart' as db;
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/extensions/extensions.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/models/ui_models/week_model.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/theme/cubit/theme_cubit.dart';
import 'package:tumble/theme/repository/theme_repository.dart';
import 'package:tumble/ui/drawer_generic/app_default_schedule_picker.dart';
import 'package:tumble/ui/drawer_generic/app_notification_time_picker.dart';
import 'package:tumble/ui/drawer_generic/app_theme_picker.dart';
import 'package:tumble/ui/main_app_widget/data/event_types.dart';
import 'package:tumble/ui/main_app_widget/school_selection_page.dart';
import 'package:tumble/api/apiservices/api_response.dart' as api;
part 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  MainAppCubit() : super(const MainAppInitial(null));

  final _sharedPrefs = locator<SharedPreferences>();
  final _implementationService = locator<ImplementationRepository>();
  final _databaseService = locator<DatabaseRepository>();
  final _themeRepository = locator<ThemeRepository>();

  ScheduleModel? _currentScheduleModel;
  String? _currentScheduleId;

  List<Week>? _listOfWeeks;
  List<Day>? _listOfDays;

  int? get defaultViewType => locator<SharedPreferences>().getInt(PreferenceTypes.view);

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
        Get.bottomSheet(AppThemePicker(
          setTheme: (themeType) => changeTheme(themeType),
        ));
        break;
      case EventType.CONTACT:

        /// Direct user to support page
        break;
      case EventType.EDIT_NOTIFICATION_TIME:
        Get.bottomSheet(AppNotificationTimePicker(
          setNotificationTime: (int time) =>
              locator<SharedPreferences>().setInt(PreferenceTypes.notificationTime, time),
        ));
        break;
      case EventType.SET_DEFAULT_SCHEDULE:
        Get.bottomSheet(AppDefaultSchedulePicker(
            scheduleIds: locator<SharedPreferences>().getStringList(PreferenceTypes.favorites)));
        break;
      case EventType.SET_DEFAULT_VIEW:
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

  Future<void> toggleFavorite() async {
    final currentFavorites = _sharedPrefs.getStringList(PreferenceTypes.favorites);

    /// If the schedule IS saved in preferences
    if (currentFavorites!.contains(_currentScheduleId)) {
      _toggleRemove(currentFavorites);
    }

    /// If the schedule IS NOT saved in preferences
    else {
      _toggleSave(currentFavorites);
    }
  }

  void _toggleSave(List<String> currentFavorites) async {
    currentFavorites.add(_currentScheduleId!);
    _sharedPrefs.setString(PreferenceTypes.schedule, _currentScheduleId!);
    await _databaseService.addSchedule(_currentScheduleModel!);
    emit(MainAppScheduleSelected(
        currentScheduleId: _currentScheduleModel!.id,
        listOfDays: _listOfDays!,
        listOfWeeks: _listOfWeeks!,
        toggledFavorite: true));
    _sharedPrefs.setStringList(PreferenceTypes.favorites, currentFavorites);
  }

  Future<void> init() async {
    emit(const MainAppLoading());
    if (_sharedPrefs.getString(PreferenceTypes.schedule) != null) {
      final _response = await _implementationService.getSchedule(_sharedPrefs.getString(PreferenceTypes.schedule)!);
      switch (_response.status) {
        case api.Status.REQUESTED:
          _currentScheduleModel = _response.data!;

          /// Now we have an instance of the list used in
          /// [TumbleListView] and an instance of the list
          /// used in [TumbleWeekView]
          _listOfDays = _currentScheduleModel!.days;
          _listOfWeeks = _currentScheduleModel!.splitToWeek();
          _currentScheduleId = _currentScheduleModel!.id;
          emit(MainAppScheduleSelected(
              currentScheduleId: _currentScheduleModel!.id,
              listOfDays: _listOfDays!,
              listOfWeeks: _listOfWeeks!,
              toggledFavorite: false));
          break;
        case api.Status.CACHED:
          _currentScheduleModel = _response.data!;

          /// Now we have an instance of the list used in
          /// [TumbleListView] and an instance of the list
          /// used in [TumbleWeekView]
          _listOfDays = _currentScheduleModel!.days;
          _listOfWeeks = _currentScheduleModel!.splitToWeek();
          _currentScheduleId = _currentScheduleModel!.id;
          emit(MainAppScheduleSelected(
              currentScheduleId: _currentScheduleModel!.id,
              listOfDays: _listOfDays!,
              listOfWeeks: _listOfWeeks!,
              toggledFavorite: true));
          break;
        case api.Status.ERROR:
          emit(MainAppInitial(_response.message!));
          break;
        default:
          emit(const MainAppInitial(null));
          break;
      }

    }
  }

  /// ON program change
  Future<void> fetchNewSchedule(String id) async {
    final _response = await _implementationService.getSchedule(id);
    switch (_response.status) {
      case api.Status.REQUESTED:
        _currentScheduleModel = _response.data!;

        /// Now we have an instance of the list used in
        /// [TumbleListView] and an instance of the list
        /// used in [TumbleWeekView]
        _listOfDays = _currentScheduleModel!.days;
        _listOfWeeks = _currentScheduleModel!.splitToWeek();
        _currentScheduleId = _currentScheduleModel!.id;
        log('Selected schedule id: $id');
        emit(MainAppScheduleSelected(
            currentScheduleId: _currentScheduleId!,
            listOfDays: _listOfDays!,
            listOfWeeks: _listOfWeeks!,
            toggledFavorite: false));
        break;
      case api.Status.CACHED:
        _currentScheduleModel = _response.data!;

        /// Now we have an instance of the list used in
        /// [TumbleListView] and an instance of the list
        /// used in [TumbleWeekView]
        _listOfDays = _currentScheduleModel!.days;
        _listOfWeeks = _currentScheduleModel!.splitToWeek();
        _currentScheduleId = _currentScheduleModel!.id;
        emit(MainAppScheduleSelected(
            currentScheduleId: _currentScheduleId!,
            listOfDays: _listOfDays!,
            listOfWeeks: _listOfWeeks!,
            toggledFavorite: true));
        break;
      case api.Status.ERROR:
        emit(MainAppInitial(_response.message!));
        break;
      default:
        emit(state);
        break;
    }
  }

  void setLoading() {
    emit(const MainAppLoading());
  }
}
