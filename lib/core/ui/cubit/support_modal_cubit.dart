part of 'support_modal_state.dart';

class SupportModalCubit extends Cubit<SupportModalState> {
  SupportModalCubit()
      : super(const SupportModalState(
            isSubjectValid: false,
            isBodyValid: false,
            status: SupportModalStatus.INITIAL,
            focused: false)) {
    _init();
  }

  final _backendService = getIt<BackendService>();
  final _textEditingControllerSubject = TextEditingController();
  final _textEditingControllerBody = TextEditingController();
  final _focusNodeSubject = FocusNode();
  final _focusNodeBody = FocusNode();

  TextEditingController get subjectController => _textEditingControllerSubject;
  TextEditingController get bodyController => _textEditingControllerBody;
  FocusNode get focusNodeSubject => _focusNodeSubject;
  FocusNode get focusNodeBody => _focusNodeBody;

  @override
  Future<void> close() async {
    _textEditingControllerBody.dispose();
    _textEditingControllerSubject.dispose();
    return super.close();
  }

  Future<void> _init() async {
    _textEditingControllerSubject.addListener(subjectListener);
    _textEditingControllerBody.addListener(bodyListener);
    _focusNodeBody.addListener(setBodyFocused);
    _focusNodeSubject.addListener(setSubjectFocused);
  }

  void setBodyFocused() {
    if (_focusNodeBody.hasFocus) {
      emit(state.copyWith(focused: true));
    } else {
      emit(state.copyWith(focused: false));
    }
  }

  void setSubjectFocused() {
    if (_focusNodeSubject.hasFocus) {
      emit(state.copyWith(focused: true));
    } else {
      emit(state.copyWith(focused: false));
    }
  }

  Future<void> sendBugReport() async {
    final String subject = _textEditingControllerSubject.text;
    final String body = _textEditingControllerBody.text;
    final ApiResponse response =
        await _backendService.postSubmitIssue(subject, body);
    if (response.status == ApiResponseStatus.success) {
      emit(state.copyWith(status: SupportModalStatus.SENT));
    } else {
      emit(state.copyWith(status: SupportModalStatus.ERROR));
    }
  }

  void subjectListener() {
    if (_textEditingControllerSubject.text.length > 5) {
      emit(state.copyWith(isSubjectValid: true));
    } else {
      emit(state.copyWith(isSubjectValid: false));
    }
  }

  void bodyListener() {
    if (_textEditingControllerBody.text.length > 5) {
      emit(state.copyWith(isBodyValid: true));
    } else {
      emit(state.copyWith(isBodyValid: false));
    }
  }

  void setLoading() {
    emit(state.copyWith(status: SupportModalStatus.LOADING));
  }
}
