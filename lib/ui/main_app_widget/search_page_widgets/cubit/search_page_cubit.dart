import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/models/api_models/program_model.dart';
import 'package:tumble/startup/get_it_instances.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit() : super(const SearchPageInitial());
  final _databaseService = locator<DatabaseRepository>();
  final _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String>? _storedScheduleIds;
  bool _clearVisible = false;
  final _implementationService = locator<ImplementationRepository>();

  TextEditingController get textEditingController => _textEditingController;
  bool get clearVisible => _clearVisible;
  FocusNode get focusNode => _focusNode;

  Future<void> search() async {
    emit(const SearchPageLoading());
    String query = textEditingController.text;
    ApiResponse res = await _implementationService.getProgramsRequest(query);
    switch (res.status) {
      case Status.REQUESTED:
        ProgramModel program = res.data as ProgramModel;
        emit(SearchPageFoundSchedules(programList: program.items));
        break;
      default:
        emit(SearchPageNoSchedules(errorType: res.message!));
        break;
    }
  }

  void resetCubit() {
    _textEditingController.text = '';
    emit(const SearchPageInitial());
  }

  Future<void> init() async {
    _storedScheduleIds = await _databaseService.getAllScheduleIds();
    _focusNode.addListener((setSearchBarFocused));
    _textEditingController.addListener((setClearButton));
  }

  @override
  Future<void> close() async {
    _focusNode.dispose();
    _textEditingController.dispose();
    return super.close();
  }

  setSearchBarFocused() {
    if (_focusNode.hasFocus) {
      emit(SearchPageFocused(_clearVisible));
    } else if (!_focusNode.hasFocus &&
        _textEditingController.text.trim().isEmpty) {
      emit(const SearchPageInitial());
    }
  }

  setClearButton() {
    if (_textEditingController.text.isEmpty) {
      _clearVisible = false;
      emit(state);
    } else {
      _clearVisible = true;
      emit(state);
    }
  }
}
