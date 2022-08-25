import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
import 'package:tumble/core/ui/main_app/main_app.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_app_drawer_tile.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/cubit/drawer_state.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/drawer_generic/app_default_schedule_picker.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/drawer_generic/app_default_view_picker.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/drawer_generic/app_notification_time_picker.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/drawer_generic/app_theme_picker.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_settings_section.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

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
                          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(S.settingsPage.title(),
                                style: const TextStyle(letterSpacing: 2, fontSize: 26, fontWeight: FontWeight.w500)),
                          )),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                      drawerTileTitle: S.settingsPage.contactTitle(),
                      subtitle: S.settingsPage.contactSubtitle(),
                      prefixIcon: CupertinoIcons.bubble_left_bubble_right,
                      eventType: EventType.CONTACT,
                      drawerEvent: (eventType) => handleDrawerEvent(
                        eventType,
                        context,
                        navigator,
                      ),
                    ),
                  ], title: S.settingsPage.supportTitle()),
                  Divider(
                    height: 50.0,
                    color: Theme.of(context).colorScheme.onBackground,
                    indent: 20,
                    endIndent: 30,
                  ),

                  /// Common
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                      drawerTileTitle: S.settingsPage.changeSchoolTitle(),
                      subtitle: S.settingsPage.changeSchoolSubtitle((Schools.schools
                              .firstWhere((school) => school.schoolName == context.read<DrawerCubit>().state.school))
                          .schoolId
                          .name
                          .toUpperCase()),
                      prefixIcon: CupertinoIcons.arrow_right_arrow_left,
                      eventType: EventType.CHANGE_SCHOOL,
                      drawerEvent: (eventType) => handleDrawerEvent(
                        eventType,
                        context,
                        navigator,
                      ),
                    ),
                    TumbleAppDrawerTile(
                      drawerTileTitle: S.settingsPage.changeThemeTitle(),
                      subtitle: S.settingsPage.changeThemeSubtitle(context.read<DrawerCubit>().state.theme!),
                      prefixIcon: CupertinoIcons.device_phone_portrait,
                      eventType: EventType.CHANGE_THEME,
                      drawerEvent: (eventType) => handleDrawerEvent(
                        eventType,
                        context,
                        navigator,
                      ),
                    ),
                  ], title: S.settingsPage.commonTitle()),
                  Divider(
                    height: 50.0,
                    color: Theme.of(context).colorScheme.onBackground,
                    indent: 20,
                    endIndent: 30,
                  ),

                  /// Schedule
                  TumbleSettingsSection(tiles: [
                    // TumbleAppDrawerTile(
                    //     drawerTileTitle: "Set default view type",
                    //     subtitle: "Current view: ${state.viewType}",
                    //     prefixIcon: CupertinoIcons.list_dash,
                    //     eventType: EventType.SET_DEFAULT_VIEW,
                    //     drawerEvent: (eventType) => handleDrawerEvent(
                    //           eventType,
                    //           context,
                    //           navigator,
                    //         )),
                    TumbleAppDrawerTile(
                        drawerTileTitle: S.settingsPage.defaultScheduleTitle(),
                        subtitle: context.watch<DrawerCubit>().state.schedule != null
                            ? S.settingsPage.defaultScheduleSubtitle(state.schedule!)
                            : S.settingsPage.defaultScheduleEmptySubtitle(),
                        prefixIcon: CupertinoIcons.calendar,
                        eventType: EventType.SET_DEFAULT_SCHEDULE,
                        drawerEvent: (eventType) => handleDrawerEvent(eventType, context, navigator)),
                  ], title: S.settingsPage.scheduleTitle()),
                  Divider(
                    height: 50.0,
                    color: Theme.of(context).colorScheme.onBackground,
                    indent: 20,
                    endIndent: 30,
                  ),
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                        prefixIcon: CupertinoIcons.bell_slash,
                        drawerTileTitle: S.settingsPage.clearAllTitle(),
                        subtitle: S.settingsPage.clearAllSubtitle(),
                        eventType: EventType.CANCEL_ALL_NOTIFICATIONS,
                        drawerEvent: (eventType) => handleDrawerEvent(eventType, context, navigator)),
                    TumbleAppDrawerTile(
                      prefixIcon: CupertinoIcons.clock,
                      drawerTileTitle: S.settingsPage.offsetTitle(),
                      subtitle: S.settingsPage.offsetSubtitle(
                          getIt<SharedPreferences>().getInt(PreferenceTypes.notificationTime).toString()),
                      eventType: EventType.EDIT_NOTIFICATION_TIME,
                      drawerEvent: (eventType) => handleDrawerEvent(eventType, context, navigator),
                    )
                  ], title: S.settingsPage.notificationTitle())
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void handleDrawerEvent(Enum eventType, BuildContext context, AppNavigator navigator) {
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
      case EventType.CONTACT:

        /// Direct user to support page
        break;
      case EventType.SET_DEFAULT_SCHEDULE:
        if (context.read<DrawerCubit>().state.bookmarks!.isNotEmpty) {
          showModalBottomSheet(
              context: context,
              builder: (_) => AppDefaultSchedulePicker(
                  scheduleIds: context.read<DrawerCubit>().state.bookmarks!,
                  setDefaultSchedule: (newId) async {
                    context.read<DrawerCubit>().setSchedule(newId);
                    BlocProvider.of<MainAppCubit>(context).setLoading();
                    Navigator.of(context).pop();
                    await BlocProvider.of<MainAppCubit>(context).swapScheduleDefaultView(newId);
                  }));
        }
        break;
      case EventType.SET_DEFAULT_VIEW:
        showModalBottomSheet(
            context: context,
            builder: (_) => AppDefaultViewPicker(
                  setDefaultView: (viewType) {
                    context.read<DrawerCubit>().setView(viewType);
                    Navigator.of(context).pop();
                  },
                ));
        break;
      case EventType.CANCEL_ALL_NOTIFICATIONS:
        getIt<NotificationRepository>().clearAllNotifications();
        showScaffoldMessage(context, S.scaffoldMessages.cancelledAllSetNotifications());
        break;
      case EventType.EDIT_NOTIFICATION_TIME:
        showModalBottomSheet(
            context: context,
            builder: (_) => AppNotificationTimePicker(setNotificationTime: (time) {
                  context.read<DrawerCubit>().setNotificationTime(
                      time, BlocProvider.of<MainAppCubit>(context).state.scheduleModelAndCourses!.scheduleModel);
                  Navigator.of(context).pop();
                }));
        break;
    }
  }
}
