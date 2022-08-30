import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/database/database_response.dart';

@immutable
abstract class ICacheAndInteractionService {
  Future<dynamic> programSearchDispatcher(String searchQuery);

  Future<ApiResponse> scheduleFetchDispatcher(String scheduleId);

  Future<ApiResponse> getCachedOrNewSchedule(String scheduleId);

  Future<DatabaseResponse> verifyDefaultSchoolSet();
}
