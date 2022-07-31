import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/models/ui_models/school_model.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/startup/get_it_instances.dart';

part 'root_page_state.dart';

class RootPageCubit extends Cubit<RootPageState> {
  RootPageCubit()
      : super(RootPageState(
            needSchool: locator<SharedPreferences>()
                    .getString(PreferenceTypes.school) ==
                null));

  void setSchool(School school) {
    locator<SharedPreferences>()
        .setString(PreferenceTypes.school, school.schoolName);
    emit(state.copyWith(needSchool: false));
  }

  init() {}
}
