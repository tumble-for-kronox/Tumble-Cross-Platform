import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/app_navigator_provider.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/cubit/init_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/login_page/cubit/login_page_state.dart';
import 'package:tumble/core/ui/main_app_widget/login_page/login_page_root.dart';
import 'package:tumble/core/ui/main_app.dart';
import 'package:tumble/core/ui/main_app_widget/main_app_bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/main_app_navigation_root.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/cubit/drawer_state.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/tumble_app_drawer.dart';
import 'package:tumble/core/ui/main_app_widget/schedule_view_widgets/tumble_calendar_view/tumble_calendar_view.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_app_bar.dart';
import 'package:tumble/core/ui/main_app_widget/schedule_view_widgets/tumble_list_view/tumble_list_view.dart';
import 'package:tumble/core/ui/main_app_widget/schedule_view_widgets/tumble_week_view/tumble_week_view.dart';
import 'package:tumble/core/ui/main_app_widget/school_selection_page.dart';
import 'package:tumble/core/ui/main_app_widget/search_page_widgets/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/search_page_widgets/search/schedule_search_bar.dart';
import 'package:tumble/core/ui/main_app_widget/search_page_widgets/search/tumble_search_page.dart';
import 'package:tumble/core/ui/main_app_widget/search_page_widgets/search_bar_widget/searchbar_and_logo_container.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<InitCubit>(
            create: (c) => InitCubit(),
            child: Row(
              children: const [
                MainApp(),
                SchoolSelectionPage(),
                LoginPageRoot(),
              ],
            ),
          ),
          BlocProvider<MainAppNavigationCubit>(
            create: (c) => MainAppNavigationCubit(),
            child: Row(
              children: const [MainApp()],
            ),
          ),
          BlocProvider<MainAppCubit>(
            create: (c) => MainAppCubit(),
            child: Row(
              children: const [
                TumbleAppBar(),
                TumbleSearchPage(),
                TumbleCalendarView(),
                TumbleWeekView(),
                TumbleListView(),
                MainAppNavigationRootPage(),
                MainApp(),
                SchoolSelectionPage(),
              ],
            ),
          ),
          BlocProvider<SearchPageCubit>(
            create: (c) => SearchPageCubit(),
            child: Row(children: const [
              TumbleSearchPage(),
              ScheduleSearchBar(),
              SearchBarAndLogoContainer(),
            ]),
          ),
          BlocProvider<ThemeCubit>(
            create: (c) => ThemeCubit()..getCurrentTheme(),
            child: Row(children: const [
              MainApp(),
            ]),
          ),
          BlocProvider<DrawerCubit>(
            create: (c) => DrawerCubit(),
            child: Row(
              children: const [
                TumbleAppDrawer(),
                SchoolSelectionPage(),
                MainAppNavigationRootPage()
              ],
            ),
          ),
          BlocProvider<LoginPageCubit>(
              create: (c) => LoginPageCubit(),
              child: Row(
                children: const [
                  LoginPageRoot(),
                ],
              )),
          BlocProvider<AppNavigator>(create: (_) => AppNavigator()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: ((context, state) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Tumble',
                  theme: ThemeData(
                    colorScheme: CustomColors.lightColors,
                    fontFamily: 'Roboto',
                  ),
                  darkTheme: ThemeData(
                    colorScheme: CustomColors.darkColors,
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      selectedItemColor: CustomColors.darkColors.primary,
                    ),
                    fontFamily: 'Roboto',
                  ),
                  themeMode: state.themeMode,
                  home: const AppNavigatorProvider(
                      initialPages: [NavigationRouteLabels.mainAppPage]),
                ))));
  }
}
