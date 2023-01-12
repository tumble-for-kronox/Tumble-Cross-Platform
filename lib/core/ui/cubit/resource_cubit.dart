import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/repository/backend_repository.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/notifications/builders/notification_service_builder.dart';
import 'package:tumble/core/api/notifications/data/notification_channels.dart';
import 'package:tumble/core/api/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  final _notificationBuilder = NotificationServiceBuilder();
  final _preferenceService = getIt<PreferenceRepository>();
  final _notificationService = getIt<NotificationRepository>();

  ResourceCubit()
      : super(ResourceState(
          status: ResourceStatus.INITIAL,
          userBookingsStatus: UserBookingsStatus.INITIAL,
          bookUnbookStatus: BookUnbookStatus.INITIAL,
          chosenDate: DateTime.now(),
        ));

  String? get locale => _preferenceService.locale;
  String get defaultSchool => getIt<PreferenceRepository>().defaultSchool!;
  final _backendRepository = getIt<BackendRepository>();

  Future<void> getSchoolResources(Function logOut) async {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(status: ResourceStatus.LOADING));
    ApiResponse apiResponse =
        await _backendRepository.getSchoolResources(defaultSchool);

    switch (apiResponse.status) {
      case ApiResponseStatus.success:
        if (isClosed) {
          return;
        }
        emit(state.copyWith(
            status: ResourceStatus.LOADED, schoolResources: apiResponse.data));
        break;
      case ApiResponseStatus.error:
      case ApiResponseStatus.unauthorized:
        logOut();
        break;
      case ApiResponseStatus.missing:
        emit(state.copyWith(
            status: ResourceStatus.ERROR,
            resourcePageErrorMessage: apiResponse.data));
        break;
      default:
        break;
    }
  }

  Future<void> getResourceAvailabilities(
      KronoxUserModel session,
      void Function(KronoxUserModel) setAuthSession,
      Function logOut,
      String resourceId,
      DateTime date) async {
    log(name: 'resource_cubit', 'Fetching resource availabilities...');
    emit(state.copyWithoutSelections(status: ResourceStatus.LOADING));
    ApiResponse currentSelectedResource = await _backendRepository
        .getResourceAvailabilities(defaultSchool, resourceId, date);

    switch (currentSelectedResource.status) {
      case ApiResponseStatus.success:
        parseResourceAvailabilities(currentSelectedResource.data);
        emit(state.copyWith(
            status: ResourceStatus.LOADED,
            currentLoadedResource: currentSelectedResource.data));
        log(
            name: 'resource_cubit',
            'Successfully fetched and updated resource availabilities');
        break;
      case ApiResponseStatus.unauthorized:
        logOut();
        break;
      case ApiResponseStatus.error:
      case ApiResponseStatus.missing:
        emit(state.copyWith(
            status: ResourceStatus.ERROR,
            resourcePageErrorMessage: currentSelectedResource.data));
        break;
      default:
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

        if (resource.availabilities![locationId]![timeSlot.id]!.availability ==
            AvailabilityEnum.AVAILABLE) {
          availableLocationsForTimeSlots[timeSlot.id]!.add(locationId);

          if (!availableTimeSlots.any((element) => element.id == timeSlot.id)) {
            availableTimeSlots.add(timeSlot);
          }
        }
      }
    }
    log(name: 'resource_cubit', 'Parsed Resource Availabilities');
    emit(state.copyWith(
        availableTimeSlots: availableTimeSlots,
        availableLocationsForTimeSlots: availableLocationsForTimeSlots));
  }

  Future<void> getUserBookings(Function logOut) async {
    log(name: 'resource_cubit', 'Retrieving user bookings ..');
    emit(state.copyWith(userBookingsStatus: UserBookingsStatus.LOADING));
    ApiResponse apiResponse =
        await _backendRepository.getUserBookings(defaultSchool);

    log(
        name: 'resource_cubit',
        'ApiBookingResponseStatus is: ${apiResponse.status}');
    switch (apiResponse.status) {
      case ApiResponseStatus.success:
        _updateBookingInformation(apiResponse);
        break;
      case ApiResponseStatus.unauthorized:
        logOut();
        break;
      case ApiResponseStatus.error:
      case ApiResponseStatus.missing:
        emit(state.copyWith(
            userBookingsStatus: UserBookingsStatus.ERROR,
            userBookingsErrorMessage: apiResponse.data));
        break;
      default:
        break;
    }
  }

  Future<String> bookResource(
      KronoxUserModel session,
      void Function(KronoxUserModel) setAuthSession,
      Function logOut,
      String resourceId,
      DateTime date,
      AvailabilityValue bookingSlot) async {
    emit(state.copyWith(bookUnbookStatus: BookUnbookStatus.LOADING));
    ApiResponse apiResponse = await _backendRepository.putBookResource(
        defaultSchool, resourceId, date, bookingSlot);

    switch (apiResponse.status) {
      case ApiResponseStatus.success:
        getResourceAvailabilities(
            session, setAuthSession, logOut, resourceId, date);
        getUserBookings(logOut);
        break;
      case ApiResponseStatus.unauthorized:
        logOut();
        break;
      default:
        break;
    }
    emit(state.copyWith(bookUnbookStatus: BookUnbookStatus.INITIAL));
    return apiResponse.data as String;
  }

  Future<String> unbookResource(
      KronoxUserModel session,
      void Function(KronoxUserModel) setAuthSession,
      Function logOut,
      String bookingId,
      unbookLoadingIndex) async {
    emit(state.copyWith(
        unbookLoading:
            state.unbookLoading!.copyAndUpdate(unbookLoadingIndex, true)));
    ApiResponse apiResponse =
        await _backendRepository.putUnbookResource(defaultSchool, bookingId);

    switch (apiResponse.status) {
      case ApiResponseStatus.success:
        cancelNotificationForBooking(bookingId);
        getUserBookings(logOut);
        break;
      case ApiResponseStatus.unauthorized:
        logOut();
        break;
      default:
        break;
    }

    emit(state.copyWith(
        unbookLoading:
            state.unbookLoading!.copyAndUpdate(unbookLoadingIndex, false)));
    return apiResponse.data as String;
  }

  Future<String> confirmBooking(
      KronoxUserModel session,
      void Function(KronoxUserModel) setAuthSession,
      Function logOut,
      String resourceId,
      String bookingId,
      int confirmLoadingIndex) async {
    emit(state.copyWith(
        confirmationLoading: state.confirmationLoading!
            .copyAndUpdate(confirmLoadingIndex, true)));

    ApiResponse apiResponse = await _backendRepository.putConfirmBooking(
        defaultSchool, resourceId, bookingId);

    switch (apiResponse.status) {
      case ApiResponseStatus.success:
        getUserBookings(logOut);
        break;
      case ApiResponseStatus.unauthorized:
        logOut();
        break;
      default:
        break;
    }

    emit(state.copyWith(
        confirmationLoading: state.confirmationLoading!
            .copyAndUpdate(confirmLoadingIndex, false)));
    return apiResponse.data;
  }

  Future<DateTime?> userUpdateActiveDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: state.chosenDate,
        locale: context.read<ResourceCubit>().locale != null
            ? Locale(context.read<ResourceCubit>().locale!)
            : null,
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

  bool userBookingOngoing(Booking booking) {
    return booking.timeSlot.from.isBefore(DateTime.now()) &&
        booking.timeSlot.to.isAfter(DateTime.now());
  }

  Future<void> updateNotificationsForIncomingBookings(
      List<Booking> bookings) async {
    List<NotificationModel> setBookingNotifications =
        await _notificationService.getBookingNotifications();

    for (Booking booking in bookings) {
      if (booking.confirmationOpen == null) continue;

      if (!setBookingNotifications.any((element) {
        return element.content!.id == booking.id.hashCode;
      })) {
        createNotificationForBooking(booking);
      }
    }
  }

  Future<bool> createNotificationForBooking(Booking booking) async {
    return _notificationService.allowedNotifications().then((isAllowed) {
      if (isAllowed) {
        _notificationBuilder.buildExactNotification(
          id: booking.id.hashCode,
          channelKey: NotificationChannels.resources,
          groupkey: NotificationGroups.resourcesConfirmRemind,
          title: S.userBookings.notificationConfirmRemindTitle(),
          body: S.userBookings.notificationConfirmRemindBody(),
          date: booking.confirmationOpen!,
        );
        log(name: 'resource_cubit', "Created notification for ${booking.id}");
        return true;
      }
      return false;
    });
  }

  void cancelNotificationForBooking(String bookingId) {
    _notificationService.cancelBookingNotification(bookingId.hashCode);
    log(name: 'resource_cubit', "Cancelled notification for $bookingId");
  }

  void _updateBookingInformation(ApiResponse apiResponse) {
    log(name: 'resource_cubit', 'Successfully retrieved user bookings ..');
    if (_preferenceService.allowedNotifications != null &&
        _preferenceService.allowedNotifications!) {
      updateNotificationsForIncomingBookings(apiResponse.data);
    }

    List<bool> falseFilledLoadingList =
        List<bool>.filled((apiResponse.data as List<Booking>).length, false);
    if (isClosed) {
      return;
    }
    emit(state.copyWith(
      userBookingsStatus: UserBookingsStatus.LOADED,
      userBookings: apiResponse.data,
      confirmationLoading: falseFilledLoadingList,
      unbookLoading: falseFilledLoadingList,
    ));
  }
}
