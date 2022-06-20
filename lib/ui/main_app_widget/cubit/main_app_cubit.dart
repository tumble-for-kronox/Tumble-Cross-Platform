// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/database/database.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/models/ui_models/school_model.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/home_page_widget/data/schools.dart';

part 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  MainAppCubit() : super(const MainAppInitial());

  final _databaseService = locator<DatabaseRepository>();
  final _implementationService = locator<ImplementationRepository>();
  final List<School> _schools = Schools.schools;

  List<School> get schools => _schools;

  Future<void> init() async {
    DatabaseResponse _databaseResponse =
        await _implementationService.initSetup();
    switch (_databaseResponse.status) {
      case Status.INITIAL:
        emit(const MainAppInitial());
        break;
      case Status.HAS_FAVORITE:
        String _scheduleId = (_databaseResponse.data as ScheduleData).id;
        emit(MainAppSchoolSelectedAndDefault(currentScheduleId: _scheduleId));
        break;
      case Status.HAS_DEFAULT:
        emit(const MainAppSchoolSelected());
        break;
    }
  }

  /// Set up when switching schools or starting
  /// app for the first time
  void setup(String school) async {
    log("Setup");
    _implementationService.schoolReset(school);
  }
}
