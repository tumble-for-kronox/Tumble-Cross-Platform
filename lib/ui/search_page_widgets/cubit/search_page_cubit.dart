import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/models/api_models/program_model.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/home_page_widget/home_page.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit() : super(const SearchPageInitial());
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _implementationService = locator<ImplementationRepository>();

  TextEditingController get textEditingController => _textEditingController;
  FocusNode get focusNode => _focusNode;

  Future<void> search() async {
    emit(const SearchPageLoading());
    String query = textEditingController.text;
    ApiResponse res = await _implementationService.getProgramsRequest(query);
    log("Response: ${res.message}\nStatus:${res.status}");
    switch (res.status) {
      case Status.COMPLETED:
        ProgramModel program = res.data as ProgramModel;
        emit(SearchPageFoundSchedules(programList: program.items));
        break;
      default:
        emit(const SearchPageNoSchedules());
        break;
    }
  }

  void resetCubit() {
    _textEditingController.text = '';
    emit(const SearchPageInitial());
  }

  void navigateToHomepPage(BuildContext context, scheduleId) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => HomePage(currentScheduleId: scheduleId)));
  }

  Future<void> init() async {
    _focusNode.addListener((setSearchBarFocused));
  }

  @override
  Future<void> close() async {
    _focusNode.dispose();
    return super.close();
  }

  setSearchBarFocused() {
    if (_focusNode.hasFocus) {
      emit(const SearchPageFocused());
    } else if (!_focusNode.hasFocus &&
        _textEditingController.text.trim().isEmpty) {
      emit(const SearchPageInitial());
    }
  }
}
