import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/home_page_widget/bottom_nav_widget/cubit/bottom_nav_cubit.dart';
import 'package:tumble/ui/home_page_widget/bottom_nav_widget/custom_bottom_bar.dart';
import 'package:tumble/ui/home_page_widget/cubit/home_page_cubit.dart';
import 'package:tumble/ui/home_page_widget/home_page.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_list_view.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_week_view.dart';
import 'package:tumble/ui/home_page_widget/school_selection_page.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app.dart';
import 'package:tumble/ui/search_page_widgets/cubit/search_page_cubit.dart';
import 'package:tumble/ui/search_page_widgets/search/schedule_search_bar.dart';
import 'package:tumble/ui/search_page_widgets/search/schedule_search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSingletons();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<MainAppCubit>(
      create: (c) => MainAppCubit(),
      child: Row(
        children: const [
          MainApp(),
          SchoolSelectionPage(),
        ],
      ),
    ),
    BlocProvider<BottomNavCubit>(
        create: (c) => BottomNavCubit(), child: const CustomBottomBar()),

    /// Currently shared state between all
    /// descendants of HomePage. Maybe not?
    BlocProvider<HomePageCubit>(
      create: (c) => HomePageCubit(),
      child: Row(
        children: const [HomePage(), TumbleListView(), TumbleWeekView()],
      ),
    ),
    BlocProvider<SearchPageCubit>(
      create: (c) => SearchPageCubit(),
      child: Row(children: const [
        ScheduleSearchPage(),
        ScheduleSearchBar(),
      ]),
    ),
  ], child: const MainApp()));
}
