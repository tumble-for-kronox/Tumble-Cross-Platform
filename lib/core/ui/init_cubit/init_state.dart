part of 'init_cubit.dart';

// ignore: constant_identifier_names
enum InitStatus { NO_SCHOOL, SCHOOL_AVAILABLE }

class InitState extends Equatable {
  final InitStatus status;
  final String? defaultSchool;
  const InitState({
    required this.defaultSchool,
    required this.status,
  });

  InitState copyWith(
          {InitStatus? status, String? defaultSchool, bool? loginRequired}) =>
      InitState(
        defaultSchool: defaultSchool ?? this.defaultSchool,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [defaultSchool, status];
}
