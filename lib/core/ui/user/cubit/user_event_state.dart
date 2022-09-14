// ignore_for_file: constant_identifier_names

part of 'user_event_cubit.dart';

enum UserOverviewStatus { LOADING, LOADED, ERROR, INITIAL }

enum UserBookingsStatus { LOADING, LOADED, ERROR, INITIAL }

enum ResourcePageStatus { LOADING, LOADED, ERROR, INITIAL }

enum RegisterUnregisterStatus { LOADING, INITIAL }

enum BookUnbookStatus { LOADING, INITIAL }

class UserEventState extends Equatable {
  final UserOverviewStatus userEventListStatus;
  final ResourcePageStatus resourcePageStatus;
  final UserBookingsStatus userBookingsStatus;
  final BookUnbookStatus bookUnbookStatus;
  final RegisterUnregisterStatus registerUnregisterStatus;
  final UserEventCollectionModel? userEvents;
  final List<ResourceModel>? schoolResources;
  final ResourceModel? currentLoadedResource;
  final List<Booking>? userBookings;
  final int? currentTabIndex;
  final bool autoSignup;
  final String? errorMessage;
  final String? userBookingsErrorMessage;
  final String? resourcePageErrorMessage;

  const UserEventState({
    required this.userEventListStatus,
    required this.resourcePageStatus,
    required this.userBookingsStatus,
    required this.bookUnbookStatus,
    required this.registerUnregisterStatus,
    required this.autoSignup,
    this.userEvents,
    this.errorMessage,
    this.resourcePageErrorMessage,
    this.userBookingsErrorMessage,
    this.schoolResources,
    this.currentLoadedResource,
    this.userBookings,
    this.currentTabIndex = 0,
  });

  UserEventState copyWith({
    UserOverviewStatus? userEventListStatus,
    ResourcePageStatus? resourcePageStatus,
    UserBookingsStatus? userBookingsStatus,
    BookUnbookStatus? bookUnbookStatus,
    RegisterUnregisterStatus? registerUnregisterStatus,
    KronoxUserModel? userSession,
    bool? autoSignup,
    UserEventCollectionModel? userEvents,
    List<ResourceModel>? schoolResources,
    ResourceModel? currentLoadedResource,
    List<Booking>? userBookings,
    String? errorMessage,
    String? userBookingsErrorMessage,
    String? resourcePageErrorMessage,
    int? currentTabIndex,
  }) =>
      UserEventState(
        userEventListStatus: userEventListStatus ?? this.userEventListStatus,
        resourcePageStatus: resourcePageStatus ?? this.resourcePageStatus,
        userBookingsStatus: userBookingsStatus ?? this.userBookingsStatus,
        bookUnbookStatus: bookUnbookStatus ?? this.bookUnbookStatus,
        registerUnregisterStatus: registerUnregisterStatus ?? this.registerUnregisterStatus,
        autoSignup: autoSignup ?? this.autoSignup,
        userEvents: userEvents ?? this.userEvents,
        schoolResources: schoolResources ?? this.schoolResources,
        currentLoadedResource: currentLoadedResource ?? this.currentLoadedResource,
        userBookings: userBookings ?? this.userBookings,
        errorMessage: errorMessage ?? this.errorMessage,
        userBookingsErrorMessage: userBookingsErrorMessage ?? this.userBookingsErrorMessage,
        resourcePageErrorMessage: resourcePageErrorMessage ?? this.resourcePageErrorMessage,
        currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      );

  @override
  List<Object?> get props => [
        userEventListStatus,
        resourcePageStatus,
        userBookingsStatus,
        bookUnbookStatus,
        registerUnregisterStatus,
        autoSignup,
        userEvents,
        schoolResources,
        currentLoadedResource,
        userBookings,
        resourcePageErrorMessage,
        userBookingsErrorMessage,
        currentTabIndex,
      ];
}
