import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/startup/get_it_instances.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundTask {

  static const name = 'updateSchedule';
  static const identifier = 'background-fetch';

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      final backendService = getIt<BackendRepository>();
      final preferenceService = getIt<SharedPreferences>();
      final databaseService = getIt<DatabaseRepository>();

      final defaultUserScheduleId = preferenceService.getString(PreferenceTypes.schedule);
      final defaultUserSchool = preferenceService.getString(PreferenceTypes.school);

      if(defaultUserScheduleId == null || defaultUserSchool == null) {
        Future.value(false);
      }

      ApiResponse apiResponse = await backendService.getSchedule(defaultUserScheduleId!, defaultUserSchool!);
      switch(apiResponse.status){
        case ApiStatus.FETCHED:
          ScheduleModel scheduleModel = apiResponse.data!;
          databaseService.updateSchedule(scheduleModel);
          return Future.value(true);
        case ApiStatus.ERROR:
          return Future.value(false);
        default:
          return Future.value(false);
      }
    });
  }
}
