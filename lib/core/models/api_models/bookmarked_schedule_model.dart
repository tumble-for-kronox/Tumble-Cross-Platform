import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'bookmarked_schedule_model.freezed.dart';
part 'bookmarked_schedule_model.g.dart';

BookmarkedScheduleModel bookmarkedScheduleModelFromJson(String str) =>
    BookmarkedScheduleModel.fromJson(json.decode(str));

Map<String, dynamic> bookmarkedScheduleModelToJson(
        BookmarkedScheduleModel data) =>
    data.toJson();

@freezed
abstract class BookmarkedScheduleModel with _$BookmarkedScheduleModel {
  const factory BookmarkedScheduleModel({
    required String scheduleId,
    required bool toggledValue,
  }) = _BookmarkedScheduleModel;

  factory BookmarkedScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkedScheduleModelFromJson(json);
}
