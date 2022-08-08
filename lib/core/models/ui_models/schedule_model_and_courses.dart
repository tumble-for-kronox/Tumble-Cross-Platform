import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';

class ScheduleModelAndCourses {
  final ScheduleModel scheduleModel;
  final List<CourseUiModel?> courses;

  ScheduleModelAndCourses({required this.scheduleModel, required this.courses});
}
