import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_schedule_or_programme_response.dart';
import 'package:tumble/core/api/data/time_constants.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/api/repository/notification_repository.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/api_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

class BackgroundTask {
  ///
  /// Background update attempted on boot sequence.
  /// Function updates only the visible schedules and will only update schedules
  /// if they have not been updated in the last 30 minutes.
  ///
  static Future<void> callbackDispatcher() async {
    final backendService = getIt<BackendRepository>();
    final preferenceService = getIt<SharedPreferences>();
    final databaseService = getIt<DatabaseRepository>();
    final notificationService = getIt<NotificationRepository>();

    final bookmarkedSchedulesToggledToBeVisible = preferenceService
        .getStringList(PreferenceTypes.bookmarks)!
        .map((json) => bookmarkedScheduleModelFromJson(json))
        .where((bookmark) => bookmark.toggledValue == true);

    final defaultUserSchool = preferenceService.getString(PreferenceTypes.school);

    if (bookmarkedSchedulesToggledToBeVisible.isEmpty || defaultUserSchool == null) {
      return;
    }

    log(name: 'background_task', 'Executing background updater ..');
    List<ScheduleModel?> cachedScheduleModels = await Future.wait(bookmarkedSchedulesToggledToBeVisible
        .map((bookmarkedScheduleModel) async =>
            (await databaseService.getOneSchedule(bookmarkedScheduleModel.scheduleId)))
        .toList());

    for (ScheduleModel? cachedScheduleModel in cachedScheduleModels) {
      if (cachedScheduleModel != null) {
        if (cachedScheduleModel.cachedAt.isAfter(DateTime.now().subtract(TimeConstants.updateOffset))) {
          return;
        }

        ApiScheduleOrProgrammeResponse apiResponseOfNewScheduleModel =
            await backendService.getRequestSchedule(cachedScheduleModel.id, defaultUserSchool);

        switch (apiResponseOfNewScheduleModel.status) {
          case ApiScheduleOrProgrammeStatus.FETCHED:
            ScheduleModel newScheduleModel = apiResponseOfNewScheduleModel.data!;

            if (newScheduleModel != cachedScheduleModel) {
              databaseService.update(newScheduleModel);

              notificationService.updateDispatcher(newScheduleModel, cachedScheduleModel);
            }
            break;

          /// Connection is not available or backend is down. No point
          /// in attempting to update any other schedules if this goes wrong.
          case ApiScheduleOrProgrammeStatus.ERROR:
            log(name: 'background_task', 'Failed to update schedules. Connection not available. Exiting ..');
            return;
          default:
            break;
        }
      }
    }
  }
}
