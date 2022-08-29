import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/database/data/access_stores.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/api_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/shared/view_types.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/theme/repository/theme_repository.dart';

import '../../../../../api/repository/notification_repository.dart';

part 'drawer_cubit.dart';

class DrawerState extends Equatable {
  final String? viewType;
  final String? school;
  final String? theme;
  final Map<String, bool>? mapOfIdToggles;
  final List<BookmarkedScheduleModel>? bookmarks;
  final int? notificationTime;
  const DrawerState(
      {required this.viewType,
      required this.school,
      required this.theme,
      required this.bookmarks,
      required this.notificationTime,
      required this.mapOfIdToggles});

  DrawerState copyWith(
          {String? viewType,
          String? school,
          String? theme,
          List<BookmarkedScheduleModel>? bookmarks,
          int? notificationTime,
          Map<String, bool>? mapOfIdToggles}) =>
      DrawerState(
          viewType: viewType ?? this.viewType,
          school: school ?? this.school,
          theme: theme ?? this.theme,
          bookmarks: bookmarks ?? this.bookmarks,
          notificationTime: notificationTime ?? this.notificationTime,
          mapOfIdToggles: mapOfIdToggles ?? this.mapOfIdToggles);

  @override
  List<Object?> get props => [
        viewType,
        school,
        theme,
        bookmarks,
        notificationTime,
        mapOfIdToggles,
      ];
}
