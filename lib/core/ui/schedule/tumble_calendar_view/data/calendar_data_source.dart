import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class ScheduleDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  ScheduleDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getEventData(index).startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return _getEventData(index).endTime;
  }

  @override
  String getSubject(int index) {
    return _getEventData(index).subject;
  }

  @override
  Color getColor(int index) {
    return _getEventData(index).color;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  Appointment _getEventData(int index) {
    final dynamic meeting = appointments![index];
    late final Appointment eventData;
    if (meeting is Appointment) {
      eventData = meeting;
    }

    return eventData;
  }
}
