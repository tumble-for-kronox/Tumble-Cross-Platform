import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/api/repository/notification_repository.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/startup/get_it_instances.dart';

class BackgroundTask {
  static const name = 'updateSchedule';
  static const identifier = 'background-fetch';

  static Future<void> callbackDispatcher() async {
    final backendService = getIt<BackendRepository>();
    final preferenceService = getIt<SharedPreferences>();
    final databaseService = getIt<DatabaseRepository>();
    final notificationService = getIt<NotificationRepository>();

    final defaultUserScheduleId =
        preferenceService.getString(PreferenceTypes.schedule);
    final defaultUserSchool =
        preferenceService.getString(PreferenceTypes.school);

    if (defaultUserScheduleId == null || defaultUserSchool == null) {
      return;
    }

    ApiResponse apiResponseOfNewScheduleModel = await backendService
        .getSchedule(defaultUserScheduleId, defaultUserSchool);
    ScheduleModel? storedScheduleModel =
        await databaseService.getOneSchedule(defaultUserScheduleId);
    switch (apiResponseOfNewScheduleModel.status) {
      case ApiStatus.FETCHED:
        ScheduleModel newScheduleModel = apiResponseOfNewScheduleModel.data!;
        if ((newScheduleModel != storedScheduleModel) &&
            storedScheduleModel != null) {
          databaseService.updateSchedule(newScheduleModel);
          notificationService.updateDispatcher(
              newScheduleModel, storedScheduleModel);
        }
        break;
      default:
        break;
    }
  }
}
