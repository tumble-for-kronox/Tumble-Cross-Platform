import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../api/apiservices/api_booking_response.dart';
import '../../../../api/repository/user_repository.dart';
import '../../../../dependency_injection/get_it_instances.dart';
import '../../../../models/api_models/resource_model.dart';
import '../../../login/cubit/auth_cubit.dart';

part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  ResourceCubit()
      : super(ResourceState(
          status: ResourceStatus.INITIAL,
          userBookingsStatus: UserBookingsStatus.INITIAL,
          bookUnbookStatus: BookUnbookStatus.INITIAL,
          chosenDate: DateTime.now(),
        ));

  final _userRepo = getIt<UserRepository>();

  Future<void> getSchoolResources(AuthCubit authCubit) async {
    emit(state.copyWith(status: ResourceStatus.LOADING));
    ApiBookingResponse schoolResources = await _userRepo.getSchoolResources(authCubit.state.userSession!.sessionToken);

    switch (schoolResources.status) {
      case ApiBookingResponseStatus.SUCCESS:
        emit(state.copyWith(status: ResourceStatus.LOADED, schoolResources: schoolResources.data));
        break;
      case ApiBookingResponseStatus.ERROR:
      case ApiBookingResponseStatus.UNAUTHORIZED:
        await authCubit.login();
        await getSchoolResources(authCubit);
        break;
      case ApiBookingResponseStatus.NOT_FOUND:
        emit(state.copyWith(status: ResourceStatus.ERROR, resourcePageErrorMessage: schoolResources.data));
        break;
    }
  }

  Future<void> getResourceAvailabilities(AuthCubit authCubit, String resourceId, DateTime date) async {
    emit(state.copyWithoutSelections(status: ResourceStatus.LOADING));
    ApiBookingResponse currentSelectedResource =
        await _userRepo.getResourceAvailabilities(resourceId, date, authCubit.state.userSession!.sessionToken);
    switch (currentSelectedResource.status) {
      case ApiBookingResponseStatus.SUCCESS:
        parseResourceAvailabilities(currentSelectedResource.data);
        emit(state.copyWith(status: ResourceStatus.LOADED, currentLoadedResource: currentSelectedResource.data));
        break;
      case ApiBookingResponseStatus.ERROR:
      case ApiBookingResponseStatus.UNAUTHORIZED:
        await authCubit.login();
        await getResourceAvailabilities(authCubit, resourceId, date);
        break;
      case ApiBookingResponseStatus.NOT_FOUND:
        emit(state.copyWith(status: ResourceStatus.ERROR, resourcePageErrorMessage: currentSelectedResource.data));
        break;
    }
  }

  void setLoadedResource(ResourceModel resource) {
    emit(state.copyWith(currentLoadedResource: resource));
  }

  void parseResourceAvailabilities(ResourceModel resource) {
    Map<int, List<String>> availableLocationsForTimeSlots = {};
    List<TimeSlot> availableTimeSlots = [];

    for (String locationId in resource.locationIds!) {
      for (TimeSlot timeSlot in resource.timeSlots!) {
        if (availableLocationsForTimeSlots[timeSlot.id] == null) {
          availableLocationsForTimeSlots[timeSlot.id!] = [];
        }

        if (resource.availabilities![locationId]![timeSlot.id]!.availability == AvailabilityEnum.AVAILABLE) {
          availableLocationsForTimeSlots[timeSlot.id]!.add(locationId);

          if (!availableTimeSlots.any((element) => element.id == timeSlot.id)) {
            availableTimeSlots.add(timeSlot);
          }
        }
      }
    }

    emit(state.copyWith(
        availableTimeSlots: availableTimeSlots, availableLocationsForTimeSlots: availableLocationsForTimeSlots));
  }

  Future<void> getUserBookings(AuthCubit authCubit) async {
    emit(state.copyWith(userBookingsStatus: UserBookingsStatus.LOADING));
    ApiBookingResponse userBookings = await _userRepo.getUserBookings(authCubit.state.userSession!.sessionToken);

    switch (userBookings.status) {
      case ApiBookingResponseStatus.SUCCESS:
        emit(state.copyWith(userBookingsStatus: UserBookingsStatus.LOADED, userBookings: userBookings.data));
        break;
      case ApiBookingResponseStatus.ERROR:
      case ApiBookingResponseStatus.UNAUTHORIZED:
        await authCubit.login();
        await getUserBookings(authCubit);
        break;
      case ApiBookingResponseStatus.NOT_FOUND:
        emit(state.copyWith(userBookingsStatus: UserBookingsStatus.ERROR, userBookingsErrorMessage: userBookings.data));
        break;
    }
  }

  Future<dynamic> bookResource(
      AuthCubit authCubit, String resourceId, DateTime date, AvailabilityValue bookingSlot) async {
    emit(state.copyWith(bookUnbookStatus: BookUnbookStatus.LOADING));
    ApiBookingResponse bookResource =
        await _userRepo.putBookResources(resourceId, date, bookingSlot, authCubit.state.userSession!.sessionToken);
    switch (bookResource.status) {
      case ApiBookingResponseStatus.SUCCESS:
        getResourceAvailabilities(authCubit, resourceId, date);
        break;
      case ApiBookingResponseStatus.UNAUTHORIZED:
        await authCubit.login();
        bookResource.data = await this.bookResource(authCubit, resourceId, date, bookingSlot);
        break;
      default:
        break;
    }
    emit(state.copyWith(bookUnbookStatus: BookUnbookStatus.INITIAL));
    return bookResource.data;
  }

  Future<void> unbookResource(AuthCubit authCubit, String resourceId, DateTime date, String bookingId) async {
    emit(state.copyWith(bookUnbookStatus: BookUnbookStatus.LOADING));
    ApiBookingResponse bookResource =
        await _userRepo.putUnbookResources(authCubit.state.userSession!.sessionToken, bookingId);

    switch (bookResource.status) {
      case ApiBookingResponseStatus.SUCCESS:
        getUserBookings(authCubit);
        break;
      case ApiBookingResponseStatus.UNAUTHORIZED:
        await authCubit.login();
        await unbookResource(authCubit, resourceId, date, bookingId);
        break;
      default:
        break;
    }
    emit(state.copyWith(bookUnbookStatus: BookUnbookStatus.INITIAL));
    return bookResource.data;
  }

  Future<DateTime?> userUpdateActiveDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: state.chosenDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 28)),
        currentDate: state.chosenDate);
    if (newDate != null) {
      updateActiveDate(newDate);
    }
    return newDate;
  }

  void updateActiveDate(DateTime newDate) {
    emit(state.copyWith(chosenDate: newDate));
  }

  void changeSelectedTimeStamp(TimeSlot newTimeSlot) {
    emit(state.copyWithoutSelections());
    emit(state.copyWith(selectedTimeSlot: newTimeSlot));
  }

  void changeSelectedLocationId(String newLocationId) {
    emit(state.copyWith(selectedLocationId: newLocationId));
  }
}
