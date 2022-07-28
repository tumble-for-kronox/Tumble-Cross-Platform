part of 'init_cubit.dart';

// ignore: constant_identifier_names
enum InitStatus { INITIAL, NO_SCHOOL, HAS_SCHOOL }

class InitState extends Equatable {
  final InitStatus status;
  final String? defaultSchool;
  const InitState({required this.defaultSchool, required this.status});

  InitState copyWith({InitStatus? status, String? defaultSchool}) => InitState(
      defaultSchool: defaultSchool ?? this.defaultSchool,
      status: status ?? this.status);

  @override
  List<Object?> get props => [defaultSchool];
}
