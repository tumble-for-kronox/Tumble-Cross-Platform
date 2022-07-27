import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/theme/cubit/theme_cubit.dart';
import 'package:tumble/theme/cubit/theme_state.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/tumble_navigation_bar.dart';
import 'package:tumble/ui/main_app_widget/misc/tumble_app_drawer.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_calendar_view/tumble_calendar_view.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_list_view/tumble_list_view.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_week_view/tumble_week_view.dart';
import 'package:tumble/ui/main_app_widget/search_page_widgets/search/schedule_search_page.dart';

import 'misc/tumble_app_bar.dart';

class MainAppNavigationRoot extends StatefulWidget {
  const MainAppNavigationRoot({Key? key}) : super(key: key);

  @override
  State<MainAppNavigationRoot> createState() => _MainAppNavigationRootState();
}

class _MainAppNavigationRootState extends State<MainAppNavigationRoot> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppNavigationCubit, MainAppNavigationState>(
      builder: (context, navState) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: ((context, themeState) {
            return Scaffold(
                endDrawer: TumbleAppDrawer(
                  handleDrawerEvent: (eventType) => context
                      .read<MainAppCubit>()
                      .handleDrawerEvent(eventType, context),
                  limitOptions: false,
                  currentThemeString: themeState.themeString,
                ),
                appBar: TumbleAppBar(
                  visibleBookmark: navState.index == 1 ||
                      navState.index == 2 ||
                      navState.index == 3,
                  toggleFavorite: () async =>
                      await context.read<MainAppCubit>().toggleFavorite(),
                ),
                body: FutureBuilder(
                    future: context.read<MainAppCubit>().initCached(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (navState.navbarItem) {
                        case NavbarItem.SEARCH:
                          return const TumbleSearchPage();
                        case NavbarItem.USER_ACCOUNT:
                          return Container();
                        case NavbarItem.LIST:
                          return const TumbleListView();
                        case NavbarItem.WEEK:
                          return const TumbleWeekView();
                        case NavbarItem.CALENDAR:
                          return const TumbleCalendarView();
                      }
                    }),
                bottomNavigationBar: TumbleNavigationBar(onTap: (index) {
                  context
                      .read<MainAppNavigationCubit>()
                      .getNavBarItem(NavbarItem.values[index]);
                }));
          }),
        );
      },
    );
  }
}
