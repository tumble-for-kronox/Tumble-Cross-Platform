// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_event_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserEventCollectionModel _$$_UserEventCollectionModelFromJson(
        Map<String, dynamic> json) =>
    _$_UserEventCollectionModel(
      upcomingEvents: (json['upcomingEvents'] as List<dynamic>)
          .map(
              (e) => UpcomingUserEventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      registeredEvents: (json['registeredEvents'] as List<dynamic>)
          .map((e) =>
              AvailableUserEventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      unregisteredEvents: (json['unregisteredEvents'] as List<dynamic>)
          .map((e) =>
              AvailableUserEventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserEventCollectionModelToJson(
        _$_UserEventCollectionModel instance) =>
    <String, dynamic>{
      'upcomingEvents': instance.upcomingEvents.map((e) => e.toJson()).toList(),
      'registeredEvents':
          instance.registeredEvents.map((e) => e.toJson()).toList(),
      'unregisteredEvents':
          instance.unregisteredEvents.map((e) => e.toJson()).toList(),
    };
