import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/shared/view_types.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/theme/repository/theme_repository.dart';

part 'drawer_cubit.dart';

class DrawerState extends Equatable {
  final String? viewType;
  final String? school;
  final String? theme;
  final String? schedule;
  final List<String>? bookmarks;
  const DrawerState(
      {required this.viewType,
      required this.schedule,
      required this.school,
      required this.theme,
      required this.bookmarks});

  DrawerState copyWith(
          {String? viewType,
          String? school,
          String? theme,
          String? schedule,
          List<String>? bookmarks}) =>
      DrawerState(
          viewType: viewType ?? this.viewType,
          school: school ?? this.school,
          theme: theme ?? this.theme,
          schedule: schedule ?? this.schedule,
          bookmarks: bookmarks ?? this.bookmarks);

  @override
  List<Object?> get props => [viewType, schedule, school, theme, bookmarks];
}
