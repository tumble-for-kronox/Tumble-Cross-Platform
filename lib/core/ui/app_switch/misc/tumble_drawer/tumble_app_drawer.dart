import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/ui/app_switch/app_switch.dart';
import 'package:tumble/core/ui/app_switch/school_selection_page.dart';
import 'package:tumble/core/ui/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/cubit/drawer_state.dart';
import 'package:tumble/core/ui/cubit/schedule_view_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/data/event_types.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/contributors_modal/contributors_modal.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/data/constants.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/drawer_generic/app_language_picker.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/support_modal/support_modal.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_app_drawer_tile.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/drawer_generic/app_bookmark_schedule_toggle.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/drawer_generic/app_notification_time_picker.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/drawer_generic/app_theme_picker.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_settings_section.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:url_launcher/url_launcher_string.dart';

typedef HandleDrawerEvent = void Function(
  Enum eventType,
);

class TumbleAppDrawer extends StatefulWidget {
  final VoidCallback reloadViews;
  const TumbleAppDrawer({Key? key, required this.reloadViews})
      : super(key: key);

  @override
  State<TumbleAppDrawer> createState() => _TumbleAppDrawerState();
}

class _TumbleAppDrawerState extends State<TumbleAppDrawer> {
  late DrawerCubit _drawerCubit;

  @override
  void didChangeDependencies() {
    _drawerCubit = DrawerCubit(Localizations.localeOf(context));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _drawerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _drawerCubit,
        ),
        BlocProvider.value(
          value: context.read<AppSwitchCubit>(),
        ),
        BlocProvider.value(
          value: context.read<AuthCubit>(),
        ),
      ],
      child: BlocBuilder<DrawerCubit, DrawerState>(
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        eventType: EventType.SCHOOL,
                        drawerEvent: (eventType) =>
                            _handleDrawerEvent(eventType, context),
                      ),
                      TumbleAppDrawerTile(
                        drawerTileTitle: S.settingsPage.changeThemeTitle(),
                        subtitle: S.settingsPage.changeThemeSubtitle(context
                            .read<DrawerCubit>()
                            .state
                            .theme!
                            .capitalize()),
                        suffixIcon: CupertinoIcons.device_phone_portrait,
                        eventType: EventType.THEME,
                        drawerEvent: (eventType) =>
                            _handleDrawerEvent(eventType, context),
                      ),
                      /* TumbleAppDrawerTile(
                        drawerTileTitle: S.settingsPage.languageTitle(),
                        subtitle: S.settingsPage.languageSubtitle(),
                        suffixIcon: CupertinoIcons.textformat_abc_dottedunderline,
                        eventType: EventType.LANGUAGE,
                        drawerEvent: (eventType) => _handleDrawerEvent(eventType, context),
                      ), */
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
                          drawerTileTitle:
                              S.settingsPage.defaultScheduleTitle(),
                          subtitle: S.settingsPage.defaultScheduleSubtitle(),
                          suffixIcon: CupertinoIcons.bookmark,
                          eventType: EventType.BOOKMARKS,
                          drawerEvent: (eventType) =>
                              _handleDrawerEvent(eventType, context)),
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
                          eventType: EventType.NOTIFICATIONS_CANCEL,
                          drawerEvent: (eventType) =>
                              _handleDrawerEvent(eventType, context)),
                      TumbleAppDrawerTile(
                        suffixIcon: CupertinoIcons.clock,
                        drawerTileTitle: S.settingsPage.offsetTitle(),
                        subtitle: S.settingsPage.offsetSubtitle(
                            context.read<DrawerCubit>().notificationOffset),
                        eventType: EventType.NOTIFICATIONS_OFFSET,
                        drawerEvent: (eventType) =>
                            _handleDrawerEvent(eventType, context),
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
                        eventType: EventType.BUG,
                        drawerEvent: (eventType) =>
                            _handleDrawerEvent(eventType, context),
                      ),
                      TumbleAppDrawerTile(
                        suffixIcon: CupertinoIcons.group,
                        drawerTileTitle: "Contributors",
                        subtitle: "See who helped out",
                        eventType: EventType.CONTRIBUTORS,
                        drawerEvent: (eventType) =>
                            _handleDrawerEvent(eventType, context),
                      ),
                    ], title: S.settingsPage.miscTitle()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleDrawerEvent(Enum eventType, BuildContext context) async {
    switch (eventType) {
      case EventType.SCHOOL:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<AppSwitchCubit>(),
                    ),
                    BlocProvider.value(
                      value: context.read<AuthCubit>(),
                    ),
                  ],
                  child: const SchoolSelectionPage(),
                )));
        break;
      case EventType.THEME:
        showModalBottomSheet(
            context: context,
            builder: (_) => ApplicationThemePicker(
                setTheme: (String themeType) {
                  context.read<DrawerCubit>().changeTheme(themeType);
                  Navigator.of(context).pop();
                },
                cubit: context.read<DrawerCubit>()));
        break;
      case EventType.LANGUAGE:
        showModalBottomSheet(
          context: context,
          builder: (_) => ApplicationLanguagePicker(
              currentLocale: BlocProvider.of<ThemeCubit>(context).state.locale,
              parameterMap: context.read<DrawerCubit>().getLangOptions(),
              setLocale: (Locale? locale) {
                context.read<DrawerCubit>().changeLocale(locale);
                Navigator.of(context).pop();
              }),
        );
        break;
      case EventType.BOOKMARKS:
        if (context.read<DrawerCubit>().state.bookmarks!.isNotEmpty) {
          List<BookmarkedScheduleModel> tempBookmarks =
              context.read<DrawerCubit>().state.bookmarks!;
          showModalBottomSheet(
              context: context,
              builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<DrawerCubit>(context),
                    child: const ApplicationBookmarkPicker(),
                  )).whenComplete(() async {
            if (tempBookmarks != context.read<DrawerCubit>().state.bookmarks!) {
              widget.reloadViews();
              context.read<ScheduleViewCubit>().setLoading();
              context.read<ScheduleViewCubit>().getCachedSchedules();
            }
          });
        }
        break;
      case EventType.NOTIFICATIONS_CANCEL:
        context.read<ScheduleViewCubit>().cancelAllNotifications();
        showScaffoldMessage(
            context, S.scaffoldMessages.cancelledAllSetNotifications());
        break;
      case EventType.NOTIFICATIONS_OFFSET:
        showModalBottomSheet(
            context: context,
            builder: (_) => AppNotificationOffsetPicker(
                  parameterMap:
                      context.read<DrawerCubit>().getNotificationTimes(context),
                  currentNotificationTime:
                      context.read<DrawerCubit>().state.notificationTime!,
                  setNotificationTime: (time) {
                    context.read<DrawerCubit>().setNotificationTime(time);
                    Navigator.of(context).pop();
                  },
                ));
        break;
      case EventType.SOURCE_CODE:
        await launchUrlString(Constants.gitHub);
        break;
      case EventType.BUG:
        BugReportModal.showBugReportModal(context, context.read<DrawerCubit>());
        break;
      case EventType.OPEN_REVIEW:
        final uri = Platform.isIOS ? Constants.ios : Constants.android;
        await launchUrlString(uri);
        break;
      case EventType.CONTRIBUTORS:
        showModalBottomSheet(
            context: context, builder: (_) => const ContributorsModal());
        break;
    }
  }
}
