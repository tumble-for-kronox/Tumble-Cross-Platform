import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/app_switch/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/schedule/tumble_calendar_view/data/calendar_data_source.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/custom_alerts.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

import '../../../models/backend_models/schedule_model.dart';
import '../event_modal.dart';
import '../event_options.dart';

class TumbleCalendarView extends StatefulWidget {
  const TumbleCalendarView({Key? key}) : super(key: key);

  @override
  State<TumbleCalendarView> createState() => _TumbleCalendarViewState();
}

class _TumbleCalendarViewState extends State<TumbleCalendarView> {
  @override
  Widget build(BuildContext context) {
    final AppNavigator navigator = BlocProvider.of<AppNavigator>(context);
    return BlocBuilder<AppSwitchCubit, AppSwitchState>(
      builder: (context, state) {
        switch (state.status) {
          case AppScheduleViewStatus.INITIAL:
            return DynamicErrorPage(
              toSearch: true,
              errorType: RuntimeErrorType.noCachedSchedule(),
              description: S.popUps.scheduleHelpFirstLine(),
            );
          case AppScheduleViewStatus.LOADING:
            return const TumbleLoading();

          case AppScheduleViewStatus.POPULATED_VIEW:
            return FutureBuilder(
                future: getCalendarDataSource(state.listOfDays!, BlocProvider.of<AppSwitchCubit>(context)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SfCalendar(
                      view: CalendarView.month,
                      dataSource: snapshot.data as EventsDataSource,
                      appointmentBuilder: (context, details) {
                        final Event event = details.appointments.first;
                        final Color eventColor = BlocProvider.of<AppSwitchCubit>(context).getColorForCourse(event);
                        return ClipPath(
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            child: Shimmer(
                              color: Colors.redAccent,
                              colorOpacity: 0.2,
                              enabled: event.isSpecial,
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surface,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        boxShadow: const [
                                          BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))
                                        ]),
                                    padding: const EdgeInsets.only(left: 18, top: 8, right: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.title.capitalize(),
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.from)} - ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.to)}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: event.isSpecial ? Colors.redAccent : eventColor,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ));
                      },
                      headerDateFormat: "MMMM yyyy",
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
                        EventOptions.showEventOptions(context, event);
                      },
                      onTap: (calendarTapDetails) {
                        if (calendarTapDetails.targetElement != CalendarElement.appointment) {
                          return;
                        }
                        Event event = calendarTapDetails.appointments![0];
                        TumbleEventModal.showBookmarkEventModal(
                          context,
                          event,
                          BlocProvider.of<AppSwitchCubit>(context).getColorForCourse(event),
                        );
                      },
                    );
                  }
                  return const TumbleLoading();
                });
          case AppScheduleViewStatus.FETCH_ERROR:
            return DynamicErrorPage(
              toSearch: false,
              errorType: state.message!,
              description: S.popUps.scheduleFetchError(),
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
