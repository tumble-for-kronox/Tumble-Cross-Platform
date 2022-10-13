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
  @override
  void initState() {
    _navigationCubit = NavigationCubit();
    _scheduleViewCubit = ScheduleViewCubit();
    _searchPageCubit = SearchPageCubit();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _navigationCubit,
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
                child: const TumbleAppDrawer(),
              ),
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: TumbleAppBar(),
              ),
              body: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  /* if (context.read<UserEventCubit>().state.autoSignup) {
                    context.read<AuthCubit>().runAutoSignup();
                  } */
                },
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _searchPageCubit,
                    ),
                    BlocProvider.value(
                      value: _scheduleViewCubit,
                    ),
                  ],
                  child: BlocListener<SearchPageCubit, SearchPageState>(
                    listenWhen: (previous, current) =>
                        previous.previewToggledFavorite != current.previewToggledFavorite,
                    listener: (context, state) {
                      log(name: 'navigation_root_page', 'Fetching new schedules ..');
                      _scheduleViewCubit.getCachedSchedules();
                    },
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
                            return const TumbleUserOverviewPageSwitch();
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
}
