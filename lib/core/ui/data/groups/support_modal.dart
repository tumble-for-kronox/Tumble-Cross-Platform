import 'package:tumble/core/ui/data/string_constant_group.dart';

class SupportModalStrings extends StringConstantGroup {
  SupportModalStrings(super.localizedStrings);

  String title() => localizedStrings.supportModalTitle;
  String subjectTooShort() => localizedStrings.supportModalSubjectTooShort;
  String subjectLabel() => localizedStrings.supportModalIssueTypeLabel;
  String subjectHelper() => localizedStrings.supportModalIssueSummaryHelper;
  String bodyTooShort() => localizedStrings.supportModalBodyTooShort;
  String bodyLabel() => localizedStrings.supportModalExplainIssueLabel;
  String bodyHelper() => localizedStrings.supportModalExplainIssueHelper;
  String sendSucces() => localizedStrings.supportModalSendSuccess;
  String sendFail() => localizedStrings.supportModalSendFail;
}
