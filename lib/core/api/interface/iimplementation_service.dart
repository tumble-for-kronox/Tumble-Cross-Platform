import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/database/database_response.dart';

@immutable
abstract class IImplementationService {
  Future<dynamic> getProgramsRequest(String searchQuery);

  Future<ApiResponse> getSchedulesRequest(scheduleId);

  Future<ApiResponse> getSchedule(String scheduleId);

  Future<ApiResponse> getCachedBookmarkedSchedule();

  Future<DatabaseResponse> initSetup();
}
