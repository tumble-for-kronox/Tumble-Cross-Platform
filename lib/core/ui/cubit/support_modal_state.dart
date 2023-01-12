// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/repository/backend_service.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

part 'support_modal_cubit.dart';

class SupportModalState extends Equatable {
  final bool isSubjectValid;
  final bool isBodyValid;
  final SupportModalStatus? status;
  final bool focused;

  const SupportModalState({
    required this.isSubjectValid,
    required this.isBodyValid,
    required this.status,
    required this.focused,
  });

  SupportModalState copyWith(
          {bool? isSubjectValid,
          bool? isBodyValid,
          SupportModalStatus? status,
          bool? focused}) =>
      SupportModalState(
          isSubjectValid: isSubjectValid ?? this.isSubjectValid,
          isBodyValid: isBodyValid ?? this.isBodyValid,
          status: status ?? this.status,
          focused: focused ?? this.focused);
  @override
  List<Object?> get props => [
        isBodyValid,
        isSubjectValid,
        status,
        focused,
      ];
}

enum SupportModalStatus {
  INITIAL,
  LOADING,
  SENT,
  ERROR,
}
