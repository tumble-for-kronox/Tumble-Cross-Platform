import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/refactor/core/navigation/app_navigator.dart';
import 'package:tumble/refactor/ui/cubit/root_page_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/tumble_navigation_bar.dart';
import 'package:tumble/ui/main_app_widget/misc/tumble_app_bar.dart';
import 'package:tumble/ui/main_app_widget/misc/tumble_drawer/tumble_app_drawer.dart';

class RootPage extends StatefulWidget {
  final Widget? child;

  const RootPage({Key? key, this.child}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final _label = [
    'TumbleSearchPage',
    'TumbleListView',
    'TumbleWeekView',
    'TumbleCalendarView',
    'Account'
  ];

  @override
  Widget build(BuildContext context) {
    final navigator = BlocProvider.of<AppNavigator>(context);
    return Scaffold(
      drawer: const TumbleAppDrawer(),
      bottomNavigationBar:
          !BlocProvider.of<RootPageCubit>(context).state.needSchool
              ? TumbleNavigationBar(onTap: (index) {
                  navigator.pushAndRemoveAll(_label[index]);
                  BlocProvider.of<MainAppNavigationCubit>(context)
                      .getNavBarItem(NavbarItem.values[index]);
                })
              : null,
      body: widget.child,
    );
  }
}
