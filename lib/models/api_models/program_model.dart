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
    required int count,
    required List<Item> items,
  }) = _ProgramModel;

  factory ProgramModel.fromJson(Map<String, dynamic> json) =>
      _$ProgramModelFromJson(json);
}

@freezed
abstract class Item with _$Item {
  const factory Item({
    required String id,
    required String title,
    required String subtitle,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
