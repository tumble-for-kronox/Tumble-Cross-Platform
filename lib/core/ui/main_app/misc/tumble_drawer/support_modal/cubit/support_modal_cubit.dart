part of 'support_modal_state.dart';

class SupportModalCubit extends Cubit<SupportModalState> {
  SupportModalCubit()
      : super(const SupportModalState(
            isSubjectValid: false,
            isBodyValid: false,
            formSubmittedSuccessfully: false));

  final _textEditingControllerSubject = TextEditingController();
  final _textEditingControllerBody = TextEditingController();

  TextEditingController get subjectController => _textEditingControllerSubject;
  TextEditingController get bodyController => _textEditingControllerBody;

  Future<void> init() async {
    _textEditingControllerSubject.addListener(subjectListener);
    _textEditingControllerBody.addListener(bodyListener);
  }

  void sendBugReport() async {
    final Email email = Email(
      body: _textEditingControllerBody.text,
      subject: _textEditingControllerSubject.text,
      recipients: [TumbleContact.email],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
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
}
