import 'package:tumble/core/models/api_models/schedule_model.dart';

abstract class INotificationService {
  void updateDispatcher(
      ScheduleModel newScheduleModel, ScheduleModel oldScheduleModel);

  void assignWithNewDuration(
      Duration newDuration, ScheduleModel currentScheduleModel);
}
