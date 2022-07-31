part of 'root_page_cubit.dart';

class RootPageState extends Equatable {
  final bool needSchool;
  const RootPageState({required this.needSchool});

  RootPageState copyWith({bool? needSchool}) =>
      RootPageState(needSchool: needSchool ?? this.needSchool);

  @override
  List<Object?> get props => [needSchool];
}
