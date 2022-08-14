import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tumble/core/api/apiservices/runtime_error_type.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/schedule/no_schedule.dart';
import 'package:tumble/core/ui/schedule/tumble_calendar_view/data/calendar_data_source.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/cupertino_alerts.dart';

import '../../../models/api_models/schedule_model.dart';
import '../../scaffold_message.dart';
import '../event_modal.dart';
import '../tumble_list_view/tumble_list_view_day_container.dart';

class TumbleCalendarView extends StatefulWidget {
  const TumbleCalendarView({Key? key}) : super(key: key);

  @override
  State<TumbleCalendarView> createState() => _TumbleCalendarViewState();
}

class _TumbleCalendarViewState extends State<TumbleCalendarView> {
  @override
  Widget build(BuildContext context) {
    final AppNavigator navigator = BlocProvider.of<AppNavigator>(context);
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        switch (state.status) {
          case MainAppStatus.INITIAL:
            return NoScheduleAvailable(
              errorType: RuntimeErrorType.noCachedSchedule,
              cupertinoAlertDialog: CustomCupertinoAlerts.noBookMarkedSchedules(
                  context, () => context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.SEARCH), navigator),
            );
          case MainAppStatus.LOADING:
            return SpinKitThreeBounce(color: Theme.of(context).colorScheme.primary);

          case MainAppStatus.SCHEDULE_SELECTED:
            return FutureBuilder(
                future: getCalendarDataSource(state.listOfDays!, BlocProvider.of<MainAppCubit>(context)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SfCalendar(
                      view: CalendarView.month,
                      dataSource: snapshot.data as EventsDataSource,
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
                          showAgenda: true,
                          navigationDirection: MonthNavigationDirection.vertical,
                          agendaViewHeight: 200,
                          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                          monthCellStyle: MonthCellStyle(
                            backgroundColor: Theme.of(context).colorScheme.background,
                            trailingDatesBackgroundColor: Theme.of(context).colorScheme.background,
                            leadingDatesBackgroundColor: Theme.of(context).colorScheme.background,
                            textStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onBackground),
                          )),
                      onLongPress: (calendarLongPressDetails) {
                        if (calendarLongPressDetails.targetElement != CalendarElement.appointment) {
                          return;
                        }
                        Event event = calendarLongPressDetails.appointments![0];
                        if (BlocProvider.of<MainAppCubit>(context).isDefault(event.id)) {
                          showConfirmationModal(context, event, BlocProvider.of<MainAppCubit>(context));
                        } else {
                          showScaffoldMessage(context, 'Schedule must be default to be able to set notifications');
                        }
                      },
                      onTap: (calendarTapDetails) {
                        if (calendarTapDetails.targetElement != CalendarElement.appointment) {
                          return;
                        }
                        Event event = calendarTapDetails.appointments![0];
                        Color eventColor = BlocProvider.of<MainAppCubit>(context).getColorForCourse(event);
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) =>
                                TumbleEventModal(event: event, color: event.isSpecial ? Colors.redAccent : eventColor));
                      },
                    );
                  }
                  return const SpinKitThreeBounce(
                    color: CustomColors.orangePrimary,
                  );
                });
          case MainAppStatus.FETCH_ERROR:
            return NoScheduleAvailable(
              errorType: state.message!,
              cupertinoAlertDialog: CustomCupertinoAlerts.fetchError(
                  context, () => context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.SEARCH), navigator),
            );
          case MainAppStatus.EMPTY_SCHEDULE:
            return NoScheduleAvailable(
              errorType: RuntimeErrorType.emptyScheduleError,
              cupertinoAlertDialog: CustomCupertinoAlerts.scheduleContainsNoViews(
                  context, () => context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.SEARCH), navigator),
            );
        }
      },
    );
  }
}
