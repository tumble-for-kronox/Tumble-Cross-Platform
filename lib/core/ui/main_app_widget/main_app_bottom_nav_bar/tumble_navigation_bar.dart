import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/main_app_widget/data/labels.dart';
import 'package:tumble/core/ui/main_app_widget/main_app_bottom_nav_bar/cubit/bottom_nav_cubit.dart';

typedef ChangePageCallBack = void Function(int index);

class TumbleNavigationBar extends StatelessWidget {
  final ChangePageCallBack? onTap;
  const TumbleNavigationBar({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppNavigationCubit, MainAppNavigationState>(
      builder: (context, mainappstate) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(size: 28),
          onTap: onTap,
          currentIndex: mainappstate.index,
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 20,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search), label: Labels.search),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.collections), label: Labels.list),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.list_bullet_indent),
                label: Labels.week),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.calendar_today),
                label: Labels.calendar),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: Labels.account),
          ],
        );
      },
    );
  }
}
