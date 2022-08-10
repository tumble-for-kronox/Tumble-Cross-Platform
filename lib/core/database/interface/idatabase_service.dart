import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/interface/iservice_manager.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';

@immutable
abstract class IDatabaseScheduleService implements IServiceManager {
  Future<List<String>> getAllScheduleIds();

  Future<ScheduleModel?> getOneSchedule(String id);

  Future setUserSession(KronoxUserModel kronoxUser);

  Future removeUserSession();

  Future<KronoxUserModel?> getUserSession();

  Future addCourseInstance(CourseUiModel courseUiModel);

  Future<Color> getCourseColor(String id);

  Future<List<String>> getAllCachedCourses();

  Future<List<CourseUiModel>> getCachedCoursesFromId(String scheduleId);

  Future removeAllCachedCourseColors();
}
