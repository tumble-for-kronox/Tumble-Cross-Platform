import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/theme/colors.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/no_schedule.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_calendar_view/data/calendar_data_source.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_list_view/tumble_list_view_day_container.dart';

class TumbleCalendarView extends StatefulWidget {
  const TumbleCalendarView({Key? key}) : super(key: key);

  @override
  State<TumbleCalendarView> createState() => _TumbleCalendarViewState();
}

class _TumbleCalendarViewState extends State<TumbleCalendarView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        if (state is MainAppScheduleSelected) {
          return SfCalendar(
            view: CalendarView.month,
            dataSource: ScheduleDataSource(_getDataSource(state.listOfDays)),
            // by default the month appointment display mode set as Indicator, we can
            // change the display mode as appointment using the appointment display
            // mode property
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
          );
        }
        if (state is MainAppLoading) {
          return const SpinKitThreeBounce(color: CustomColors.orangePrimary);
        }
        return const NoScheduleAvailable(
            errorType: 'No default schedule selected');
      },
    );
  }
}

List<CalendarEvent> _getDataSource(List<Day> days) {
  final List<CalendarEvent> events = <CalendarEvent>[];
  for (Day day in days) {
    for (Event event in day.events) {
      events.add(CalendarEvent(
          event.title, event.timeStart, event.timeEnd, Colors.black, false));
    }
  }
  return events;
}
