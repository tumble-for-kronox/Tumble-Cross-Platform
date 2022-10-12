import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/app_switch/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/custom_alerts.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/to_top_button.dart';
import 'package:tumble/core/ui/tumble_loading.dart';
import 'tumble_list_view_day_container.dart';

class TumbleListView extends StatelessWidget {
  const TumbleListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppNavigator navigator = BlocProvider.of<AppNavigator>(context);
    return BlocBuilder<AppSwitchCubit, AppSwitchState>(
      builder: (context, state) {
        switch (state.status) {
          case AppScheduleViewStatus.INITIAL:
            return DynamicErrorPage(
              toSearch: true,
              description: S.popUps.scheduleHelpFirstLine(),
              errorType: RuntimeErrorType.noCachedSchedule(),
            );
          case AppScheduleViewStatus.LOADING:
            return const TumbleLoading();
          case AppScheduleViewStatus.POPULATED_VIEW:
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<AppSwitchCubit>().setLoading();
                    await context.read<AppSwitchCubit>().forceRefreshAll();
                  },
                  child: SingleChildScrollView(
                    controller: context.read<AppSwitchCubit>().controller,
                    child: Column(
                        children: state.listOfDays!
                            .where((day) =>
                                day.events.isNotEmpty &&
                                day.isoString.isAfter(DateTime.now().subtract(const Duration(days: 1))))
                            .map((day) => TumbleListViewDayContainer(
                                  day: day,
                                  mainAppCubit: BlocProvider.of<AppSwitchCubit>(context),
                                ))
                            .toList()),
                  ),
                ),
                AnimatedPositioned(
                  bottom: 30,
                  right: context.read<AppSwitchCubit>().toTopButtonVisible() ? 35 : -60,
                  duration: const Duration(milliseconds: 200),
                  child: ToTopButton(scrollToTop: () => context.read<AppSwitchCubit>().scrollToTop()),
                ),
              ],
            );
          case AppScheduleViewStatus.FETCH_ERROR:
            return DynamicErrorPage(
              toSearch: false,
              errorType: RuntimeErrorType.scheduleFetchError(),
              description: S.popUps.scheduleIsEmptyTitle(),
            );

          case AppScheduleViewStatus.EMPTY_SCHEDULE:
            return DynamicErrorPage(
              toSearch: false,
              errorType: RuntimeErrorType.emptyScheduleError(),
              description: S.popUps.scheduleIsEmptyBody(),
            );

          case AppScheduleViewStatus.NO_VIEW:
            return DynamicErrorPage(
              toSearch: true,
              errorType: RuntimeErrorType.noBookmarks(),
              description: S.popUps.scheduleHelpFirstLine(),
            );
        }
      },
    );
  }
}
