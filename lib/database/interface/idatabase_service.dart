import 'package:tumble/models/api_models/schedule_model.dart';

abstract class IDatabaseScheduleService {
  Future addSchedule(ScheduleModel scheduleModel);

  Future updateSchedule(ScheduleModel scheduleModel);

  Future removeSchedule(String id);

  Future<List<ScheduleModel>> getAllSchedules();

  Future<List<String>> getAllScheduleIds();

  Future<ScheduleModel?> getOneSchedule(String id);

  Future removeAllSchedules();
}
