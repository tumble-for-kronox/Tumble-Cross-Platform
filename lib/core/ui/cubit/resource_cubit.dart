import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/repository/user_action_repository.dart';
import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/api/backend/response_types/refresh_response.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/notifications/builders/notification_service_builder.dart';
import 'package:tumble/core/notifications/repository/notification_repository.dart';
import 'package:tumble/core/notifications/data/notification_channels.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  final _notificationBuilder = NotificationServiceBuilder();
  final _userService = getIt<UserActionRepository>();
  final _preferenceService = getIt<PreferenceRepository>();
  final _notificationService = getIt<NotificationRepository>();

  ResourceCubit()
      : super(ResourceState(
          status: ResourceStatus.INITIAL,
          userBookingsStatus: UserBookingsStatus.INITIAL,
          bookUnbookStatus: BookUnbookStatus.INITIAL,
          chosenDate: DateTime.now(),
        ));

  Future<void> getSchoolResources(
      KronoxUserModel session, void Function(KronoxUserModel) setAuthSession, Function logOut) async {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(status: ResourceStatus.LOADING));
    RefreshResponse<BookingResponse> refreshResponse = await _userService.schoolResources(session);
    BookingResponse schoolResources = refreshResponse.data;

    switch (schoolResources.status) {
      case ApiBookingResponseStatus.SUCCESS:
        if (isClosed) {
          return;
        }
        setAuthSession(refreshResponse.refreshResp.data as KronoxUserModel);
        emit(state.copyWith(status: ResourceStatus.LOADED, schoolResources: schoolResources.data));
        break;
      case ApiBookingResponseStatus.ERROR:
      case ApiBookingResponseStatus.UNAUTHORIZED:
        logOut();
        break;
      case ApiBookingResponseStatus.NOT_FOUND:
        emit(state.copyWith(status: ResourceStatus.ERROR, resourcePageErrorMessage: schoolResources.data));
        break;
    }
  }

  Future<void> getResourceAvailabilities(KronoxUserModel session, void Function(KronoxUserModel) setAuthSession,
      Function logOut, String resourceId, DateTime date) async {
    log(name: 'resource_cubit', 'Fetching resource availabilities...');
    emit(state.copyWithoutSelections(status: ResourceStatus.LOADING));
    RefreshResponse<BookingResponse> refreshResponse =
        await _userService.resourceAvailabilities(resourceId, date, session);
    BookingResponse currentSelectedResource = refreshResponse.data;

    switch (currentSelectedResource.status) {
      case ApiBookingResponseStatus.SUCCESS:
        parseResourceAvailabilities(currentSelectedResource.data);
        setAuthSession(refreshResponse.refreshResp.data as KronoxUserModel);
        emit(state.copyWith(status: ResourceStatus.LOADED, currentLoadedResource: currentSelectedResource.data));
        log(name: 'resource_cubit', 'Successfully fetched and updated resource availabilities');
        break;
      case ApiBookingResponseStatus.UNAUTHORIZED:
        logOut();
        break;
      case ApiBookingResponseStatus.ERROR:
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
    log(name: 'resource_cubit', 'Parsed Resource Availabilities');
    emit(state.copyWith(
        availableTimeSlots: availableTimeSlots, availableLocationsForTimeSlots: availableLocationsForTimeSlots));
  }

  Future<void> getUserBookings(
      KronoxUserModel session, void Function(KronoxUserModel) setAuthSession, Function logOut) async {
    log(name: 'resource_cubit', 'Retrieving user bookings ..');
    emit(state.copyWith(userBookingsStatus: UserBookingsStatus.LOADING));
    RefreshResponse<BookingResponse> refreshResponse = await _userService.userBookings(session);
    BookingResponse userBookings = refreshResponse.data;

    switch (userBookings.status) {
      case ApiBookingResponseStatus.SUCCESS:
        log(name: 'resource_cubit', 'Successfully retrieved user bookings ..');
        if (_preferenceService.allowedNotifications != null && _preferenceService.allowedNotifications!) {
          updateNotificationsForIncomingBookings(userBookings.data);
        }

        List<bool> falseFilledLoadingList = List<bool>.filled((userBookings.data as List<Booking>).length, false);
        if (isClosed) {
          return;
        }
        setAuthSession(refreshResponse.refreshResp.data as KronoxUserModel);
        emit(state.copyWith(
          userBookingsStatus: UserBookingsStatus.LOADED,
          userBookings: userBookings.data,
          confirmationLoading: falseFilledLoadingList,
          unbookLoading: falseFilledLoadingList,
        ));
        break;
      case ApiBookingResponseStatus.UNAUTHORIZED:
        logOut();
        break;
      case ApiBookingResponseStatus.ERROR:
      case ApiBookingResponseStatus.NOT_FOUND:
        emit(state.copyWith(userBookingsStatus: UserBookingsStatus.ERROR, userBookingsErrorMessage: userBookings.data));
        break;
    }
  }

  Future<String> bookResource(KronoxUserModel session, void Function(KronoxUserModel) setAuthSession, Function logOut,
      String resourceId, DateTime date, AvailabilityValue bookingSlot) async {
    emit(state.copyWith(bookUnbookStatus: BookUnbookStatus.LOADING));
    RefreshResponse<BookingResponse> refreshResponse =
        await _userService.bookResources(resourceId, date, bookingSlot, session);
    BookingResponse bookResource = refreshResponse.data;

    switch (bookResource.status) {
      case ApiBookingResponseStatus.SUCCESS:
        getResourceAvailabilities(session, setAuthSession, logOut, resourceId, date);
        getUserBookings(session, setAuthSession, logOut);
        break;
      case ApiBookingResponseStatus.UNAUTHORIZED:
        logOut();
        break;
      default:
        break;
    }
    emit(state.copyWith(bookUnbookStatus: BookUnbookStatus.INITIAL));
    return bookResource.data as String;
  }

  Future<String> unbookResource(KronoxUserModel session, void Function(KronoxUserModel) setAuthSession, Function logOut,
      String bookingId, unbookLoadingIndex) async {
    emit(state.copyWith(unbookLoading: state.unbookLoading!.copyAndUpdate(unbookLoadingIndex, true)));
    RefreshResponse<BookingResponse> refreshResponse = await _userService.unbookResources(bookingId, session);
    BookingResponse bookResource = refreshResponse.data;

    switch (bookResource.status) {
      case ApiBookingResponseStatus.SUCCESS:
        cancelNotificationForBooking(bookingId);
        getUserBookings(session, setAuthSession, logOut);
        break;
      case ApiBookingResponseStatus.UNAUTHORIZED:
        logOut();
        break;
      default:
        break;
    }

    emit(state.copyWith(unbookLoading: state.unbookLoading!.copyAndUpdate(unbookLoadingIndex, false)));
    return bookResource.data as String;
  }

  Future<String> confirmBooking(KronoxUserModel session, void Function(KronoxUserModel) setAuthSession, Function logOut,
      String resourceId, String bookingId, int confirmLoadingIndex) async {
    emit(state.copyWith(confirmationLoading: state.confirmationLoading!.copyAndUpdate(confirmLoadingIndex, true)));

    RefreshResponse<BookingResponse> refreshResponse =
        await _userService.confirmBooking(resourceId, bookingId, session);
    BookingResponse confirmBooking = refreshResponse.data;

    switch (confirmBooking.status) {
      case ApiBookingResponseStatus.SUCCESS:
        getUserBookings(session, setAuthSession, logOut);
        break;
      case ApiBookingResponseStatus.UNAUTHORIZED:
        logOut();
        break;
      default:
        break;
    }

    emit(state.copyWith(confirmationLoading: state.confirmationLoading!.copyAndUpdate(confirmLoadingIndex, false)));
    return confirmBooking.data;
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

  bool userBookingOngoing(Booking booking) {
    return booking.timeSlot.from.isBefore(DateTime.now()) && booking.timeSlot.to.isAfter(DateTime.now());
  }

  Future<void> updateNotificationsForIncomingBookings(List<Booking> bookings) async {
    List<NotificationModel> setBookingNotifications = await _notificationService.getBookingNotifications();

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
}
