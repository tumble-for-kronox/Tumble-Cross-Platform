import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/app_switch/data/event_types.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/contributors_modal/contributors_modal.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/data/review_strings.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/drawer_generic/app_language_picker.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/support_modal/support_modal.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_app_drawer_tile.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/cubit/drawer_state.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/drawer_generic/app_bookmark_schedule_toggle.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/drawer_generic/app_notification_time_picker.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/drawer_generic/app_theme_picker.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_settings_section.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../shared/preference_types.dart';

typedef HandleDrawerEvent = void Function(
  Enum eventType,
);

class TumbleAppDrawer extends StatelessWidget {
  const TumbleAppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = BlocProvider.of<AppNavigator>(context);
    return BlocBuilder<DrawerCubit, DrawerState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
          child: SizedBox(
            height: double.infinity,
            child: Drawer(
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 10),
                children: [
                  SizedBox(
                    height: 107.0,
                    child: DrawerHeader(
                      margin: const EdgeInsets.all(0.0),
                      padding: const EdgeInsets.all(0.0),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(S.settingsPage.title(),
                                style: const TextStyle(letterSpacing: 2, fontSize: 26, fontWeight: FontWeight.w500)),
                          )),
                    ),
                  ),
                  const SizedBox(height: 25.0),

                  /// Common
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                      drawerTileTitle: S.settingsPage.changeSchoolTitle(),
                      subtitle: S.settingsPage.changeSchoolSubtitle((Schools.schools
                              .firstWhere((school) => school.schoolName == context.read<DrawerCubit>().state.school))
                          .schoolId
                          .name
                          .toUpperCase()),
                      suffixIcon: CupertinoIcons.arrow_right_arrow_left,
                      eventType: EventType.CHANGE_SCHOOL,
                      drawerEvent: (eventType) => _handleDrawerEvent(eventType, context, navigator, null),
                    ),
                    TumbleAppDrawerTile(
                      drawerTileTitle: S.settingsPage.changeThemeTitle(),
                      subtitle:
                          S.settingsPage.changeThemeSubtitle(context.read<DrawerCubit>().state.theme!.capitalize()),
                      suffixIcon: CupertinoIcons.device_phone_portrait,
                      eventType: EventType.CHANGE_THEME,
                      drawerEvent: (eventType) => _handleDrawerEvent(eventType, context, navigator, null),
                    ),
                    TumbleAppDrawerTile(
                      drawerTileTitle: S.settingsPage.languageTitle(),
                      subtitle: S.settingsPage.languageSubtitle(),
                      suffixIcon: CupertinoIcons.textformat_abc_dottedunderline,
                      eventType: EventType.CHANGE_LANGUAGE,
                      drawerEvent: (eventType) =>
                          _handleDrawerEvent(eventType, context, navigator, context.read<DrawerCubit>()),
                    ),
                  ], title: S.settingsPage.commonTitle()),
                  Divider(
                    height: 40.0,
                    color: Theme.of(context).colorScheme.onBackground,
                    indent: 20,
                    endIndent: 30,
                  ),

                  /// Schedule
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                        drawerTileTitle: S.settingsPage.defaultScheduleTitle(),
                        subtitle: S.settingsPage.defaultScheduleSubtitle(),
                        suffixIcon: CupertinoIcons.bookmark,
                        eventType: EventType.TOGGLE_BOOKMARKED_SCHEDULES,
                        drawerEvent: (eventType) => _handleDrawerEvent(eventType, context, navigator, null)),
                  ], title: S.settingsPage.scheduleTitle()),
                  Divider(
                    height: 40.0,
                    color: Theme.of(context).colorScheme.onBackground,
                    indent: 20,
                    endIndent: 30,
                  ),
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                        suffixIcon: CupertinoIcons.bell_slash,
                        drawerTileTitle: S.settingsPage.clearAllTitle(),
                        subtitle: S.settingsPage.clearAllSubtitle(),
                        eventType: EventType.CANCEL_ALL_NOTIFICATIONS,
                        drawerEvent: (eventType) => _handleDrawerEvent(eventType, context, navigator, null)),
                    TumbleAppDrawerTile(
                      suffixIcon: CupertinoIcons.clock,
                      drawerTileTitle: S.settingsPage.offsetTitle(),
                      subtitle: S.settingsPage
                          .offsetSubtitle(getIt<SharedPreferences>().getInt(PreferenceTypes.notificationOffset)!),
                      eventType: EventType.EDIT_NOTIFICATION_TIME,
                      drawerEvent: (eventType) =>
                          _handleDrawerEvent(eventType, context, navigator, context.read<DrawerCubit>()),
                    )
                  ], title: S.settingsPage.notificationTitle()),
                  Divider(
                    height: 40.0,
                    color: Theme.of(context).colorScheme.onBackground,
                    indent: 20,
                    endIndent: 30,
                  ),

                  /// Misc
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                      drawerTileTitle: S.settingsPage.reportBugTitle(),
                      subtitle: S.settingsPage.reportBugSubtitle(),
                      suffixIcon: CupertinoIcons.ant,
                      eventType: EventType.BUG_REPORT,
                      drawerEvent: (eventType) =>
                          _handleDrawerEvent(eventType, context, navigator, context.read<DrawerCubit>()),
                    ),
                    TumbleAppDrawerTile(
                      suffixIcon: CupertinoIcons.group,
                      drawerTileTitle: "Contributors",
                      subtitle: "See who helped out",
                      eventType: EventType.CONTRIBUTORS,
                      drawerEvent: (eventType) => _handleDrawerEvent(eventType, context, navigator, null),
                    ),
                  ], title: S.settingsPage.miscTitle()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleDrawerEvent(Enum eventType, BuildContext context, AppNavigator navigator, DrawerCubit? cubit) async {
    switch (eventType) {
      case EventType.CHANGE_SCHOOL:
        navigator.push(NavigationRouteLabels.schoolSelectionPage);
        break;
      case EventType.CHANGE_THEME:
        showModalBottomSheet(
            context: context,
            builder: (_) => AppThemePicker(setTheme: (String themeType) {
                  context.read<DrawerCubit>().changeTheme(themeType);
                  Navigator.of(context).pop();
                }));
        break;
      case EventType.TOGGLE_BOOKMARKED_SCHEDULES:
        if (context.read<DrawerCubit>().state.bookmarks!.isNotEmpty) {
          List<BookmarkedScheduleModel> tempBookmarks = context.read<DrawerCubit>().state.bookmarks!;
          showModalBottomSheet(
              context: context,
              builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<DrawerCubit>(context),
                    child: const AppBookmarkScheduleToggle(),
                  )).whenComplete(() async {
            if (tempBookmarks != context.read<DrawerCubit>().state.bookmarks!) {
              BlocProvider.of<AppSwitchCubit>(context).setLoading();
              await BlocProvider.of<AppSwitchCubit>(context).attemptToFetchCachedSchedules();
            }
          });
        }
        break;
      case EventType.CANCEL_ALL_NOTIFICATIONS:
        getIt<NotificationRepository>().cancelAllNotifications();
        showScaffoldMessage(context, S.scaffoldMessages.cancelledAllSetNotifications());
        break;
      case EventType.EDIT_NOTIFICATION_TIME:
        showModalBottomSheet(
            context: context,
            builder: (_) => AppNotificationTimePicker(
                  parameterMap: cubit!.getNotificationTimes(context),
                  currentNotificationTime: cubit.state.notificationTime!,
                  setNotificationTime: (time) {
                    cubit.setNotificationTime(time);
                    Navigator.of(context).pop();
                  },
                ));
        break;
      case EventType.BUG_REPORT:
        BugReportModal.showBugReportModal(context, cubit!);
        break;
      case EventType.OPEN_REVIEW:
        final uri = Platform.isIOS ? StoreUriString.ios : StoreUriString.android;
        await launchUrlString(uri);
        break;
      case EventType.CHANGE_LANGUAGE:
        showModalBottomSheet(
          context: context,
          builder: (_) => AppLanguagePicker(
              currentLocale: BlocProvider.of<ThemeCubit>(context).state.locale,
              parameterMap: cubit!.getLangOptions(),
              setLocale: (Locale? locale) {
                cubit.changeLocale(locale);
                Navigator.of(context).pop();
              }),
        );
        break;
      case EventType.CONTRIBUTORS:
        showModalBottomSheet(context: context, builder: (_) => const ContributorsModal());
    }
  }
}
