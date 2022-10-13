// ignore_for_file: constant_identifier_names

part of 'app_switch_cubit.dart';

enum AppSwitchStatus { INITIAL, INITIALIZED, UNINITIALIZED }

class AppSwitchState extends Equatable {
  final AppSwitchStatus status;

  const AppSwitchState({required this.status});

  AppSwitchState copyWith({AppSwitchStatus? status}) => AppSwitchState(status: status ?? this.status);

  @override
  List<Object?> get props => [status];
}
