
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/bottom_nav_bar/tumble_navigation_bar.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/app_switch/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_app_bar.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/cubit/drawer_state.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/tumble_app_drawer.dart';
import 'package:tumble/core/ui/schedule/tumble_calendar_view/tumble_calendar_view.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/tumble_week_view.dart';
import 'package:tumble/core/ui/search/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/search/search/tumble_search_page.dart';
import 'package:tumble/core/ui/user/cubit/user_event_cubit.dart';
import 'package:tumble/core/ui/user/resources/cubit/resource_cubit.dart';
import 'package:tumble/core/ui/user/tumble_user_overview_page_switch.dart';

class InitializedNavigationRootPage extends StatefulWidget {
  const InitializedNavigationRootPage({Key? key}) : super(key: key);

  @override
  State<InitializedNavigationRootPage> createState() =>
      _InitializedNavigationRootPageState();
}

class _InitializedNavigationRootPageState
    extends State<InitializedNavigationRootPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainAppNavigationCubit(),
      child: BlocBuilder<MainAppNavigationCubit, MainAppNavigationState>(
        builder: (context, navState) {
          return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              endDrawer: MultiBlocProvider(
                providers: [
                  BlocProvider<DrawerCubit>(
                      create: (_) =>
                          DrawerCubit(Localizations.localeOf(context))),
                  BlocProvider<AppSwitchCubit>.value(
                      value: BlocProvider.of<AppSwitchCubit>(context))
                ],
                child: const TumbleAppDrawer(),
              ),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                        value: BlocProvider.of<AppSwitchCubit>(context)),
                    BlocProvider.value(
                        value:
                            BlocProvider.of<MainAppNavigationCubit>(context)),
                    BlocProvider.value(
                        value: BlocProvider.of<AppNavigator>(context))
                  ],
                  child: TumbleAppBar(
                    pageIndex: navState.index,
                    toggleBookmark: () async {
                      await context
                          .read<SearchPageCubit>()
                          .toggleFavorite(context)
                          .then((_) {
                        BlocProvider.of<AppSwitchCubit>(context).setLoading();
                        BlocProvider.of<AppSwitchCubit>(context)
                            .attemptToFetchCachedSchedules();
                        BlocProvider.of<MainAppNavigationCubit>(context)
                            .getNavBarItem(NavbarItem.LIST);
                      });
                    },
                  ),
                ),
              ),
              body: BlocListener<AuthCubit, AuthState>(
                listenWhen: ((previous, current) =>
                    previous.status != current.status &&
                    current.status == AuthStatus.AUTHENTICATED),
                listener: (context, state) {
                  context
                      .read<UserEventCubit>()
                      .getUserEvents(context.read<AuthCubit>(), true);
                  context
                      .read<ResourceCubit>()
                      .getSchoolResources(context.read<AuthCubit>());
                  context
                      .read<ResourceCubit>()
                      .getUserBookings(context.read<AuthCubit>());
                  if (context.read<UserEventCubit>().state.autoSignup) {
                    context.read<AuthCubit>().runAutoSignup();
                  }
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: () {
                    switch (context
                        .read<MainAppNavigationCubit>()
                        .state
                        .navbarItem) {
                      case NavbarItem.SEARCH:
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                                value:
                                    BlocProvider.of<AppSwitchCubit>(context)),
                            BlocProvider.value(
                                value: BlocProvider.of<MainAppNavigationCubit>(
                                    context)),
                            BlocProvider.value(
                                value:
                                    BlocProvider.of<SearchPageCubit>(context))
                          ],
                          key: const ValueKey<int>(0),
                          child: const TumbleSearchPage(),
                        );
                      case NavbarItem.LIST:
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                                value:
                                    BlocProvider.of<AppSwitchCubit>(context)),
                            BlocProvider.value(
                                value: BlocProvider.of<MainAppNavigationCubit>(
                                    context)),
                          ],
                          key: const ValueKey<int>(1),
                          child: const TumbleListView(),
                        );
                      case NavbarItem.WEEK:
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                                value:
                                    BlocProvider.of<AppSwitchCubit>(context)),
                            BlocProvider.value(
                                value: BlocProvider.of<MainAppNavigationCubit>(
                                    context)),
                            BlocProvider.value(
                                value:
                                    BlocProvider.of<AppSwitchCubit>(context)),
                            BlocProvider.value(
                                value: BlocProvider.of<MainAppNavigationCubit>(
                                    context)),
                          ],
                          key: const ValueKey<int>(2),
                          child: const TumbleWeekView(),
                        );
                      case NavbarItem.CALENDAR:
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                                value:
                                    BlocProvider.of<AppSwitchCubit>(context)),
                            BlocProvider.value(
                                value: BlocProvider.of<MainAppNavigationCubit>(
                                    context)),
                          ],
                          key: const ValueKey<int>(3),
                          child: const TumbleCalendarView(),
                        );
                      case NavbarItem.USER_OVERVIEW:
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                                value: BlocProvider.of<AuthCubit>(context)),
                            BlocProvider.value(
                                value:
                                    BlocProvider.of<UserEventCubit>(context)),
                          ],
                          key: const ValueKey<int>(4),
                          child: const TumbleUserOverviewPageSwitch(),
                        );
                    }
                  }(),
                ),
              ),
              bottomNavigationBar: TumbleNavigationBar(onTap: (index) {
                BlocProvider.of<MainAppNavigationCubit>(context)
                    .getNavBarItem(NavbarItem.values[index]);
              }));
        },
      ),
    );
  }
}
