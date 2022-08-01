import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/ui/main_app_widget/data/event_types.dart';
import 'package:tumble/core/ui/main_app_widget/data/schools.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/cubit/drawer_state.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/drawer_generic/app_default_schedule_picker.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/drawer_generic/app_default_view_picker.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/drawer_generic/app_theme_picker.dart';
import '../tumble_app_drawer_tile.dart';
import '../tumble_settings_section.dart';

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
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 107.0,
                    child: DrawerHeader(
                      margin: EdgeInsets.all(0.0),
                      padding: EdgeInsets.all(0.0),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 13, horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('Settings',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w400)),
                          )),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                      drawerTileTitle: "Contact",
                      subtitle: "Get support",
                      prefixIcon: CupertinoIcons.bubble_left_bubble_right,
                      eventType: EventType.CONTACT,
                      drawerEvent: (eventType) => handleDrawerEvent(
                        eventType,
                        context,
                        navigator,
                      ),
                    ),
                  ], title: "Support"),
                  Divider(
                    height: 50.0,
                    color: Theme.of(context).colorScheme.onBackground,
                    indent: 20,
                    endIndent: 30,
                  ),

                  /// Common
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                      drawerTileTitle: "Change schools",
                      subtitle:
                          "Current school: ${(Schools.schools.firstWhere((school) => school.schoolName == context.read<DrawerCubit>().state.school)).schoolId.name.toUpperCase()}",
                      prefixIcon: CupertinoIcons.arrow_right_arrow_left,
                      eventType: EventType.CHANGE_SCHOOL,
                      drawerEvent: (eventType) => handleDrawerEvent(
                        eventType,
                        context,
                        navigator,
                      ),
                    ),
                    TumbleAppDrawerTile(
                      drawerTileTitle: "Change theme",
                      subtitle:
                          "Current theme:  ${context.read<DrawerCubit>().state.theme}",
                      prefixIcon: CupertinoIcons.device_phone_portrait,
                      eventType: EventType.CHANGE_THEME,
                      drawerEvent: (eventType) => handleDrawerEvent(
                        eventType,
                        context,
                        navigator,
                      ),
                    ),
                  ], title: "Common"),
                  Divider(
                    height: 50.0,
                    color: Theme.of(context).colorScheme.onBackground,
                    indent: 20,
                    endIndent: 30,
                  ),

                  /// Schedule
                  TumbleSettingsSection(tiles: [
                    TumbleAppDrawerTile(
                        drawerTileTitle: "Set default view type",
                        subtitle: "Current view: ${state.viewType}",
                        prefixIcon: CupertinoIcons.list_dash,
                        eventType: EventType.SET_DEFAULT_VIEW,
                        drawerEvent: (eventType) => handleDrawerEvent(
                              eventType,
                              context,
                              navigator,
                            )),
                    TumbleAppDrawerTile(
                        drawerTileTitle: "Set default schedule",
                        subtitle:
                            context.watch<DrawerCubit>().state.schedule != null
                                ? "Default schedule: \n${state.schedule}"
                                : "No default schedule set",
                        prefixIcon: CupertinoIcons.calendar,
                        eventType: EventType.SET_DEFAULT_SCHEDULE,
                        drawerEvent: (eventType) =>
                            handleDrawerEvent(eventType, context, navigator)),
                  ], title: "Schedule"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void handleDrawerEvent(
      Enum eventType, BuildContext context, AppNavigator navigator) {
    switch (eventType) {
      case EventType.CANCEL_ALL_NOTIFICATIONS:

        /// Cancel all notifications
        break;
      case EventType.CANCEL_NOTIFICATIONS_FOR_PROGRAM:

        /// Cancel all notifications tied to this schedule id
        break;
      case EventType.CHANGE_SCHOOL:
        navigator.push(NavigationRouteLabels.schoolSelectionPage);
        break;
      case EventType.CHANGE_THEME:
        showModalBottomSheet(
            context: context,
            builder: (context) => AppThemePicker(setTheme: (String themeType) {
                  context.read<DrawerCubit>().changeTheme(themeType);
                  Navigator.of(context).pop();
                }));
        break;
      case EventType.CONTACT:

        /// Direct user to support page
        break;
      case EventType.EDIT_NOTIFICATION_TIME:
        break;
      case EventType.SET_DEFAULT_SCHEDULE:
        if (context.read<DrawerCubit>().state.bookmarks!.isNotEmpty) {
          showModalBottomSheet(
              context: context,
              builder: (context) => AppDefaultSchedulePicker(
                  scheduleIds: context.read<DrawerCubit>().state.bookmarks!,
                  setDefaultSchedule: (newId) {
                    context.read<DrawerCubit>().setSchedule(newId);
                    Navigator.of(context).pop();
                  }));
        }
        break;
      case EventType.SET_DEFAULT_VIEW:
        showModalBottomSheet(
            context: context,
            builder: (context) => AppDefaultViewPicker(
                  setDefaultView: (viewType) {
                    context.read<DrawerCubit>().setView(viewType);
                    Navigator.of(context).pop();
                  },
                ));
        break;
    }
  }
}
