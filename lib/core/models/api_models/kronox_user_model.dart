// To parse this JSON data, do
//
//     final kronoxUser = kronoxUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'kronox_user_model.freezed.dart';
part 'kronox_user_model.g.dart';

KronoxUserModel kronoxUserModelFromJson(String str) => KronoxUserModel.fromJson(json.decode(str));

Map<String, dynamic> kronoxUserModelToJson(KronoxUserModel data) => data.toJson();

@freezed
abstract class KronoxUserModel with _$KronoxUserModel {
  const factory KronoxUserModel({
    required String name,
    required String username,
    required String sessionToken,
  }) = _KronoxUserModel;

  factory KronoxUserModel.fromJson(Map<String, dynamic> json) => _$KronoxUserModelFromJson(json);
}
