// To parse this JSON data, do
//
//     final resourceModel = resourceModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'resource_model.freezed.dart';
part 'resource_model.g.dart';

ResourceModel resourceModelFromJson(String str) => ResourceModel.fromJson(json.decode(str));

String resourceModelToJson(ResourceModel data) => json.encode(data.toJson());

@freezed
abstract class ResourceModel with _$ResourceModel {
  const factory ResourceModel({
    required String id,
    required String name,
    List<TimeSlot>? timeSlots,
    DateTime? date,
    List<String>? locationIds,
    Map<String, Map<int, AvailabilityValue>>? availabilities,
  }) = _ResourceModel;

  factory ResourceModel.fromJson(Map<String, dynamic> json) => _$ResourceModelFromJson(json);
}

@freezed
abstract class AvailabilityValue with _$AvailabilityValue {
  const factory AvailabilityValue({
    required AvailabilityEnum availability,
    String? locationId,
    String? resourceType,
    String? timeSlotId,
    String? bookedBy,
  }) = _AvailabilityValue;

  factory AvailabilityValue.fromJson(Map<String, dynamic> json) => _$AvailabilityValueFromJson(json);
}

enum AvailabilityEnum { AVAILABLE, BOOKED, UNAVAILABLE }

final availabilityEnumValues = EnumValues({
  "AVAILABLE": AvailabilityEnum.AVAILABLE,
  "BOOKED": AvailabilityEnum.BOOKED,
  "UNAVAILABLE": AvailabilityEnum.UNAVAILABLE
});

@freezed
abstract class TimeSlot with _$TimeSlot {
  const factory TimeSlot({
    int? id,
    required DateTime from,
    required DateTime to,
    required String duration,
    required DateTime getConfirmationOpens,
    required DateTime getConfirmationCloses,
  }) = _TimeSlot;

  factory TimeSlot.fromJson(Map<String, dynamic> json) => _$TimeSlotFromJson(json);
}

@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    required String id,
    required TimeSlot timeSlot,
    required String locationId,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return reverseMap ??= map.map((k, v) => MapEntry(v, k));
  }
}
