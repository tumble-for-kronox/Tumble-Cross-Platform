// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_user_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UpcomingUserEventModel _$$_UpcomingUserEventModelFromJson(
        Map<String, dynamic> json) =>
    _$_UpcomingUserEventModel(
      title: json['title'] as String,
      type: json['type'] as String,
      eventStart: DateTime.parse(json['eventStart'] as String),
      eventEnd: DateTime.parse(json['eventEnd'] as String),
      firstSignupDate: DateTime.parse(json['firstSignupDate'] as String),
    );

Map<String, dynamic> _$$_UpcomingUserEventModelToJson(
        _$_UpcomingUserEventModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'eventStart': instance.eventStart.toIso8601String(),
      'eventEnd': instance.eventEnd.toIso8601String(),
      'firstSignupDate': instance.firstSignupDate.toIso8601String(),
    };
