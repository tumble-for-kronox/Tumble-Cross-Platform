import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/user_repository.dart';
import 'package:tumble/core/models/api_models/user_event_collection_model.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

part 'user_event_list_state.dart';

class UserEventListCubit extends Cubit<UserEventListState> {
  UserEventListCubit()
      : super(const UserEventListState(status: UserEventListStatus.LOADING));

  final UserRepository _userRepository = getIt<UserRepository>();

  Future<void> getUserEvents(String sessionToken) async {
    emit(state.copyWith(status: UserEventListStatus.LOADING));
    ApiResponse userEventResponse =
        await _userRepository.getUserEvents(sessionToken);

    switch (userEventResponse.status) {
      case ApiStatus.FETCHED:
        emit(state.copyWith(
            status: UserEventListStatus.LOADED,
            userEvents: userEventResponse.data!,
            refreshSession: false));
        break;
      case ApiStatus.UNAUTHORIZED:
        emit(state.copyWith());
        break;
      default:
        emit(state.copyWith(
            status: UserEventListStatus.ERROR, refreshSession: false));
    }
  }
}
