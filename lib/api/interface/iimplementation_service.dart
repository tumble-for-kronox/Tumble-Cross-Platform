import 'package:flutter/cupertino.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/database/database.dart';
import 'package:tumble/database/database_response.dart';
import 'package:tumble/models/api_models/schedule_model.dart';

@immutable
abstract class IImplementationService {
  Future<dynamic> getProgramsRequest(String searchQuery);

  Future<ApiResponse> getSchedulesRequest(scheduleId);

  Future<dynamic> getSchedule(String scheduleId);

  Future<DatabaseResponse> initSetup();
}
