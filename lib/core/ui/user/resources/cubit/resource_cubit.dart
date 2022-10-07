import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/shared/notification_channels.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

import '../../../../api/apiservices/api_booking_response.dart';
import '../../../../api/builders/notification_service_builder.dart';
import '../../../../api/repository/user_repository.dart';
import '../../../../dependency_injection/get_it_instances.dart';
import '../../../../models/api_models/resource_model.dart';
import '../../../login/cubit/auth_cubit.dart';

part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  final _notificationBuilder = NotificationServiceBuilder();
  final _awesomeNotifications = getIt<AwesomeNotifications>();

  ResourceCubit()
      : super(ResourceState(
          status: ResourceStatus.INITIAL,
          userBookingsStatus: UserBookingsStatus.INITIAL,
          bookUnbookStatus: BookUnbookStatus.INITIAL,
          chosenDate: DateTime.now(),
        ));

  final _userRepo = getIt<UserRepository>();

  Future<void> getSchoolResources(AuthCubit authCubit,
      {bool loginLooped = false}) async {
    emit(state.copyWith(status: ResourceStatus.LOADING));
    ApiBookingResponse schoolResources = await _userRepo
        .getSchoolResources(authCubit.state.userSession!.sessionToken);

    switch (schoolResources.status) {
      case ApiBookingResponseStatus.SUCCESS:
        emit(state.copyWith(
            status: ResourceStatus.LOADED,
            schoolResources: schoolResources.data));
        break;
      case ApiBookingResponseStatus.ERROR:
      case ApiBookingResponseStatus.UNAUTHORIZED:
        if (!loginLooped) {
          await authCubit.login();
          await getSchoolResources(authCubit, loginLooped: true);
        } else {
          authCubit.logout();
        }
        break;
      case ApiBookingResponseStatus.NOT_FOUND:
        emit(state.copyWith(
            status: ResourceStatus.ERROR,
            resourcePageErrorMessage: schoolResources.data));
        break;
    }
  }

  Future<void> getResourceAvailabilities(
      AuthCubit authCubit, String resourceId, DateTime date,
      {bool loginLooped = false}) async {
    emit(state.copyWithoutSelections(status: ResourceStatus.LOADING));
    ApiBookingResponse currentSelectedResource =
        await _userRepo.getResourceAvailabilities(
            resourceId, date, authCubit.state.userSession!.sessionToken);
    switch (currentSelectedResource.status) {
      case ApiBookingResponseStatus.SUCCESS:
        parseResourceAvailabilities(currentSelectedResource.data);
        emit(state.copyWith(
            status: ResourceStatus.LOADED,
            currentLoadedResource: currentSelectedResource.data));
        break;
      case ApiBookingResponseStatus.ERROR:
      case ApiBookingResponseStatus.UNAUTHORIZED:
        if (!loginLooped) {
          await authCubit.login();
          await getResourceAvailabilities(authCubit, resourceId, date);
        } else {
          authCubit.logout();
        }
        break;
      case ApiBookingResponseStatus.NOT_FOUND:
        emit(state.copyWith(
            status: ResourceStatus.ERROR,
            resourcePageErrorMessage: currentSelectedResource.data));
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

    emit(state.copyWith(
        availableTimeSlots: availableTimeSlots,
        availableLocationsForTimeSlots: availableLocationsForTimeSlots));
  }

  Future<void> getUserBookings(AuthCubit authCubit,
      {bool loginLooped = false}) async {
    emit(state.copyWith(userBookingsStatus: UserBookingsStatus.LOADING));
    ApiBookingResponse userBookings = await _userRepo
        .getUserBookings(authCubit.state.userSession!.sessionToken);

    switch (userBookings.status) {
      case ApiBookingResponseStatus.SUCCESS:
        updateNotificationsForIncomingBookings(userBookings.data);

        List<bool> falseFilledLoadingList = List<bool>.filled(
            (userBookings.data as List<Booking>).length, false);
        emit(state.copyWith(
          userBookingsStatus: UserBookingsStatus.LOADED,
          userBookings: userBookings.data,
          confirmationLoading: falseFilledLoadingList,
          unbookLoading: falseFilledLoadingList,
        ));
        break;
      case ApiBookingResponseStatus.ERROR:
      case ApiBookingResponseStatus.UNAUTHORIZED:
        if (!loginLooped) {
          await authCubit.login();
          await getUserBookings(authCubit);
        } else {
          authCubit.logout();
        }
        break;
      case ApiBookingResponseStatus.NOT_FOUND:
        emit(state.copyWith(
            userBookingsStatus: UserBookingsStatus.ERROR,
            userBookingsErrorMessage: userBookings.data));
        break;
    }
  }

  Future<String> bookResource(AuthCubit authCubit, String resourceId,
      DateTime date, AvailabilityValue bookingSlot,
      {bool loginLooped = false}) async {
    emit(state.copyWith(bookUnbookStatus: BookUnbookStatus.LOADING));
    ApiBookingResponse bookResource = await _userRepo.putBookResources(
        resourceId,
        date,
        bookingSlot,
        authCubit.state.userSession!.sessionToken);

    switch (bookResource.status) {
      case ApiBookingResponseStatus.SUCCESS:
        getResourceAvailabilities(authCubit, resourceId, date);
        break;
      case ApiBookingResponseStatus.UNAUTHORIZED:
        if (!loginLooped) {
          await authCubit.login();
          bookResource.data =
              await this.bookResource(authCubit, resourceId, date, bookingSlot);
        } else {
          authCubit.logout();
        }
        break;
      default:
        break;
    }
    emit(state.copyWith(bookUnbookStatus: BookUnbookStatus.INITIAL));
    return bookResource.data as String;
  }

  Future<String> unbookResource(
      AuthCubit authCubit, String bookingId, unbookLoadingIndex,
      {bool loginLooped = false}) async {
    emit(state.copyWith(
        unbookLoading:
            state.unbookLoading!.copyAndUpdate(unbookLoadingIndex, true)));
    ApiBookingResponse bookResource = await _userRepo.putUnbookResources(
        authCubit.state.userSession!.sessionToken, bookingId);

    switch (bookResource.status) {
      case ApiBookingResponseStatus.SUCCESS:
        cancelNotificationForBooking(bookingId);
        getUserBookings(authCubit);
        break;
      case ApiBookingResponseStatus.UNAUTHORIZED:
        if (!loginLooped) {
          await authCubit.login();
          bookResource.data =
              await unbookResource(authCubit, bookingId, unbookLoadingIndex);
        } else {
          authCubit.logout();
        }
        break;
      default:
        break;
    }

    emit(state.copyWith(
        unbookLoading:
            state.unbookLoading!.copyAndUpdate(unbookLoadingIndex, false)));
    return bookResource.data as String;
  }

  Future<String> confirmBooking(AuthCubit authCubit, String resourceId,
      String bookingId, int confirmLoadingIndex,
      {bool loginLooped = false}) async {
    emit(state.copyWith(
        confirmationLoading: state.confirmationLoading!
            .copyAndUpdate(confirmLoadingIndex, true)));

    ApiBookingResponse confirmBooking = await _userRepo.putConfirmBooking(
        authCubit.state.userSession!.sessionToken, resourceId, bookingId);

    switch (confirmBooking.status) {
      case ApiBookingResponseStatus.SUCCESS:
        getUserBookings(authCubit);
        break;
      case ApiBookingResponseStatus.UNAUTHORIZED:
        if (!loginLooped) {
          await authCubit.login();
          confirmBooking.data = await this.confirmBooking(
              authCubit, resourceId, bookingId, confirmLoadingIndex);
        } else {
          authCubit.logout();
        }
        break;
      default:
        break;
    }

    emit(state.copyWith(
        confirmationLoading: state.confirmationLoading!
            .copyAndUpdate(confirmLoadingIndex, false)));
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
    return booking.timeSlot.from.isBefore(DateTime.now()) &&
        booking.timeSlot.to.isAfter(DateTime.now());
  }

  Future<void> updateNotificationsForIncomingBookings(
      List<Booking> bookings) async {
    List<NotificationModel> setBookingNotifications =
        (await _awesomeNotifications.listScheduledNotifications())
            .where((element) =>
                element.content!.channelKey == NotificationChannels.resources)
            .toList();

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
    return _awesomeNotifications.isNotificationAllowed().then((isAllowed) {
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
    _awesomeNotifications.cancel(bookingId.hashCode);
    log(name: 'resource_cubit', "Cancelled notification for $bookingId");
  }
}
