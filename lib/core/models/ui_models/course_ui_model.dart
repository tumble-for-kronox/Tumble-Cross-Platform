// To parse this JSON data, do
//
//     final courseModel = courseModelToJson(jsonString);
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'course_ui_model.freezed.dart';
part 'course_ui_model.g.dart';

CourseUiModel courseUiModelFromJson(String str) => CourseUiModel.fromJson(json.decode(str));

Map<String, dynamic> courseUiModelToJson(CourseUiModel data) => data.toJson();

@freezed
abstract class CourseUiModel with _$CourseUiModel {
  const factory CourseUiModel({
    required String scheduleId,
    required String courseId,
    required int color,
  }) = _CourseUiModel;

  factory CourseUiModel.fromJson(Map<String, dynamic> json) => _$CourseUiModelFromJson(json);
}
