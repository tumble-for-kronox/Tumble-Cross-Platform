import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/ui/home_page_widget/bottom_nav_widget/cubit/bottom_nav_cubit.dart';
import 'package:tumble/ui/home_page_widget/data/labels.dart';

typedef ChangePageCallBack = void Function(int index);

class CustomBottomBar extends StatelessWidget {
  final ChangePageCallBack? onTap;
  const CustomBottomBar({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: const IconThemeData(size: 28),

            /// Dynamically updates the index of the bottom bar,
            /// but only actually changes page 'state' in HomePage
            /// if the state is not [HomePageError]
            onTap: (index) {
              onTap;
              context.read<BottomNavCubit>().updateIndex(index);
            },
            currentIndex: state,
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 20,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_view_day_rounded),
                  label: Labels.list),
              BottomNavigationBarItem(
                  icon: Icon(Icons.view_week_rounded), label: Labels.week),
            ],
          );
        },
      );
}
