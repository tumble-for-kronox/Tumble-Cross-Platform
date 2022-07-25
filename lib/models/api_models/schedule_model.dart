// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

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
    required Courses courses,
  }) = _ScheduleModel;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}

@freezed
abstract class Courses with _$Courses {
  const factory Courses({
    required CourseId courseId,
  }) = _Courses;

  factory Courses.fromJson(Map<String, dynamic> json) =>
      _$CoursesFromJson(json);
}

@freezed
abstract class CourseId with _$CourseId {
  const factory CourseId({
    required String id,
    required String swedishName,
    required String englishName,
    required String color,
  }) = _CourseId;

  factory CourseId.fromJson(Map<String, dynamic> json) =>
      _$CourseIdFromJson(json);
}

@freezed
abstract class Day with _$Day {
  const factory Day({
    required String name,
    required String date,
    required int year,
    required int month,
    required int dayOfMonth,
    required int dayOfWeek,
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
    required String courseId,
    required DateTime timeStart,
    required DateTime timeEnd,
    required List<Location> locations,
    required List<Teacher> teachers,
    required bool isSpecial,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
abstract class Location with _$Location {
  const factory Location({
    required String id,
    required String name,
    required String building,
    required String floor,
    required String maxSeats,
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
