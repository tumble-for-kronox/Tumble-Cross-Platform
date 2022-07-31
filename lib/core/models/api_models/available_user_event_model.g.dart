// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_user_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AvailableUserEventModel _$$_AvailableUserEventModelFromJson(
        Map<String, dynamic> json) =>
    _$_AvailableUserEventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      eventStart: DateTime.parse(json['eventStart'] as String),
      eventEnd: DateTime.parse(json['eventEnd'] as String),
      lastSignupDate: DateTime.parse(json['lastSignupDate'] as String),
      participatorId: json['participatorId'] as String,
      supportId: json['supportId'] as String,
      anonymousCode: json['anonymousCode'] as String,
      isRegistered: json['isRegistered'] as bool,
      supportAvailable: json['supportAvailable'] as bool,
      requiresChoosingLocation: json['requiresChoosingLocation'] as bool,
    );

Map<String, dynamic> _$$_AvailableUserEventModelToJson(
        _$_AvailableUserEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'eventStart': instance.eventStart.toIso8601String(),
      'eventEnd': instance.eventEnd.toIso8601String(),
      'lastSignupDate': instance.lastSignupDate.toIso8601String(),
      'participatorId': instance.participatorId,
      'supportId': instance.supportId,
      'anonymousCode': instance.anonymousCode,
      'isRegistered': instance.isRegistered,
      'supportAvailable': instance.supportAvailable,
      'requiresChoosingLocation': instance.requiresChoosingLocation,
    };
