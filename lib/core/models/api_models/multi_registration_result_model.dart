// To parse this JSON data, do
//
//     final multiRegistrationResultModel = multiRegistrationResultModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'package:tumble/core/models/api_models/available_user_event_model.dart';

part 'multi_registration_result_model.freezed.dart';
part 'multi_registration_result_model.g.dart';

MultiRegistrationResultModel multiRegistrationResultModelFromJson(String str) =>
    MultiRegistrationResultModel.fromJson(json.decode(str));

String multiRegistrationResultModelToJson(MultiRegistrationResultModel data) => json.encode(data.toJson());

@freezed
abstract class MultiRegistrationResultModel with _$MultiRegistrationResultModel {
  const factory MultiRegistrationResultModel({
    required List<AvailableUserEventModel> successfulRegistrations,
    required List<AvailableUserEventModel> failedRegistrations,
  }) = _MultiRegistrationResultModel;

  factory MultiRegistrationResultModel.fromJson(Map<String, dynamic> json) =>
      _$MultiRegistrationResultModelFromJson(json);
}
