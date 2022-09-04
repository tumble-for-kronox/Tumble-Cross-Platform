import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/groups/general.dart';
import 'groups/details_modal.dart';
import 'groups/event_options.dart';
import 'groups/pop_up.dart';
import 'groups/scaffold_message_types.dart';
import 'groups/search_page.dart';
import 'groups/list_view_page.dart';
import 'groups/support_modal.dart';
import 'groups/user_events.dart';
import 'groups/week_view_page.dart';
import 'groups/calendar_view_page.dart';
import 'groups/unauthorized_page.dart';
import 'groups/authorized_page.dart';
import 'groups/login_page.dart';
import 'groups/settings_page.dart';
import 'groups/runtime_errors.dart';

class S {
  static AppLocalizations? _localizedStrings;

  static init(BuildContext context) {
    _localizedStrings = AppLocalizations.of(context)!;
  }

  static ScaffoldMessageType get scaffoldMessages => ScaffoldMessageType(_localizedStrings!);
  static SearchPageStrings get searchPage => SearchPageStrings(_localizedStrings!);
  static ListViewPageStrings get listViewPage => ListViewPageStrings(_localizedStrings!);
  static WeekViewPageStrings get weekViewPage => WeekViewPageStrings(_localizedStrings!);
  static CalendarViewPageStrings get calendarViewPage => CalendarViewPageStrings(_localizedStrings!);
  static UnauthorizedPageStrings get unauthorizedPage => UnauthorizedPageStrings(_localizedStrings!);
  static AuthorizedPageStrings get authorizedPage => AuthorizedPageStrings(_localizedStrings!);
  static LoginPageStrings get loginPage => LoginPageStrings(_localizedStrings!);
  static SettingsPageStrings get settingsPage => SettingsPageStrings(_localizedStrings!);
  static RuntimeErrorStrings get runtimeError => RuntimeErrorStrings(_localizedStrings!);
  static UserEventStrings get userEvents => UserEventStrings(_localizedStrings!);
  static GeneralStrings get general => GeneralStrings(_localizedStrings!);
  static PopUpStrings get popUps => PopUpStrings(_localizedStrings!);
  static EventOptionsStrings get eventOptions => EventOptionsStrings(_localizedStrings!);
  static DetailsModalStrings get detailsModal => DetailsModalStrings(_localizedStrings!);
  static SupportModalStrings get supportModal => SupportModalStrings(_localizedStrings!);
}
