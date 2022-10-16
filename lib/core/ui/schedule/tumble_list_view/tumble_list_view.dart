import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/ui/cubit/schedule_view_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/schedule/event_options.dart';
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
    return BlocBuilder<ScheduleViewCubit, ScheduleViewState>(
      builder: (context, state) {
        switch (state.status) {
          case ScheduleViewStatus.INITIAL:
            return DynamicErrorPage(
              toSearch: true,
              description: S.popUps.scheduleHelpFirstLine(),
              errorType: RuntimeErrorType.noCachedSchedule(),
            );
          case ScheduleViewStatus.LOADING:
            return const TumbleLoading();
          case ScheduleViewStatus.POPULATED_VIEW:
            final dayList = state.listOfDays!
                .where((day) =>
                    day.events.isNotEmpty && day.isoString.isAfter(DateTime.now().subtract(const Duration(days: 1))))
                .toList();
            return Stack(
              children: [
                RefreshIndicator(
                    onRefresh: () async {
                      context.read<ScheduleViewCubit>().setLoading();
                      await context.read<ScheduleViewCubit>().forceRefreshAll();
                    },
                    child: ListView.builder(
                        controller: context.read<ScheduleViewCubit>().controller,
                        itemCount: dayList.length,
                        itemBuilder: (context, index) {
                          if (index == 0 || dayList[index].isoString.year != dayList[index - 1].isoString.year) {
                            return Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    dayList[index].isoString.year.toString(),
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onBackground,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: BlocProvider.value(
                                    value: BlocProvider.of<ScheduleViewCubit>(context),
                                    child: TumbleListViewDayContainer(day: dayList[index]),
                                  ),
                                )
                              ],
                            );
                          }

                          return TumbleListViewDayContainer(day: dayList[index]);
                        })),
                AnimatedPositioned(
                  bottom: 30,
                  right: context.read<ScheduleViewCubit>().toTopButtonVisible ? 35 : -60,
                  duration: const Duration(milliseconds: 200),
                  child: ToTopButton(scrollToTop: () => context.read<ScheduleViewCubit>().scrollToTop()),
                ),
              ],
            );
          case ScheduleViewStatus.FETCH_ERROR:
            return DynamicErrorPage(
              toSearch: false,
              errorType: RuntimeErrorType.scheduleFetchError(),
              description: S.popUps.scheduleIsEmptyTitle(),
            );

          case ScheduleViewStatus.EMPTY_SCHEDULE:
            return DynamicErrorPage(
              toSearch: false,
              errorType: RuntimeErrorType.emptyScheduleError(),
              description: S.popUps.scheduleIsEmptyBody(),
            );

          case ScheduleViewStatus.NO_VIEW:
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
