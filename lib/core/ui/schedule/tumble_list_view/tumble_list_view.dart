import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
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

class TumbleListView extends StatefulWidget {
  const TumbleListView({Key? key}) : super(key: key);

  @override
  State<TumbleListView> createState() => _TumbleListViewState();
}

class _TumbleListViewState extends State<TumbleListView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
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
            final dayList = state.listOfDays!
                .where((day) =>
                    day.events.isNotEmpty && day.isoString.isAfter(DateTime.now().subtract(const Duration(days: 1))))
                .toList();
            return Stack(
              children: [
                RefreshIndicator(
                    onRefresh: () async {
                      context.read<AppSwitchCubit>().setLoading();
                      await context.read<AppSwitchCubit>().forceRefreshAll();
                    },
                    child: ListView.builder(
                        controller: context.read<AppSwitchCubit>().controller,
                        itemCount: dayList.length,
                        itemBuilder: (context, index) {
                          if (index == 0 || dayList[index].isoString.year != dayList[index - 1].isoString.year) {
                            return Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    dayList[index].isoString.year.toString(),
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                                      fontSize: 110,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: TumbleListViewDayContainer(day: dayList[index]),
                                )
                              ],
                            );
                          }

                          return TumbleListViewDayContainer(day: dayList[index]);
                        })),
                AnimatedPositioned(
                  bottom: 30,
                  right: context.read<AppSwitchCubit>().toTopButtonVisible ? 35 : -60,
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
