import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tumble/models/api_models/schedule_model.dart';

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class ScheduleDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  ScheduleDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getEventData(index).timeStart;
  }

  @override
  DateTime getEndTime(int index) {
    return _getEventData(index).timeEnd;
  }

  @override
  String getSubject(int index) {
    return _getEventData(index).title;
  }

  @override
  Color getColor(int index) {
    return Colors.grey;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  Event _getEventData(int index) {
    final dynamic meeting = appointments![index];
    late final Event eventData;
    if (meeting is Event) {
      eventData = meeting;
    }

    return eventData;
  }
}
