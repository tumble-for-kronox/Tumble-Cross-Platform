// To parse this JSON data, do
//
//     final errorMessageModel = errorMessageModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'error_message_model.freezed.dart';
part 'error_message_model.g.dart';

ErrorMessageModel errorMessageModelFromJson(String str) =>
    ErrorMessageModel.fromJson(json.decode(str));

String errorMessageModelToJson(ErrorMessageModel data) =>
    json.encode(data.toJson());

@freezed
abstract class ErrorMessageModel with _$ErrorMessageModel {
  const factory ErrorMessageModel({
    required String message,
  }) = _ErrorMessageModel;

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageModelFromJson(json);
}
