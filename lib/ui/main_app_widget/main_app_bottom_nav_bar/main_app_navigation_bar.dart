import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/ui/main_app_widget/data/labels.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/cubit/bottom_nav_cubit.dart';

typedef ChangePageCallBack = void Function(int index);

class MainAppNavigationBar extends StatelessWidget {
  final ChangePageCallBack? onTap;
  const MainAppNavigationBar({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MainAppNavigationCubit, MainAppNavigationState>(
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
                  icon: Icon(CupertinoIcons.search), label: Labels.list),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: Labels.week),
            ],
          );
        },
      );
}
