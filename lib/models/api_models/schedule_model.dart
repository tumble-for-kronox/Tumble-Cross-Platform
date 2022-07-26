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

Map<String, dynamic> scheduleModelToJson(ScheduleModel data) => data.toJson();

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
    required DateTime isoString,
    required int weekNumber,
    required List<Event> events,
  }) = _Day;

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
}

@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required Course course,
    required DateTime timeStart,
    required DateTime timeEnd,
    required List<Location> locations,
    required List<Teacher> teachers,
    required bool isSpecial,
    required DateTime lastModified,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
abstract class Course with _$Course {
  const factory Course({
    required String id,
    required String swedishName,
    required String englishName,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}

@freezed
abstract class Location with _$Location {
  const factory Location({
    required String id,
    required String name,
    required String building,
    required String floor,
    required int maxSeats,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
abstract class Teacher with _$Teacher {
  const factory Teacher({
    required String id,
    required String firstName,
    required String lastName,
  }) = _Teacher;

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
}
