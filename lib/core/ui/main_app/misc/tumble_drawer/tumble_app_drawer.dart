import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/repository/notification_repository.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/ui/data/groups/scaffold_message_types.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/main_app/data/event_types.dart';
import 'package:tumble/core/ui/main_app/data/schools.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/data/review_strings.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/support_modal/support_modal.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_app_drawer_tile.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/cubit/drawer_state.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/drawer_generic/app_default_schedule_picker.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/drawer_generic/app_notification_time_picker.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/drawer_generic/app_theme_picker.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_settings_section.dart';
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
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0)),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(S.settingsPage.title(),
                                style: const TextStyle(
                                    letterSpacing: 2,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500)),
                          )),
                    ),
                  ),
                  const SizedBox(height: 25.0),

                  /// Common
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                      drawerTileTitle: S.settingsPage.changeSchoolTitle(),
                      subtitle: S.settingsPage.changeSchoolSubtitle(
                          (Schools.schools.firstWhere((school) =>
                                  school.schoolName ==
                                  context.read<DrawerCubit>().state.school))
                              .schoolId
                              .name
                              .toUpperCase()),
                      suffixIcon: CupertinoIcons.arrow_right_arrow_left,
                      eventType: EventType.CHANGE_SCHOOL,
                      drawerEvent: (eventType) => handleDrawerEvent(
                          eventType, context, navigator, null),
                    ),
                    TumbleAppDrawerTile(
                      drawerTileTitle: S.settingsPage.changeThemeTitle(),
                      subtitle: S.settingsPage.changeThemeSubtitle(
                          context.read<DrawerCubit>().state.theme!),
                      suffixIcon: CupertinoIcons.device_phone_portrait,
                      eventType: EventType.CHANGE_THEME,
                      drawerEvent: (eventType) => handleDrawerEvent(
                          eventType, context, navigator, null),
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
                        subtitle: "Select from your list of bookmarks",
                        suffixIcon: CupertinoIcons.bookmark,
                        eventType: EventType.TOGGLE_BOOKMARKED_SCHEDULES,
                        drawerEvent: (eventType) => handleDrawerEvent(
                            eventType, context, navigator, null)),
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
                        drawerEvent: (eventType) => handleDrawerEvent(
                            eventType, context, navigator, null)),
                    TumbleAppDrawerTile(
                      suffixIcon: CupertinoIcons.clock,
                      drawerTileTitle: S.settingsPage.offsetTitle(),
                      subtitle: S.settingsPage.offsetSubtitle(
                          getIt<SharedPreferences>()
                              .getInt(PreferenceTypes.notificationTime)
                              .toString()),
                      eventType: EventType.EDIT_NOTIFICATION_TIME,
                      drawerEvent: (eventType) => handleDrawerEvent(
                          eventType, context, navigator, null),
                    )
                  ], title: S.settingsPage.notificationTitle()),
                  Divider(
                    height: 40.0,
                    color: Theme.of(context).colorScheme.onBackground,
                    indent: 20,
                    endIndent: 30,
                  ),

                  /// Support
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                      drawerTileTitle: "Report a bug",
                      subtitle: "Send us a bug report of an issue",
                      suffixIcon: CupertinoIcons.ant,
                      eventType: EventType.SUPPORT,
                      drawerEvent: (eventType) => handleDrawerEvent(eventType,
                          context, navigator, context.read<DrawerCubit>()),
                    ),
                    /* TumbleAppDrawerTile(
                      drawerTileTitle: "Rate our app",
                      subtitle:
                          "Rate our app on ${Platform.isIOS ? 'App Store' : 'Google Play'}",
                      suffixIcon: CupertinoIcons.star,
                      eventType: EventType.OPEN_REVIEW,
                      drawerEvent: (eventType) => handleDrawerEvent(eventType,
                          context, navigator, context.read<DrawerCubit>()),
                    ), */
                  ], title: "Miscellaneous"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void handleDrawerEvent(Enum eventType, BuildContext context,
      AppNavigator navigator, DrawerCubit? cubit) async {
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
          showModalBottomSheet(
              context: context,
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<DrawerCubit>.value(
                          value: BlocProvider.of<DrawerCubit>(context)),
                      BlocProvider<MainAppCubit>.value(
                          value: BlocProvider.of<MainAppCubit>(context)),
                    ],
                    child: const AppFavoriteScheduleToggle(),
                  ));
        }
        break;
      case EventType.CANCEL_ALL_NOTIFICATIONS:
        getIt<NotificationRepository>().cancelAllNotifications();
        showScaffoldMessage(
            context, S.scaffoldMessages.cancelledAllSetNotifications());
        break;
      case EventType.EDIT_NOTIFICATION_TIME:
        showModalBottomSheet(
            context: context,
            builder: (_) =>
                AppNotificationTimePicker(setNotificationTime: (time) {
                  context.read<DrawerCubit>().setNotificationTime(
                        time,
                      );
                  Navigator.of(context).pop();
                }));
        break;
      case EventType.SUPPORT:
        SupportModal.showSupportModal(context, cubit!);
        break;
      case EventType.OPEN_REVIEW:
        final uri =
            Platform.isIOS ? StoreUriString.ios : StoreUriString.android;
        await launchUrlString(uri);
    }
  }
}
