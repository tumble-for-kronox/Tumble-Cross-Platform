import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/icache_and_interaction_repository.dart';
import 'package:tumble/core/models/api_models/program_model.dart';
import 'package:tumble/core/startup/get_it_instances.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit()
      : super(const SearchPageState(
            false, SearchPageStatus.INITIAL, false, null, null));

  final _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _cacheAndInteractionService = getIt<CacheAndInteractionRepository>();

  TextEditingController get textEditingController => _textEditingController;
  FocusNode get focusNode => _focusNode;

  Future<void> search() async {
    emit(state.copyWith(status: SearchPageStatus.LOADING));
    String query = textEditingController.text;
    ApiResponse apiResponse =
        await _cacheAndInteractionService.getProgramsRequest(query);

    if (state.focused) {
      switch (apiResponse.status) {
        case ApiStatus.REQUESTED:
          ProgramModel program = apiResponse.data as ProgramModel;
          emit(state.copyWith(
              status: SearchPageStatus.FOUND, programList: program.items));
          break;
        case ApiStatus.ERROR:
          emit(state.copyWith(
              status: SearchPageStatus.ERROR,
              errorMessage: apiResponse.message));
          break;
        default:
          break;
      }
    }
    return;
  }

  void setLoading() {
    emit(state.copyWith(status: SearchPageStatus.LOADING));
  }

  void resetCubit() {
    if (textEditingController.text.isNotEmpty) {
      _textEditingController.clear();
    } else {
      _focusNode.unfocus();
      emit(state.copyWith(
          status: SearchPageStatus.INITIAL,
          clearButtonVisible: false,
          programList: null,
          errorMessage: null,
          focused: false));
    }
  }

  Future<void> init() async {
    _focusNode.addListener((setSearchBarFocused));
  }

  @override
  Future<void> close() async {
    _focusNode.dispose();
    _textEditingController.dispose();
    return super.close();
  }

  setSearchBarFocused() {
    if (_focusNode.hasFocus) {
      emit(state.copyWith(clearButtonVisible: true, focused: true));
    } else if (!_focusNode.hasFocus &&
        _textEditingController.text.trim().isEmpty) {
      emit(state.copyWith(clearButtonVisible: false, focused: false));
    }
  }
}
