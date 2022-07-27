import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/theme/data/colors.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/event_details/event_details_page.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/no_schedule.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_calendar_view/data/calendar_data_source.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_list_view/data/cupertino_alerts.dart';
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
          if (state.listOfDays.any((element) => element.events.isNotEmpty)) {
            return SfCalendar(
                view: CalendarView.month,
                dataSource:
                    ScheduleDataSource(_getDataSource(state.listOfDays)),
                // by default the month appointment display mode set as Indicator, we can
                // change the display mode as appointment using the appointment display
                // mode property
                headerStyle: CalendarHeaderStyle(
                    textAlign: TextAlign.center,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 5,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w500)),
                monthViewSettings: MonthViewSettings(
                    navigationDirection: MonthNavigationDirection.vertical,
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                    monthCellStyle: MonthCellStyle(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      trailingDatesBackgroundColor:
                          Theme.of(context).colorScheme.background,
                      leadingDatesBackgroundColor:
                          Theme.of(context).colorScheme.background,
                      textStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          color: Theme.of(context).colorScheme.onBackground),
                    )));
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

List<Event> _getDataSource(List<Day> days) {
  final List<Event> events = <Event>[];
  for (Day day in days) {
    for (Event event in day.events) {
      events.add(Event(
          id: event.id,
          title: event.title,
          course: event.course,
          timeStart: event.timeStart,
          timeEnd: event.timeEnd,
          locations: event.locations,
          teachers: event.teachers,
          isSpecial: event.isSpecial,
          lastModified: event.lastModified));
    }
  }
  return events;
}
