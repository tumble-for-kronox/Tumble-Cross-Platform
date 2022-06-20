// To parse this JSON data, do
//
//     final programModel = programModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'program_model.freezed.dart';
part 'program_model.g.dart';

ProgramModel programModelFromJson(String str) =>
    ProgramModel.fromJson(json.decode(str));

String programModelToJson(ProgramModel data) => json.encode(data.toJson());

@freezed
abstract class ProgramModel with _$ProgramModel {
  const factory ProgramModel({
    required List<RequestedSchedule> requestedSchedule,
  }) = _ProgramModel;

  factory ProgramModel.fromJson(Map<String, dynamic> json) =>
      _$ProgramModelFromJson(json);
}

@freezed
abstract class RequestedSchedule with _$RequestedSchedule {
  const factory RequestedSchedule({
    required String scheduleId,
    required String scheduleName,
  }) = _RequestedSchedule;

  factory RequestedSchedule.fromJson(Map<String, dynamic> json) =>
      _$RequestedScheduleFromJson(json);
}
