// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScheduleModel _$$_ScheduleModelFromJson(Map<String, dynamic> json) =>
    _$_ScheduleModel(
      cachedAt: json['cachedAt'] as String,
      id: json['id'] as String,
      days: (json['days'] as List<dynamic>)
          .map((e) => Day.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ScheduleModelToJson(_$_ScheduleModel instance) =>
    <String, dynamic>{
      'cachedAt': instance.cachedAt,
      'id': instance.id,
      'days': instance.days,
    };

_$_Day _$$_DayFromJson(Map<String, dynamic> json) => _$_Day(
      name: json['name'] as String,
      date: json['date'] as String,
      year: json['year'] as String,
      month: json['month'] as String,
      dayOfMonth: json['dayOfMonth'] as String,
      dayOfWeek: json['dayOfWeek'] as String,
      weekNumber: json['weekNumber'] as int,
      events: (json['events'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_DayToJson(_$_Day instance) => <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
      'year': instance.year,
      'month': instance.month,
      'dayOfMonth': instance.dayOfMonth,
      'dayOfWeek': instance.dayOfWeek,
      'weekNumber': instance.weekNumber,
      'events': instance.events,
    };

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      title: json['title'] as String,
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
      timeStart: DateTime.parse(json['timeStart'] as String),
      timeEnd: DateTime.parse(json['timeEnd'] as String),
      location: json['location'] as String,
      teacher: json['teacher'] as String,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'title': instance.title,
      'course': instance.course,
      'timeStart': instance.timeStart.toIso8601String(),
      'timeEnd': instance.timeEnd.toIso8601String(),
      'location': instance.location,
      'teacher': instance.teacher,
    };

_$_Course _$$_CourseFromJson(Map<String, dynamic> json) => _$_Course(
      name: json['name'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$$_CourseToJson(_$_Course instance) => <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
    };
