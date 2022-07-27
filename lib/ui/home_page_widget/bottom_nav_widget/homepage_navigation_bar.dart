import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/ui/home_page_widget/bottom_nav_widget/cubit/bottom_nav_cubit.dart';
import 'package:tumble/ui/home_page_widget/data/labels.dart';

typedef ChangePageCallBack = void Function(int index);

class HomePageNavigationBar extends StatelessWidget {
  final ChangePageCallBack? onTap;
  const HomePageNavigationBar({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomePageNavigationCubit, HomePageNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: const IconThemeData(size: 28),

            /// Dynamically updates the index of the bottom bar,
            /// but only actually changes page 'state' in HomePage
            /// if the state is not [HomePageError]
            onTap: onTap,
            currentIndex: state.index,
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 20,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.list_bullet), label: Labels.list),
              BottomNavigationBarItem(
                  icon: Icon(Icons.view_week_rounded), label: Labels.week),
            ],
          );
        },
      );
}
