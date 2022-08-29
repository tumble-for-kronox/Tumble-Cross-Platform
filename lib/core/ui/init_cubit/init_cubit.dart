import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/repository/cache_and_interaction_repository.dart';
import 'package:tumble/core/database/database_response.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/shared/setup.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit()
      : super(const InitState(defaultSchool: null, status: InitStatus.INITIAL));

  final _cacheAndInteractionService = getIt<CacheAndInteractionRepository>();
  final _databaseService = getIt<DatabaseRepository>();

  Future<void> init() async {
    DatabaseResponse databaseResponse =
        await _cacheAndInteractionService.initSetup();
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
    final theme = getIt<SharedPreferences>().getString(PreferenceTypes.theme);
    getIt<SharedPreferences>().clear();
    setupRequiredSharedPreferences();
    getIt<SharedPreferences>().setString(PreferenceTypes.school, schoolName);
    getIt<SharedPreferences>().setString(PreferenceTypes.theme, theme!);
    _databaseService.removeAll();
    _databaseService.removeAllCachedCourseColors();
    emit(InitState(defaultSchool: schoolName, status: InitStatus.HAS_SCHOOL));
  }
}
