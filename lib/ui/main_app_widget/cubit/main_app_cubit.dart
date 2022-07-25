// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/models/ui_models/school_model.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/shared/setup.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/home_page_widget/data/schools.dart';
import 'package:tumble/ui/search_page_widgets/search/schedule_search_page.dart';

part 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  MainAppCubit() : super(const MainAppInitial());

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
        emit(MainAppSchoolSelectedAndDefault(
            currentScheduleId: _databaseResponse.data));
        break;
      case Status.HAS_DEFAULT:
        emit(const MainAppSchoolSelected());
        break;
    }
  }

  /// Set up when switching schools or starting
  /// app for the first time and picking a school
  void setup(String schoolName) async {
    setupRequiredSharedPreferences(schoolName);
  }

  void navigateToSearch(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const ScheduleSearchPage()),
        (Route<dynamic> route) => false);
  }
}
