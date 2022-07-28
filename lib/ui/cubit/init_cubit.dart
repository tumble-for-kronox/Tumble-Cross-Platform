import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/shared/setup.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit()
      : super(const InitState(defaultSchool: null, status: InitStatus.INITIAL));

  final _implementationService = locator<ImplementationRepository>();

  Future<void> init() async {
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

  void setup(String schoolName) {
    setupRequiredSharedPreferences(schoolName);
    emit(state.copyWith(defaultSchool: schoolName));
  }
}
