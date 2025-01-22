import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/cubit/bottom_nav_cubit.dart';

import '../data/string_constants.dart';

typedef ChangePageCallBack = void Function(int index);

class TumbleNavigationBar extends StatelessWidget {
  final ChangePageCallBack? onTap;
  const TumbleNavigationBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, mainappstate) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: const IconThemeData(size: 26),
            unselectedIconTheme: IconThemeData(
                size: 24, color: Theme.of(context).colorScheme.onSurface),
            onTap: onTap,
            selectedFontSize: 14,
            unselectedFontSize: 13,
            currentIndex: mainappstate.index,
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(
                    CupertinoIcons.search,
                  ),
                  label: S.searchPage.title()),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.collections),
                label: S.listViewPage.title(),
              ),
              BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.list_bullet_indent),
                  label: S.weekViewPage.title()),
              BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.calendar_today),
                  label: S.calendarViewPage.title()),
              BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.person),
                  label: S.authorizedPage.title()),
            ],
          ),
        );
      },
    );
  }
}
