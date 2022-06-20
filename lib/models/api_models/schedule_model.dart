// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

ScheduleModel scheduleModelFromJson(String str) =>
    ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

@freezed
abstract class ScheduleModel with _$ScheduleModel {
  const factory ScheduleModel({
    required String cachedAt,
    required String id,
    required List<Day> days,
  }) = _ScheduleModel;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}

@freezed
abstract class Day with _$Day {
  const factory Day({
    required String name,
    required String date,
    required String year,
    required String month,
    required String dayOfMonth,
    required String dayOfWeek,
    required int weekNumber,
    required List<Event> events,
  }) = _Day;

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
}

@freezed
abstract class Event with _$Event {
  const factory Event({
    required String title,
    required Course course,
    required DateTime timeStart,
    required DateTime timeEnd,
    required String location,
    required String teacher,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
abstract class Course with _$Course {
  const factory Course({
    required String name,
    required String color,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
