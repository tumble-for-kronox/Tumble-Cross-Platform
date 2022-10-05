// ignore_for_file: constant_identifier_names


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/apiservices/api_bug_report_response.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

part 'support_modal_cubit.dart';

class SupportModalState extends Equatable {
  final bool? isSubjectValid;
  final bool? isBodyValid;
  final SupportModalStatus? status;

  const SupportModalState(
      {required this.isSubjectValid,
      required this.isBodyValid,
      required this.status});

  SupportModalState copyWith(
          {bool? isSubjectValid,
          bool? isBodyValid,
          SupportModalStatus? status}) =>
      SupportModalState(
          isSubjectValid: isSubjectValid ?? this.isSubjectValid,
          isBodyValid: isBodyValid ?? this.isBodyValid,
          status: status ?? this.status);
  @override
  List<Object?> get props => [isBodyValid, isSubjectValid, status];
}

enum SupportModalStatus {
  INITIAL,
  LOADING,
  SENT,
  ERROR,
}
