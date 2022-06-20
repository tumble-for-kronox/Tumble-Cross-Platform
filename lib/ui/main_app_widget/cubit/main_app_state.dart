part of 'main_app_cubit.dart';

abstract class MainAppState {
  const MainAppState();
}

class MainAppInitial extends MainAppState {
  const MainAppInitial();
}

class MainAppSchoolSelected extends MainAppState {
  const MainAppSchoolSelected();
}

class MainAppSchoolSelectedAndDefault extends MainAppState {
  final String currentScheduleId;
  const MainAppSchoolSelectedAndDefault({required this.currentScheduleId});
}
