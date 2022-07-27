import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/extensions/extensions.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/theme/data/colors.dart';
import 'package:tumble/ui/main_app_widget/data/event_types.dart';

import '../../../shared/preference_types.dart';
import 'tumble_app_drawer_tile.dart';
import 'tumble_settings_section.dart';

typedef HandleDrawerEvent = void Function(Enum eventType);

class TumbleAppDrawer extends StatelessWidget {
  final HandleDrawerEvent handleDrawerEvent;
  final bool limitOptions;
  final String currentThemeString;
  const TumbleAppDrawer(
      {Key? key, required this.limitOptions, required this.handleDrawerEvent, required this.currentThemeString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 350,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 107.0,
            child: DrawerHeader(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Settings', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400)),
                  )),
            ),
          ),
          const SizedBox(height: 25.0),
          TumbleSettingsSection(tiles: [
            TumbleAppDrawerTile(
              drawerTileTitle: "Contact",
              subtitle: "Get support from our support team",
              prefixIcon: CupertinoIcons.bubble_left_bubble_right,
              eventType: EventType.CONTACT,
              drawerEvent: handleDrawerEvent,
            ),
          ], title: "Support"),
          const SizedBox(height: 20.0),

          /// Common
          TumbleSettingsSection(tiles: [
            TumbleAppDrawerTile(
              drawerTileTitle: "Change schools",
              subtitle: "Current default school is HKR",
              prefixIcon: CupertinoIcons.arrow_right_arrow_left,
              eventType: EventType.CHANGE_SCHOOL,
              drawerEvent: handleDrawerEvent,
            ),
            TumbleAppDrawerTile(
              drawerTileTitle: "Change theme",
              subtitle: "Current theme: $currentThemeString Theme",
              prefixIcon: CupertinoIcons.device_phone_portrait,
              eventType: EventType.CHANGE_THEME,
              drawerEvent: handleDrawerEvent,
            ),
          ], title: "Common"),
          const SizedBox(height: 20.0),

          /// Schedule
          TumbleSettingsSection(tiles: [
            TumbleAppDrawerTile(
              drawerTileTitle: "Set default view type",
              subtitle: "Current view: List view",
              prefixIcon: CupertinoIcons.list_dash,
              eventType: EventType.SET_DEFAULT_VIEW,
              drawerEvent: handleDrawerEvent,
            ),
            TumbleAppDrawerTile(
              drawerTileTitle: "Set default schedule",
              subtitle: "No default schedule set",
              prefixIcon: CupertinoIcons.calendar,
              eventType: EventType.SET_DEFAULT_SCHEDULE,
              drawerEvent: handleDrawerEvent,
            ),
          ], title: "Schedule"),
          const SizedBox(height: 20.0),

          /// Notifications
          TumbleSettingsSection(tiles: [
            TumbleAppDrawerTile(
              drawerTileTitle: "Cancel all notifications",
              subtitle: "Cancel all scheduled notifications",
              prefixIcon: CupertinoIcons.text_badge_xmark,
              eventType: EventType.CANCEL_ALL_NOTIFICATIONS,
              drawerEvent: handleDrawerEvent,
            ),
            limitOptions
                ? Container()
                : TumbleAppDrawerTile(
                    drawerTileTitle: "Cancel notifications for\nprogram",
                    subtitle: "Cancel notifications for this program",
                    prefixIcon: CupertinoIcons.text_badge_minus,
                    eventType: EventType.CANCEL_NOTIFICATIONS_FOR_PROGRAM,
                    drawerEvent: handleDrawerEvent),
            TumbleAppDrawerTile(
              drawerTileTitle: "Edit notification time",
              subtitle: "Notifications will show 3 hours prior to event",
              prefixIcon: CupertinoIcons.time,
              eventType: EventType.EDIT_NOTIFICATION_TIME,
              drawerEvent: handleDrawerEvent,
            ),
          ], title: "Notifications")
        ],
      ),
    );
  }
}
