// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProgramModel _$$_ProgramModelFromJson(Map<String, dynamic> json) =>
    _$_ProgramModel(
      requestedSchedule: (json['requestedSchedule'] as List<dynamic>)
          .map((e) => RequestedSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ProgramModelToJson(_$_ProgramModel instance) =>
    <String, dynamic>{
      'requestedSchedule': instance.requestedSchedule,
    };

_$_RequestedSchedule _$$_RequestedScheduleFromJson(Map<String, dynamic> json) =>
    _$_RequestedSchedule(
      scheduleId: json['scheduleId'] as String,
      scheduleName: json['scheduleName'] as String,
    );

Map<String, dynamic> _$$_RequestedScheduleToJson(
        _$_RequestedSchedule instance) =>
    <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'scheduleName': instance.scheduleName,
    };
