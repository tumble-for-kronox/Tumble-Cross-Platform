import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/shared/setup.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_navigation_root.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit()
      : super(const InitState(defaultSchool: null, status: InitStatus.INITIAL));

  final _implementationService = locator<ImplementationRepository>();

  Future<void> init() async {
    log('here');
    DatabaseResponse databaseResponse =
        await _implementationService.initSetup();
    switch (databaseResponse.status) {
      case Status.NO_SCHOOL:
        emit(state);
        break;
      case Status.HAS_SCHOOL:
        emit(InitState(
            defaultSchool: databaseResponse.data,
            status: InitStatus.HAS_SCHOOL));
        break;
    }
  }

  void setup(String schoolName, BuildContext context) {
    locator<SharedPreferences>().clear();
    setupRequiredSharedPreferences();
    locator<SharedPreferences>().setString(PreferenceTypes.school, schoolName);
    if (state.status == InitStatus.INITIAL) {
      emit(InitState(defaultSchool: schoolName, status: InitStatus.HAS_SCHOOL));
    } else {
      emit(state.copyWith(defaultSchool: schoolName));
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
              builder: (context) => const MainAppNavigationRoot()),
          (Route<dynamic> route) => false);
    }
  }
}
