import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/theme/colors.dart';
import 'package:tumble/ui/home_page_widget/data/event_types.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/misc/tumble_app_drawer_tile.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/misc/tumble_settings_section.dart';

class TumbleAppDrawer extends StatelessWidget {
  const TumbleAppDrawer({Key? key}) : super(key: key);

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
              subtitle: "Get support from our support team",
              prefixIcon: CupertinoIcons.bubble_left_bubble_right,
              eventType: EventTypes.CONTACT,
              drawerEvent: (eventType) => {null},
            ),
          ], title: "Support"),
          const SizedBox(height: 20.0),

          /// Common
          TumbleSettingsSection(tiles: [
            TumbleAppDrawerTile(
              drawerTileTitle: "Change schools",
              subtitle: "Current default school is HKR",
              prefixIcon: CupertinoIcons.arrow_right_arrow_left,
              eventType: EventTypes.CHANGE_SCHOOL,
              drawerEvent: (eventType) => {null},
            ),
            TumbleAppDrawerTile(
              drawerTileTitle: "Change theme",
              subtitle: "Current theme: Dark theme",
              prefixIcon: CupertinoIcons.device_phone_portrait,
              eventType: EventTypes.CHANGE_THEME,
              drawerEvent: (eventType) => {null},
            ),
          ], title: "Common"),
          const SizedBox(height: 20.0),

          /// Schedule
          TumbleSettingsSection(tiles: [
            TumbleAppDrawerTile(
              drawerTileTitle: "Set default view type",
              subtitle: "Current view: List view",
              prefixIcon: CupertinoIcons.list_dash,
              eventType: EventTypes.SET_DEFAULT_VIEW,
              drawerEvent: (eventType) => {null},
            ),
            TumbleAppDrawerTile(
              drawerTileTitle: "Set default schedule",
              subtitle: "No default schedule set",
              prefixIcon: CupertinoIcons.calendar,
              eventType: EventTypes.SET_DEFAULT_SCHEDULE,
              drawerEvent: (eventType) => {null},
            ),
          ], title: "Schedule"),
          const SizedBox(height: 20.0),

          /// Notifications
          TumbleSettingsSection(tiles: [
            TumbleAppDrawerTile(
              drawerTileTitle: "Cancel all notifications",
              subtitle: "Cancel all scheduled notifications",
              prefixIcon: CupertinoIcons.text_badge_xmark,
              eventType: EventTypes.CANCEL_ALL_NOTIFICATIONS,
              drawerEvent: (eventType) => {null},
            ),
            TumbleAppDrawerTile(
              drawerTileTitle: "Cancel notifications for\nprogram",
              subtitle: "Cancel notifications for this program",
              prefixIcon: CupertinoIcons.text_badge_minus,
              eventType: EventTypes.CANCEL_NOTIFICATIONS_FOR_PROGRAM,
              drawerEvent: (eventType) => {null},
            ),
            TumbleAppDrawerTile(
              drawerTileTitle: "Edit notification time",
              subtitle: "Notifications will show 3 hours prior to event",
              prefixIcon: CupertinoIcons.time,
              eventType: EventTypes.EDIT_NOTIFICATION_TIME,
              drawerEvent: (eventType) => {null},
            ),
          ], title: "Notifications")
        ],
      ),
    );
  }
}
