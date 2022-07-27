part of 'init_cubit.dart';

@immutable
class InitState extends Equatable {
  const InitState();
  @override
  List<Object?> get props => [];
}

class InitStateInitial extends InitState {
  const InitStateInitial();
}

class InitStateNoSchool extends InitState {
  const InitStateNoSchool();
}

class InitStateHasSchool extends InitState {
  final String defaultSchool;
  const InitStateHasSchool(this.defaultSchool);

  @override
  List<Object?> get props => [defaultSchool];
}
