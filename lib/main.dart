import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/theme/cubit/theme_cubit.dart';
import 'package:tumble/theme/repository/theme_repository.dart';
import 'package:tumble/ui/cubit/init_cubit.dart';
import 'package:tumble/ui/drawer_generic/app_theme_picker.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/main_app_navigation_bar.dart';
import 'package:tumble/ui/main_app_widget/main_app_navigation_root.dart';
import 'package:tumble/ui/main_app_widget/misc/tumble_app_bar.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_list_view/tumble_list_view.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_week_view/tumble_week_view.dart';
import 'package:tumble/ui/main_app_widget/school_selection_page.dart';
import 'package:tumble/ui/main_app_widget/search_page_widgets/cubit/search_page_cubit.dart';
import 'package:tumble/ui/main_app_widget/search_page_widgets/search/schedule_search_bar.dart';
import 'package:tumble/ui/main_app_widget/search_page_widgets/search/schedule_search_page.dart';
import 'package:tumble/ui/main_app_widget/search_page_widgets/search_bar_widget/searchbar_and_logo_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSingletons();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<InitCubit>(
      create: (c) => InitCubit(),
      child: Row(
        children: const [
          MainApp(),
          SchoolSelectionPage(),
        ],
      ),
    ),
    BlocProvider<MainAppNavigationCubit>(
      create: (c) => MainAppNavigationCubit(),
      child: Row(
        children: const [TumbleNavigationBar(), MainAppNavigationRoot(), ScheduleSearchPage()],
      ),
    ),
    BlocProvider<MainAppCubit>(
      create: (c) => MainAppCubit(),
      child: Row(
        children: const [
          TumbleAppBar(),
          TumbleWeekView(),
          TumbleListView(),
          MainAppNavigationRoot(),
          MainApp(),
          SchoolSelectionPage(),
        ],
      ),
    ),
    BlocProvider<SearchPageCubit>(
      create: (c) => SearchPageCubit(),
      child: Row(children: const [ScheduleSearchPage(), ScheduleSearchBar(), SearchBarAndLogoContainer()]),
    ),
    BlocProvider<ThemeCubit>(
      create: (c) => ThemeCubit()..getCurrentTheme(),
      child: Row(children: const [MainApp()]),
    ),
  ], child: const MainApp()));
}
