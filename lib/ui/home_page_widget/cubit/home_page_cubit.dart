// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/database/database.dart';
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/extensions/extensions.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/models/ui_models/week_model.dart';
import 'package:tumble/startup/get_it_instances.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageInitial());

  final _databaseService = locator<DatabaseRepository>();
  late int _defaultViewType;
  int _currentPageIndex = 0;
  final List<HomePageState> _pages = [
    const HomePageListView(),
    const HomePageWeekView()
  ];
  final _implementationService = locator<ImplementationRepository>();
  List<Week>? _schedulesWeekView;
  List<Day>? _schedulesListView;

  int get defaultViewType => _defaultViewType;
  int get currentPageIndex => _currentPageIndex;

  /// Handles the loading of the schedule upon choosing a program
  Future<void> init(String scheduleId) async {
    emit(const HomePageLoading());
    _defaultViewType = await _databaseService.getDefaultViewType();
    _currentPageIndex = _defaultViewType;
    final _schedule = await _implementationService.getSchedule(scheduleId);

    if (_schedule is ApiResponse) {
      switch (_schedule.status) {
        case Status.COMPLETED:
          final ScheduleModel scheduleModel = _schedule.data as ScheduleModel;

          /// Now we have an instance of the list used in
          /// [TumbleListView] and an instance of the list
          /// used in [TumbleWeekView]
          _schedulesListView = scheduleModel.days;
          _schedulesWeekView = scheduleModel.weekSplit();
          switch (_defaultViewType) {
            case 0:
              emit(HomePageListView(
                  scheduleId: scheduleId, listView: _schedulesListView));
              break;
            case 1:
              emit(HomePageWeekView(
                  scheduleId: scheduleId, weekView: _schedulesWeekView));
          }
          break;
        case Status.ERROR:
          emit(const HomePageError());
          break;
        default:
          emit(const HomePageInitial());
          break;
      }
    }
  }

  void setPage(int index) {
    _currentPageIndex = index;
    if (state is! HomePageError) {
      emit(_pages[index]);
    }
  }
}
