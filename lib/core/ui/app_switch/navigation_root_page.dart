import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/bottom_nav_bar/tumble_navigation_bar.dart';
import 'package:tumble/core/ui/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_app_bar.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/tumble_app_drawer.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/cubit/resource_cubit.dart';
import 'package:tumble/core/ui/cubit/schedule_view_cubit.dart';
import 'package:tumble/core/ui/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/cubit/user_event_cubit.dart';
import 'package:tumble/core/ui/permission_handler.dart';
import 'package:tumble/core/ui/schedule/tumble_calendar_view/tumble_calendar_view.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/tumble_week_view.dart';
import 'package:tumble/core/ui/search/tumble_search_page.dart';
import 'package:tumble/core/ui/user/tumble_user_overview_page_switch.dart';

class NavigationRootPage extends StatefulWidget {
  const NavigationRootPage({Key? key}) : super(key: key);

  @override
  State<NavigationRootPage> createState() => _NavigationRootPageState();
}

class _NavigationRootPageState extends State<NavigationRootPage> {
  late NavigationCubit _navigationCubit;
  late ScheduleViewCubit _scheduleViewCubit;
  late SearchPageCubit _searchPageCubit;
  late UserEventCubit _userEventCubit;
  late ResourceCubit _resourceCubit;
  bool calledThisBuild = false;
  @override
  void initState() {
    _navigationCubit = NavigationCubit();
    _scheduleViewCubit = ScheduleViewCubit();
    _searchPageCubit = SearchPageCubit();
    _userEventCubit = UserEventCubit();
    _resourceCubit = ResourceCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (context.read<AppSwitchCubit>().notificationCheck) {
        showDialog(
            barrierDismissible: false,
            useRootNavigator: false,
            context: context,
            builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<AppSwitchCubit>(context),
                  child: const PermissionHandler(),
                ));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _navigationCubit.close();
    _scheduleViewCubit.close();
    _searchPageCubit.close();
    _userEventCubit.close();
    _resourceCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _navigationCubit,
        ),
        BlocProvider.value(
          value: _resourceCubit,
        ),
        BlocProvider.value(
          value: _userEventCubit,
        ),
      ],
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, navState) {
          //_getEventsAndResources(context);
          return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              endDrawer: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: _scheduleViewCubit,
                  ),
                  BlocProvider.value(
                    value: context.read<AppSwitchCubit>(),
                  ),
                  BlocProvider.value(
                    value: context.read<AuthCubit>(),
                  ),
                ],
                child: TumbleAppDrawer(reloadViews: () async {
                  final bookmarks = _searchPageCubit.updateBookmarkView();
                  if (!bookmarks.contains(_searchPageCubit.state.previewCurrentScheduleId)) {
                    _searchPageCubit.resetPreviewButton();
                  }
                }),
              ),
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: TumbleAppBar(),
              ),
              body: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (context.read<UserEventCubit>().state.autoSignup) {
                    context.read<AuthCubit>().runAutoSignup();
                  }
                },
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _searchPageCubit,
                    ),
                    BlocProvider.value(
                      value: _scheduleViewCubit,
                    ),
                    BlocProvider.value(
                      value: BlocProvider.of<AuthCubit>(context),
                    ),
                    BlocProvider.value(
                      value: BlocProvider.of<AppSwitchCubit>(context),
                    )
                  ],
                  child: MultiBlocListener(
                    listeners: [
                      BlocListener<SearchPageCubit, SearchPageState>(
                        listenWhen: (previous, current) =>
                            previous.previewToggledFavorite != current.previewToggledFavorite,
                        listener: (context, state) {
                          log(name: 'navigation_root_page', 'Fetching new schedules ..');
                          _scheduleViewCubit.setLoading();
                          _scheduleViewCubit.getCachedSchedules();
                        },
                      ),
                      BlocListener<AuthCubit, AuthState>(
                        listenWhen: (previous, current) =>
                            (current.status == AuthStatus.AUTHENTICATED) ||
                            (previous.status == AuthStatus.INITIAL && current.status == AuthStatus.AUTHENTICATED),
                        listener: (context, state) {
                          _initialiseUserData(context);
                        },
                      ),
                    ],
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: () {
                        switch (context.read<NavigationCubit>().state.navbarItem) {
                          case NavbarItem.SEARCH:
                            return const TumbleSearchPage();
                          case NavbarItem.LIST:
                            return const TumbleListView();
                          case NavbarItem.WEEK:
                            return const TumbleWeekView();
                          case NavbarItem.CALENDAR:
                            return const TumbleCalendarView();
                          case NavbarItem.USER_OVERVIEW:
                            return BlocProvider.value(
                              value: BlocProvider.of<AuthCubit>(context),
                              child: Builder(builder: (context) {
                                return const TumbleUserOverviewPageSwitch();
                              }),
                            );
                        }
                      }(),
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: TumbleNavigationBar(onTap: (index) {
                context.read<NavigationCubit>().getNavBarItem(NavbarItem.values[index]);
              }));
        },
      ),
    );
  }

  void _initialiseUserData(BuildContext context) {
    if (context.read<AuthCubit>().state.status == AuthStatus.AUTHENTICATED) {
      context.read<UserEventCubit>().getUserEvents(
          context.read<AuthCubit>().state.status,
          context.read<AuthCubit>().login,
          context.read<AuthCubit>().logout,
          context.read<AuthCubit>().state.userSession!.sessionToken,
          true);
      context.read<ResourceCubit>().getSchoolResources(
            context.read<AuthCubit>().state.userSession!.sessionToken,
            context.read<AuthCubit>().login,
            context.read<AuthCubit>().logout,
          );
      context.read<ResourceCubit>().getUserBookings(
            context.read<AuthCubit>().state.userSession!.sessionToken,
            context.read<AuthCubit>().login,
            context.read<AuthCubit>().logout,
          );
    }
  }
}
