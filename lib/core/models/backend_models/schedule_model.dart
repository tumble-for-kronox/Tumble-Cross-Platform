// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);
import 'dart:ui';

import 'package:html_unescape/html_unescape.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'package:tumble/core/theme/color_picker.dart';

part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

ScheduleModel scheduleModelFromJson(String str) =>
    ScheduleModel.fromJson(json.decode(str));

Map<String, dynamic> scheduleModelToJson(ScheduleModel data) => data.toJson();

@freezed
class ScheduleModel with _$ScheduleModel {
  const factory ScheduleModel({
    required DateTime cachedAt,
    required String id,
    required List<Day> days,
  }) = _ScheduleModel;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}

@freezed
class Day with _$Day {
  const factory Day({
    required String name,
    required String date,
    required DateTime isoString,
    required int weekNumber,
    required List<Event> events,
  }) = _Day;

  factory Day.fromJson(Map<String, dynamic> json) => _$_Day(
        name: json['name'] as String,
        date: json['date'] as String,
        isoString: DateTime.parse(json['isoString'] as String).toLocal(),
        weekNumber: json['weekNumber'] as int,
        events: (json['events'] as List<dynamic>)
            .map((e) => Event.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required Course course,
    required DateTime from,
    required DateTime to,
    required List<Location> locations,
    required List<Teacher> teachers,
    required bool isSpecial,
    required DateTime lastModified,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$_Event(
        id: json['id'] as String,
        title: HtmlUnescape().convert(json['title']),
        course: Course.fromJson(json['course'] as Map<String, dynamic>),
        from: DateTime.parse(json['from'] as String).toLocal(),
        to: DateTime.parse(json['to'] as String).toLocal(),
        locations: (json['locations'] as List<dynamic>)
            .map((e) => Location.fromJson(e as Map<String, dynamic>))
            .toList(),
        teachers: (json['teachers'] as List<dynamic>)
            .map((e) => Teacher.fromJson(e as Map<String, dynamic>))
            .toList(),
        isSpecial: json['isSpecial'] as bool,
        lastModified: DateTime.parse(json['lastModified'] as String),
      );
}

@freezed
class Course with _$Course {
  factory Course({
    required String id,
    required String swedishName,
    required String englishName,
    int? courseColor,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$_Course(
      id: json['id'] as String,
      swedishName: json['swedishName'] as String,
      englishName: json['englishName'] as String,
      courseColor: json['courseColor']);
}

@freezed
class Location with _$Location {
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
class Teacher with _$Teacher {
  const factory Teacher({
    required String id,
    required String firstName,
    required String lastName,
  }) = _Teacher;

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
}
