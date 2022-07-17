import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

part 'schedule_search_bar_and_logo_container_state.dart';

class ScheduleSearchBarAndLogoContainerCubit
    extends Cubit<ScheduleSearchBarAndLogoContainerState> {
  ScheduleSearchBarAndLogoContainerCubit()
      : super(const ScheduleSearchBarAndLogoContainerInitial());

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  TextEditingController get textEditingController => _textEditingController;
  FocusNode get focusNode => _focusNode;

  Future<void> init() async {
    _focusNode.addListener(() {
      setSearchBarFocused();
    });
  }

  setSearchBarFocused() {
    emit(const ScheduleSearchBarAndLogoContainerFocused());
  }
}
