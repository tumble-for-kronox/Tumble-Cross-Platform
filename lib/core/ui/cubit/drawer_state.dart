import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/shared_preferences/shared_preference_service.dart';
import 'package:tumble/core/api/database/data/access_stores.dart';
import 'package:tumble/core/api/database/repository/database_service.dart';
import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/theme/data/theme_strings.dart';
import 'package:tumble/core/theme/repository/theme_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tumble/core/ui/app_switch/data/locale_names.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

import '../../api/notifications/repository/notification_repository.dart';

part 'drawer_cubit.dart';

class DrawerState extends Equatable {
  final String? school;
  final String? theme;
  final Map<String, bool>? mapOfIdToggles;
  final List<BookmarkedScheduleModel>? bookmarks;
  final int? notificationTime;
  final Locale locale;
  const DrawerState({
    required this.school,
    required this.theme,
    required this.bookmarks,
    required this.notificationTime,
    required this.mapOfIdToggles,
    required this.locale,
  });

  DrawerState copyWith({
    String? school,
    String? theme,
    List<BookmarkedScheduleModel>? bookmarks,
    int? notificationTime,
    Map<String, bool>? mapOfIdToggles,
    Locale? locale,
  }) =>
      DrawerState(
        school: school ?? this.school,
        theme: theme ?? this.theme,
        bookmarks: bookmarks ?? this.bookmarks,
        notificationTime: notificationTime ?? this.notificationTime,
        mapOfIdToggles: mapOfIdToggles ?? this.mapOfIdToggles,
        locale: locale ?? this.locale,
      );

  @override
  List<Object?> get props => [school, theme, bookmarks, notificationTime, mapOfIdToggles, locale];
}
