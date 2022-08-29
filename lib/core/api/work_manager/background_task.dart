import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/api/repository/notification_repository.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/api_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

class BackgroundTask {
  static Future<void> callbackDispatcher() async {
    final backendService = getIt<BackendRepository>();
    final preferenceService = getIt<SharedPreferences>();
    final databaseService = getIt<DatabaseRepository>();
    final notificationService = getIt<NotificationRepository>();

    final bookmarkedSchedulesVisible = preferenceService
        .getStringList(PreferenceTypes.bookmarks)!
        .map((json) => bookmarkedScheduleModelFromJson(json))
        .where((bookmark) => bookmark.toggledValue == true);

    final defaultUserSchool =
        preferenceService.getString(PreferenceTypes.school);

    if (bookmarkedSchedulesVisible.isEmpty || defaultUserSchool == null) {
      return;
    }

    List<ScheduleModel?> storedScheduleModels = [];
    for (BookmarkedScheduleModel bookmarkedScheduleModel
        in bookmarkedSchedulesVisible) {
      storedScheduleModels.add(await databaseService
          .getOneSchedule(bookmarkedScheduleModel.scheduleId));
    }

    for (ScheduleModel? storedScheduleModel in storedScheduleModels) {
      if (storedScheduleModel != null) {
        // Don't update cache if the schedule was cached anytime within the past 30 minutes
        if (storedScheduleModel.cachedAt
            .isAfter(DateTime.now().subtract(const Duration(minutes: 30)))) {
          return;
        }

        // Update schedule
        ApiResponse apiResponseOfNewScheduleModel = await backendService
            .getSchedule(storedScheduleModel.id, defaultUserSchool);
        switch (apiResponseOfNewScheduleModel.status) {
          case ApiStatus.FETCHED:
            ScheduleModel newScheduleModel =
                apiResponseOfNewScheduleModel.data!;
            if (newScheduleModel != storedScheduleModel) {
              databaseService.update(newScheduleModel);
              notificationService.updateDispatcher(
                  newScheduleModel, storedScheduleModel);
            }
            break;
          default:
            break;
        }
      }
    }
  }
}
