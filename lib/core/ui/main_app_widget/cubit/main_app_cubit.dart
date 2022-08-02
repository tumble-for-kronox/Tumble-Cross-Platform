// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/implementation_repository.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/startup/get_it_instances.dart';
import 'package:tumble/core/api/apiservices/api_response.dart' as api;
import 'package:tumble/core/ui/scaffold_message.dart';
part 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  MainAppCubit()
      : super(const MainAppState(
            status: MainAppStatus.INITIAL,
            currentScheduleId: null,
            listOfDays: null,
            listOfWeeks: null,
            toggledFavorite: false,
            listViewToTopButtonVisible: false,
            message: null,
            scheduleModel: null));

  final _sharedPrefs = locator<SharedPreferences>();
  final _implementationService = locator<ImplementationRepository>();
  final _databaseService = locator<DatabaseRepository>();
  final ScrollController _listViewScrollController = ScrollController();

  ScrollController get controller => _listViewScrollController;
  SharedPreferences get sharedPrefs => _sharedPrefs;

  Future<void> toggleFavorite(BuildContext context) async {
    final currentFavorites =
        _sharedPrefs.getStringList(PreferenceTypes.favorites);

    /// If the schedule IS saved in preferences
    if (currentFavorites!.contains(state.currentScheduleId)) {
      _toggleRemove(currentFavorites);
      showScaffoldMessage(context, "Removed schedule from bookmarks");
    }

    /// If the schedule IS NOT saved in preferences
    else {
      _toggleSave(currentFavorites);
      showScaffoldMessage(context, "Saved schedule to bookmarks");
    }
  }

  void _toggleRemove(List<String> currentFavorites) async {
    currentFavorites.remove(state.currentScheduleId);
    (currentFavorites.isEmpty)
        ? _sharedPrefs.remove(PreferenceTypes.schedule)
        : _sharedPrefs.setString(
            PreferenceTypes.schedule, currentFavorites.first);
    await _databaseService.removeSchedule(state.currentScheduleId!);
    emit(state.copyWith(toggledFavorite: false));
    _sharedPrefs.setStringList(PreferenceTypes.favorites, currentFavorites);
  }

  void _toggleSave(List<String> currentFavorites) async {
    currentFavorites.add(state.currentScheduleId!);
    _sharedPrefs.setString(PreferenceTypes.schedule, state.currentScheduleId!);
    await _databaseService.addSchedule(state.scheduleModel!);
    emit(state.copyWith(toggledFavorite: true));

    _sharedPrefs.setStringList(PreferenceTypes.favorites, currentFavorites);
    log(locator<SharedPreferences>()
        .getStringList(PreferenceTypes.favorites)
        .toString());
  }

  Future<void> initCached() async {
    /// Prevents app from loading default schedule when state is changed
    if (state.currentScheduleId != null) {
      return;
    }
    final ApiResponse _apiResponse =
        await _implementationService.getCachedBookmarkedSchedule();

    switch (_apiResponse.status) {
      case ApiStatus.CACHED:
        ScheduleModel currentScheduleModel = _apiResponse.data!;
        if (currentScheduleModel.days
            .any((element) => element.events.isNotEmpty)) {
          emit(state.copyWith(
              status: MainAppStatus.SCHEDULE_SELECTED,
              currentScheduleId: currentScheduleModel.id,
              listOfDays: currentScheduleModel.days,
              listOfWeeks: currentScheduleModel.splitToWeek(),
              toggledFavorite: true,
              scheduleModel: currentScheduleModel));
        } else {
          emit(state.copyWith(status: MainAppStatus.EMPTY_SCHEDULE));
        }
        break;
      default:
        emit(state);
    }
  }

  /// ON program change
  Future<void> fetchNewSchedule(String id) async {
    final _apiResponse = await _implementationService.getSchedule(id);
    switch (_apiResponse.status) {
      case api.ApiStatus.REQUESTED:
        ScheduleModel currentScheduleModel = _apiResponse.data!;
        if (currentScheduleModel.days
            .any((element) => element.events.isNotEmpty)) {
          emit(state.copyWith(
              status: MainAppStatus.SCHEDULE_SELECTED,
              currentScheduleId: currentScheduleModel.id,
              listOfDays: currentScheduleModel.days,
              listOfWeeks: currentScheduleModel.splitToWeek(),
              toggledFavorite: false,
              scheduleModel: currentScheduleModel));
        } else {
          emit(state.copyWith(status: MainAppStatus.EMPTY_SCHEDULE));
        }
        break;
      case api.ApiStatus.CACHED:
        ScheduleModel currentScheduleModel = _apiResponse.data!;
        if (currentScheduleModel.days
            .any((element) => element.events.isNotEmpty)) {
          emit(state.copyWith(
              status: MainAppStatus.SCHEDULE_SELECTED,
              currentScheduleId: currentScheduleModel.id,
              listOfDays: currentScheduleModel.days,
              listOfWeeks: currentScheduleModel.splitToWeek(),
              toggledFavorite: true));
        } else {
          emit(state.copyWith(status: MainAppStatus.EMPTY_SCHEDULE));
        }
        break;
      case api.ApiStatus.ERROR:
        emit(state.copyWith(
            message: _apiResponse.message, status: MainAppStatus.FETCH_ERROR));
        break;
      default:
        emit(state);
        break;
    }
  }

  Future<void> initMainAppCubit() async {
    await initCached();
    _listViewScrollController.addListener((setScrollController));
  }

  setScrollController() {
    if (_listViewScrollController.offset >= 1000) {
      emit(state.copyWith(listViewToTopButtonVisible: true));
    } else {
      emit(state.copyWith(listViewToTopButtonVisible: false));
    }
  }

  void scrollToTop() {
    _listViewScrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  setLoading() {
    emit(state.copyWith(status: MainAppStatus.LOADING));
  }

  void setupForNextSchool() {
    emit(const MainAppState(
        status: MainAppStatus.INITIAL,
        currentScheduleId: null,
        listOfDays: null,
        listOfWeeks: null,
        toggledFavorite: false,
        listViewToTopButtonVisible: false,
        message: null,
        scheduleModel: null));
  }
}
