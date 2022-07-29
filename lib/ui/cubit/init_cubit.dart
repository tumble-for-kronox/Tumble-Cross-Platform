import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/models/ui_models/school_model.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/shared/setup.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_navigation_root.dart';

import '../main_app_widget/login_page/login_page_root.dart';
import '../main_app_widget/main_app_navigation_root.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit()
      : super(const InitState(defaultSchool: null, status: InitStatus.INITIAL));

  final _implementationService = locator<ImplementationRepository>();
  final _sharedPrefs = locator<SharedPreferences>();

  Future<void> init() async {
    DatabaseResponse databaseResponse =
        await _implementationService.initSetup();
    switch (databaseResponse.status) {
      case Status.NO_SCHOOL:
        emit(const InitState(defaultSchool: null, status: InitStatus.INITIAL));
        break;
      case Status.HAS_SCHOOL:
        emit(InitState(
            defaultSchool: databaseResponse.data,
            status: InitStatus.HAS_SCHOOL));
        break;
    }
  }

  void changeSchool(BuildContext context, School school) {
    _sharedPrefs.clear();
    setupRequiredSharedPreferences();
    _sharedPrefs.setString(PreferenceTypes.school, school.schoolName);
    emit(InitState(
        defaultSchool: school.schoolName, status: InitStatus.HAS_SCHOOL));
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
            builder: (context) => const MainAppNavigationRootPage()),
        (Route<dynamic> route) => false);
  }

  void setup(BuildContext context, School school) async {
    if (school.loginRequired) {
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const LoginPageRoot()));
    } else {
      changeSchool(context, school);
    }
  }
}
