// To parse this JSON data, do
//
//     final availableUserEventModel = availableUserEventModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'available_user_event_model.freezed.dart';
part 'available_user_event_model.g.dart';

AvailableUserEventModel availableUserEventModelFromJson(String str) =>
    AvailableUserEventModel.fromJson(json.decode(str));

String availableUserEventModelToJson(AvailableUserEventModel data) => json.encode(data.toJson());

@freezed
abstract class AvailableUserEventModel with _$AvailableUserEventModel {
  const factory AvailableUserEventModel({
    required String id,
    required String title,
    required String type,
    required DateTime eventStart,
    required DateTime eventEnd,
    required DateTime lastSignupDate,
    required String? participatorId,
    required String? supportId,
    required String anonymousCode,
    required bool isRegistered,
    required bool supportAvailable,
    required bool requiresChoosingLocation,
  }) = _AvailableUserEventModel;

  factory AvailableUserEventModel.fromJson(Map<String, dynamic> json) => _$AvailableUserEventModelFromJson(json);
}
