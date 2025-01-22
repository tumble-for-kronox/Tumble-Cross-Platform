import 'package:tumble/core/ui/data/string_constant_group.dart';

class SearchPageStrings extends StringConstantGroup {
  SearchPageStrings(super.localizedStrings);

  String title() => localizedStrings.searchPageTitle;
  String searchBarUnfocusedPlaceholder() => localizedStrings.searchBarUnfocusedPlaceholder;
  String searchBarFocusedPlaceholder() => localizedStrings.searchBarFocusedPlaceholder;
  String toScheduleView() => localizedStrings.searchPageToScheduleViewButton;
  String results(int numOfResults) => localizedStrings.searchPageResults(numOfResults);
  String saveSchedule() => localizedStrings.searchPageSaveSchedule;
  String scheduleIsSaved() => localizedStrings.searchPageScheduleIsSaved;
}
