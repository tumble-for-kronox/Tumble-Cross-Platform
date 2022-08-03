import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/repository/implementation_repository.dart';
import 'package:tumble/core/database/database_response.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/shared/setup.dart';
import 'package:tumble/core/startup/get_it_instances.dart';

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

  void changeSchool(String schoolName) {
    _sharedPrefs.clear();
    setupRequiredSharedPreferences();
    _sharedPrefs.setString(PreferenceTypes.school, schoolName);
    emit(state.copyWith(defaultSchool: schoolName));
  }
}
