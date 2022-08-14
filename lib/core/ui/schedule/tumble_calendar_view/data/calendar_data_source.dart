import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';

Future<EventsDataSource> getCalendarDataSource(List<Day> days, MainAppCubit cubit) async {
  List<Event> appointments = <Event>[];
  for (Day day in days) {
    for (Event event in day.events) {
      appointments.add(event);
    }
  }
  return EventsDataSource(appointments, cubit);
}

class EventsDataSource extends CalendarDataSource {
  MainAppCubit cubit;

  EventsDataSource(List<Event> source, this.cubit) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  @override
  Color getColor(int index) {
    return appointments![index].isSpecial ? Colors.redAccent : cubit.getColorForCourse(appointments![index]);
  }
}
