import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/models/api_models/program_model.dart';
import 'package:tumble/startup/get_it_instances.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit() : super(const SearchPageInitial());

  final _implementationService = locator<ImplementationRepository>();

  final TextEditingController _textEditingController = TextEditingController();

  TextEditingController get textEditingController => _textEditingController;

  Future<void> search(String searchQuery) async {
    emit(const SearchPageLoading());
    ApiResponse res =
        await _implementationService.getProgramsRequest(searchQuery);
    log("Response: ${res.message}\nData: ${res.data}\nStatus:${res.status}");
    switch (res.status) {
      case Status.COMPLETED:
        ProgramModel program = res.data as ProgramModel;
        emit(SearchPageFoundSchedules(programList: program.requestedSchedule));
        break;
      default:
        emit(const SearchPageNoSchedules());
    }
  }
}
