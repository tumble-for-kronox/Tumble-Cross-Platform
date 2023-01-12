import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';
import 'package:tumble/core/ui/cubit/schedule_view_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/schedule/tumble_calendar_view/calendar_container.dart';
import 'package:tumble/core/ui/schedule/tumble_calendar_view/data/calendar_data_source.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class TumbleCalendarView extends StatefulWidget {
  const TumbleCalendarView({Key? key}) : super(key: key);

  @override
  State<TumbleCalendarView> createState() => _TumbleCalendarViewState();
}

class _TumbleCalendarViewState extends State<TumbleCalendarView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleViewCubit, ScheduleViewState>(
      builder: (context, state) {
        switch (state.status) {
          case ScheduleViewStatus.initial:
            return DynamicErrorPage(
              toSearch: true,
              errorType: RuntimeErrorType.noCachedSchedule(),
              description: S.popUps.scheduleHelpFirstLine(),
            );
          case ScheduleViewStatus.loading:
            return const TumbleLoading();

          case ScheduleViewStatus.populated:
            return FutureBuilder(
                future: getCalendarDataSource(
                    state.listOfDays!, state.courseColors!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return BlocProvider.value(
                        value: BlocProvider.of<ScheduleViewCubit>(context),
                        child: CalendarContainer(
                          events: snapshot.data as EventsDataSource,
                        ));
                  }
                  return const TumbleLoading();
                });
          case ScheduleViewStatus.error:
            return DynamicErrorPage(
              toSearch: false,
              errorType: state.message!,
              description: S.popUps.scheduleFetchError(),
            );
          case ScheduleViewStatus.empty:
            return DynamicErrorPage(
              toSearch: false,
              errorType: RuntimeErrorType.emptyScheduleError(),
              description: S.popUps.scheduleIsEmptyBody(),
            );
          case ScheduleViewStatus.missing:
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
