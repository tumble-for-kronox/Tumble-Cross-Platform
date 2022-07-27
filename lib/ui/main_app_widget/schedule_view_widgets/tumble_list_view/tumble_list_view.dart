import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/no_schedule.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_list_view/data/cupertino_alerts.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_list_view/data/to_top_button.dart';
import '../../../../theme/data/colors.dart';
import 'tumble_list_view_day_container.dart';

class TumbleListView extends StatelessWidget {
  const TumbleListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        if (state is MainAppScheduleSelected) {
          final List<TumbleListViewDayContainer>
              tumbleListViewDayContainerList = state.listOfDays
                  .where((day) => day.events.isNotEmpty)
                  .map((day) => TumbleListViewDayContainer(
                        day: day,
                      ))
                  .toList();
          if (tumbleListViewDayContainerList.isNotEmpty) {
            return Stack(
              children: [
                SingleChildScrollView(
                  controller: context.read<MainAppCubit>().controller,
                  child: Column(children: tumbleListViewDayContainerList),
                ),
                AnimatedPositioned(
                  bottom: 35,
                  right: state.listViewToTopVisible ? 35 : -60,
                  duration: const Duration(milliseconds: 200),
                  child: ToTopButton(
                      scrollToTop: () =>
                          context.read<MainAppCubit>().scrollToTop()),
                ),
              ],
            );
          }
          return NoScheduleAvailable(
            errorType: 'Schedule is empty',
            cupertinoAlertDialog: CustomCupertinoAlerts.scheduleContainsNoViews(
                context,
                () => context
                    .read<MainAppNavigationCubit>()
                    .getNavBarItem(NavbarItem.SEARCH)),
          );
        }
        if (state is MainAppLoading) {
          return const SpinKitThreeBounce(color: CustomColors.orangePrimary);
        }
        return NoScheduleAvailable(
          errorType: 'No bookmarked schedules',
          cupertinoAlertDialog: CustomCupertinoAlerts.noBookMarkedSchedules(
              context,
              () => context
                  .read<MainAppNavigationCubit>()
                  .getNavBarItem(NavbarItem.SEARCH)),
        );
      },
    );
  }
}
