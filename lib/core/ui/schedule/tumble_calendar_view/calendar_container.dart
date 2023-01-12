import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/cubit/schedule_view_cubit.dart';
import 'package:tumble/core/ui/schedule/event_modal.dart';
import 'package:tumble/core/ui/schedule/event_options.dart';
import 'package:tumble/core/ui/schedule/tumble_calendar_view/data/calendar_data_source.dart';

class CalendarContainer extends StatefulWidget {
  const CalendarContainer({super.key, required this.events});

  final EventsDataSource events;

  @override
  State<StatefulWidget> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  @override
  Widget build(BuildContext context) => SfCalendar(
        firstDayOfWeek: 1,
        view: CalendarView.month,
        dataSource: widget.events,
        appointmentBuilder: (context, details) {
          final Event event = details.appointments.first;
          return ClipPath(
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.5),
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
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ]),
                      padding: const EdgeInsets.only(
                          left: 18, top: 8, right: 8, bottom: 8),
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
                        color: event.isSpecial
                            ? Colors.redAccent
                            : Color(context
                                .read<ScheduleViewCubit>()
                                .state
                                .courseColors![event.course.id]!),
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
              trailingDatesBackgroundColor:
                  Theme.of(context).colorScheme.background,
              leadingDatesBackgroundColor:
                  Theme.of(context).colorScheme.background,
              textStyle: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onBackground),
            )),
        onLongPress: (calendarLongPressDetails) {
          if (calendarLongPressDetails.targetElement !=
              CalendarElement.appointment) {
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
            Color(context
                .read<ScheduleViewCubit>()
                .state
                .courseColors![event.course.id]!),
          );
        },
      );
}
