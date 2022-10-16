import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/ui/cubit/schedule_view_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/week_list_view.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class TumbleWeekView extends StatefulWidget {
  const TumbleWeekView({Key? key}) : super(key: key);

  @override
  State<TumbleWeekView> createState() => _TumbleWeekViewState();
}

class _TumbleWeekViewState extends State<TumbleWeekView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleViewCubit, ScheduleViewState>(
      builder: (context, state) {
        switch (state.status) {
          case ScheduleViewStatus.INITIAL:
            return DynamicErrorPage(
              toSearch: true,
              errorType: RuntimeErrorType.noCachedSchedule(),
              description: S.popUps.scheduleHelpFirstLine(),
            );
          case ScheduleViewStatus.LOADING:
            return const TumbleLoading();
          case ScheduleViewStatus.POPULATED_VIEW:
            return SizedBox(
                child: PageView.builder(
                    itemCount: state.listOfWeeks!.length,
                    itemBuilder: (context, index) {
                      int currentYear = 0;
                      return state.listOfWeeks!.map(
                        (week) {
                          if (week.days.first.isoString.year != currentYear) {
                            currentYear = week.days.first.isoString.year;
                            return Stack(
                              children: [
                                TumbleWeekPageContainer(week: week),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(currentYear.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onBackground,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ),
                              ],
                            );
                          }

                          return TumbleWeekPageContainer(week: week);
                        },
                      ).toList()[index];
                    }));
          case ScheduleViewStatus.FETCH_ERROR:
            return DynamicErrorPage(
                toSearch: false, errorType: state.message!, description: S.popUps.scheduleFetchError());
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
