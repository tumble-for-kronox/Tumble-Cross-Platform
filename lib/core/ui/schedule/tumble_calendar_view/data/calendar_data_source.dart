import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';

Future<EventsDataSource> getCalendarDataSource(List<Day> days, Function getColorForCourse) async {
  List<Event> appointments = <Event>[];
  for (Day day in days) {
    for (Event event in day.events) {
      appointments.add(event);
    }
  }
  return EventsDataSource(appointments, getColorForCourse);
}

class EventsDataSource extends CalendarDataSource {
  Function getColorForCourse;

  EventsDataSource(List<Event> source, this.getColorForCourse) {
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
    return appointments![index].isSpecial ? Colors.redAccent : getColorForCourse(appointments![index]);
  }
}
