import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/groups/general.dart';
import 'groups/event_options.dart';
import 'groups/pop_up.dart';
import 'groups/scaffold_message_types.dart';
import 'groups/search_page.dart';
import 'groups/list_view_page.dart';
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

  static LoginPageStrings? _loginPage;
  static ScaffoldMessageType? _scaffoldMessages;
  static SearchPageStrings? _searchPage;
  static UnauthorizedPageStrings? _unauthorizedPage;
  static AuthorizedPageStrings? _authorizedPage;
  static ListViewPageStrings? _listViewPage;
  static WeekViewPageStrings? _weekViewPage;
  static CalendarViewPageStrings? _calendarViewPage;
  static SettingsPageStrings? _settingsPage;
  static RuntimeErrorStrings? _runtimeError;
  static UserEventStrings? _userEvents;
  static GeneralStrings? _general;
  static PopUpStrings? _popUps;
  static EventOptionsStrings? _eventOptions;

  static ScaffoldMessageType get scaffoldMessages =>
      _scaffoldMessages ??= ScaffoldMessageType(_localizedStrings!);
  static SearchPageStrings get searchPage =>
      _searchPage ??= SearchPageStrings(_localizedStrings!);
  static ListViewPageStrings get listViewPage =>
      _listViewPage ??= ListViewPageStrings(_localizedStrings!);
  static WeekViewPageStrings get weekViewPage =>
      _weekViewPage ??= WeekViewPageStrings(_localizedStrings!);
  static CalendarViewPageStrings get calendarViewPage =>
      _calendarViewPage ??= CalendarViewPageStrings(_localizedStrings!);
  static UnauthorizedPageStrings get unauthorizedPage =>
      _unauthorizedPage ??= UnauthorizedPageStrings(_localizedStrings!);
  static AuthorizedPageStrings get authorizedPage =>
      _authorizedPage ??= AuthorizedPageStrings(_localizedStrings!);
  static LoginPageStrings get loginPage =>
      _loginPage ??= LoginPageStrings(_localizedStrings!);
  static SettingsPageStrings get settingsPage =>
      _settingsPage ??= SettingsPageStrings(_localizedStrings!);
  static RuntimeErrorStrings get runtimeError =>
      _runtimeError ??= RuntimeErrorStrings(_localizedStrings!);
  static UserEventStrings get userEvents =>
      _userEvents ??= UserEventStrings(_localizedStrings!);
  static GeneralStrings get general =>
      _general ??= GeneralStrings(_localizedStrings!);
  static PopUpStrings get popUps =>
      _popUps ??= PopUpStrings(_localizedStrings!);
  static EventOptionsStrings get eventOptions =>
      _eventOptions ??= EventOptionsStrings(_localizedStrings!);
}
