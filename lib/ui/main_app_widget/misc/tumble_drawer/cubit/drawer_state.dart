import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/shared/view_types.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/theme/repository/theme_repository.dart';
import 'package:tumble/ui/drawer_generic/app_default_schedule_picker.dart';
import 'package:tumble/ui/drawer_generic/app_default_view_picker.dart';
import 'package:tumble/ui/drawer_generic/app_notification_time_picker.dart';
import 'package:tumble/ui/drawer_generic/app_theme_picker.dart';
import 'package:tumble/ui/main_app_widget/data/event_types.dart';
import 'package:tumble/ui/main_app_widget/school_selection_page.dart';

part 'drawer_cubit.dart';

class DrawerState extends Equatable {
  final String? viewType;
  final String? school;
  final String? theme;
  final String? schedule;
  const DrawerState(
      {required this.viewType,
      required this.schedule,
      required this.school,
      required this.theme});

  DrawerState copyWith(
          {String? viewType,
          String? school,
          String? theme,
          String? schedule}) =>
      DrawerState(
          viewType: viewType ?? this.viewType,
          school: school ?? this.school,
          theme: theme ?? this.theme,
          schedule: schedule ?? this.schedule);

  @override
  List<Object?> get props => [viewType, schedule, school, theme];
}
