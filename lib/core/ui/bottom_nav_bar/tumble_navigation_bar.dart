import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/main_app/data/labels.dart';

typedef ChangePageCallBack = void Function(int index);

class TumbleNavigationBar extends StatelessWidget {
  final ChangePageCallBack? onTap;
  const TumbleNavigationBar({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppNavigationCubit, MainAppNavigationState>(
      builder: (context, mainappstate) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
                spreadRadius: 0,
                blurRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedIconTheme: const IconThemeData(size: 24),
              unselectedIconTheme: const IconThemeData(size: 22),
              onTap: onTap,
              selectedFontSize: 12,
              unselectedFontSize: 10,
              showUnselectedLabels: false,
              currentIndex: mainappstate.index,
              backgroundColor: Theme.of(context).colorScheme.background,
              elevation: 100,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.search,
                    ),
                    label: Labels.search),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.collections), label: Labels.list),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet_indent), label: Labels.week),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar_today), label: Labels.calendar),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: Labels.account),
              ],
            ),
          ),
        );
      },
    );
  }
}
