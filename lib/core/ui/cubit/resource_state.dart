// ignore_for_file: constant_identifier_names

part of 'resource_cubit.dart';

enum ResourceStatus { loading, loaded, error, initial }

enum UserBookingsStatus { loading, loaded, error, initial }

enum BookUnbookStatus { loading, initial, error }

class ResourceState extends Equatable {
  final ResourceStatus status;
  final UserBookingsStatus userBookingsStatus;
  final BookUnbookStatus bookUnbookStatus;
  final DateTime chosenDate;
  final List<ResourceModel>? schoolResources;
  final ResourceModel? currentLoadedResource;
  final List<TimeSlot>? availableTimeSlots;
  final Map<int, List<String>>? availableLocationsForTimeSlots;
  final TimeSlot? selectedTimeSlot;
  final String? selectedLocationId;
  final List<Booking>? userBookings;
  final List<bool>? confirmationLoading;
  final List<bool>? unbookLoading;
  final String? userBookingsErrorMessage;
  final String? resourcePageErrorMessage;

  const ResourceState({
    required this.status,
    required this.userBookingsStatus,
    required this.bookUnbookStatus,
    required this.chosenDate,
    this.resourcePageErrorMessage,
    this.userBookingsErrorMessage,
    this.schoolResources,
    this.currentLoadedResource,
    this.userBookings,
    this.confirmationLoading,
    this.unbookLoading,
    this.availableTimeSlots,
    this.availableLocationsForTimeSlots,
    this.selectedLocationId,
    this.selectedTimeSlot,
  });

  ResourceState copyWith({
    ResourceStatus? status,
    UserBookingsStatus? userBookingsStatus,
    BookUnbookStatus? bookUnbookStatus,
    DateTime? chosenDate,
    List<ResourceModel>? schoolResources,
    ResourceModel? currentLoadedResource,
    List<Booking>? userBookings,
    List<bool>? confirmationLoading,
    List<bool>? unbookLoading,
    String? userBookingsErrorMessage,
    String? resourcePageErrorMessage,
    List<TimeSlot>? availableTimeSlots,
    Map<int, List<String>>? availableLocationsForTimeSlots,
    TimeSlot? selectedTimeSlot,
    String? selectedLocationId,
  }) =>
      ResourceState(
        status: status ?? this.status,
        userBookingsStatus: userBookingsStatus ?? this.userBookingsStatus,
        bookUnbookStatus: bookUnbookStatus ?? this.bookUnbookStatus,
        chosenDate: chosenDate ?? this.chosenDate,
        schoolResources: schoolResources ?? this.schoolResources,
        currentLoadedResource:
            currentLoadedResource ?? this.currentLoadedResource,
        userBookings: userBookings ?? this.userBookings,
        confirmationLoading: confirmationLoading ?? this.confirmationLoading,
        unbookLoading: unbookLoading ?? this.unbookLoading,
        userBookingsErrorMessage:
            userBookingsErrorMessage ?? this.userBookingsErrorMessage,
        resourcePageErrorMessage:
            resourcePageErrorMessage ?? this.resourcePageErrorMessage,
        availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots,
        availableLocationsForTimeSlots: availableLocationsForTimeSlots ??
            this.availableLocationsForTimeSlots,
        selectedLocationId: selectedLocationId ?? this.selectedLocationId,
        selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      );

  ResourceState copyWithoutSelections({
    ResourceStatus? status,
    UserBookingsStatus? userBookingsStatus,
    BookUnbookStatus? bookUnbookStatus,
    DateTime? chosenDate,
    List<ResourceModel>? schoolResources,
    ResourceModel? currentLoadedResource,
    List<Booking>? userBookings,
    List<bool>? confirmationLoading,
    List<bool>? unbookLoading,
    String? userBookingsErrorMessage,
    String? resourcePageErrorMessage,
    List<TimeSlot>? availableTimeSlots,
    Map<int, List<String>>? availableLocationsForTimeSlots,
  }) =>
      ResourceState(
        status: status ?? this.status,
        userBookingsStatus: userBookingsStatus ?? this.userBookingsStatus,
        bookUnbookStatus: bookUnbookStatus ?? this.bookUnbookStatus,
        chosenDate: chosenDate ?? this.chosenDate,
        schoolResources: schoolResources ?? this.schoolResources,
        currentLoadedResource:
            currentLoadedResource ?? this.currentLoadedResource,
        userBookings: userBookings ?? this.userBookings,
        confirmationLoading: confirmationLoading ?? this.confirmationLoading,
        unbookLoading: unbookLoading ?? this.unbookLoading,
        userBookingsErrorMessage:
            userBookingsErrorMessage ?? this.userBookingsErrorMessage,
        resourcePageErrorMessage:
            resourcePageErrorMessage ?? this.resourcePageErrorMessage,
        availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots,
        availableLocationsForTimeSlots: availableLocationsForTimeSlots ??
            this.availableLocationsForTimeSlots,
        selectedLocationId: null,
        selectedTimeSlot: null,
      );

  @override
  List<Object?> get props => [
        status,
        userBookingsStatus,
        bookUnbookStatus,
        chosenDate,
        schoolResources,
        currentLoadedResource,
        userBookings,
        resourcePageErrorMessage,
        userBookingsErrorMessage,
        availableTimeSlots,
        availableLocationsForTimeSlots,
        selectedLocationId,
        selectedTimeSlot,
        confirmationLoading,
        unbookLoading,
      ];
}
