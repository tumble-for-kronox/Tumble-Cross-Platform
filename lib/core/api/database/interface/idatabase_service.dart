import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/backend/interface/iservice.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';

@immutable
abstract class IDatabaseService implements IService {
  Future<List<String>> getAllScheduleIds();

  Future<ScheduleModel?> getOneSchedule(String id);

  Future setUserSession(KronoxUserModel kronoxUser);

  Future removeUserSession();

  Future<KronoxUserModel?> getUserSession();

  Future<Color?> getCourseColor(String courseId);

  Future<Map<String, int>> getCourseColors();

  Future<Map<String, int>> updateCourseColor(String courseId, int color);

  Future<void> removeCourseColors(List<String> courseIds);
}
