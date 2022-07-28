// To parse this JSON data, do
//
//     final userEventCollectionModel = userEventCollectionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tumble/models/api_models/available_user_event_model.dart';
import 'dart:convert';

import 'package:tumble/models/api_models/upcoming_user_event_model.dart';

part 'user_event_collection_model.freezed.dart';
part 'user_event_collection_model.g.dart';

UserEventCollectionModel userEventCollectionModelFromJson(String str) =>
    UserEventCollectionModel.fromJson(json.decode(str));

String userEventCollectionModelToJson(UserEventCollectionModel data) => json.encode(data.toJson());

@freezed
abstract class UserEventCollectionModel with _$UserEventCollectionModel {
  const factory UserEventCollectionModel({
    required List<UpcomingUserEventModel> upcomingEvents,
    required List<AvailableUserEventModel> registeredEvents,
    required List<AvailableUserEventModel> availableEvents,
  }) = _UserEventCollectionModel;

  factory UserEventCollectionModel.fromJson(Map<String, dynamic> json) => _$UserEventCollectionModelFromJson(json);
}
