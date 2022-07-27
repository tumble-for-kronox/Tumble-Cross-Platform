import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit() : super(const InitStateInitial());

  final _implementationService = locator<ImplementationRepository>();

  Future<void> init() async {
    DatabaseResponse _databaseResponse =
        await _implementationService.initSetup();
    switch (_databaseResponse.status) {
      case Status.INITIAL:
        emit(const InitStateInitial());
        break;
      case Status.HAS_DEFAULT:
        emit(InitStateHasSchool(_databaseResponse.data));
        break;
    }
  }

  void setup(String schoolName) {
    emit(InitStateHasSchool(schoolName));
  }
}
