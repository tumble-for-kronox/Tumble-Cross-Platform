// To parse this JSON data, do
//
//     final upcomingUserEventModel = upcomingUserEventModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'upcoming_user_event_model.freezed.dart';
part 'upcoming_user_event_model.g.dart';

UpcomingUserEventModel upcomingUserEventModelFromJson(String str) => UpcomingUserEventModel.fromJson(json.decode(str));

String upcomingUserEventModelToJson(UpcomingUserEventModel data) => json.encode(data.toJson());

@freezed
abstract class UpcomingUserEventModel with _$UpcomingUserEventModel {
  const factory UpcomingUserEventModel({
    required String title,
    required String type,
    required DateTime eventStart,
    required DateTime eventEnd,
    required DateTime firstSignupDate,
  }) = _UpcomingUserEventModel;

  factory UpcomingUserEventModel.fromJson(Map<String, dynamic> json) => _$UpcomingUserEventModelFromJson(json);
}
