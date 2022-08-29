import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

part 'support_modal_cubit.dart';

class SupportModalState extends Equatable {
  final bool? isSubjectValid;
  final bool? isBodyValid;
  final bool? formSubmittedSuccessfully;

  const SupportModalState({
    required this.isSubjectValid,
    required this.isBodyValid,
    required this.formSubmittedSuccessfully,
  });

  SupportModalState copyWith(
          {bool? isSubjectValid,
          bool? isBodyValid,
          bool? formSubmittedSuccessfully}) =>
      SupportModalState(
          isBodyValid: isBodyValid ?? this.isBodyValid,
          isSubjectValid: isSubjectValid ?? this.isSubjectValid,
          formSubmittedSuccessfully:
              formSubmittedSuccessfully ?? this.formSubmittedSuccessfully);
  @override
  List<Object?> get props => [
        isBodyValid,
        isSubjectValid,
        formSubmittedSuccessfully,
      ];
}
