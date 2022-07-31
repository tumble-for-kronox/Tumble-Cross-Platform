// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_event_collection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserEventCollectionModel _$UserEventCollectionModelFromJson(
    Map<String, dynamic> json) {
  return _UserEventCollectionModel.fromJson(json);
}

/// @nodoc
mixin _$UserEventCollectionModel {
  List<UpcomingUserEventModel> get upcomingEvents =>
      throw _privateConstructorUsedError;
  List<AvailableUserEventModel> get registeredEvents =>
      throw _privateConstructorUsedError;
  List<AvailableUserEventModel> get unregisteredEvents =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserEventCollectionModelCopyWith<UserEventCollectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEventCollectionModelCopyWith<$Res> {
  factory $UserEventCollectionModelCopyWith(UserEventCollectionModel value,
          $Res Function(UserEventCollectionModel) then) =
      _$UserEventCollectionModelCopyWithImpl<$Res>;
  $Res call(
      {List<UpcomingUserEventModel> upcomingEvents,
      List<AvailableUserEventModel> registeredEvents,
      List<AvailableUserEventModel> unregisteredEvents});
}

/// @nodoc
class _$UserEventCollectionModelCopyWithImpl<$Res>
    implements $UserEventCollectionModelCopyWith<$Res> {
  _$UserEventCollectionModelCopyWithImpl(this._value, this._then);

  final UserEventCollectionModel _value;
  // ignore: unused_field
  final $Res Function(UserEventCollectionModel) _then;

  @override
  $Res call({
    Object? upcomingEvents = freezed,
    Object? registeredEvents = freezed,
    Object? unregisteredEvents = freezed,
  }) {
    return _then(_value.copyWith(
      upcomingEvents: upcomingEvents == freezed
          ? _value.upcomingEvents
          : upcomingEvents // ignore: cast_nullable_to_non_nullable
              as List<UpcomingUserEventModel>,
      registeredEvents: registeredEvents == freezed
          ? _value.registeredEvents
          : registeredEvents // ignore: cast_nullable_to_non_nullable
              as List<AvailableUserEventModel>,
      unregisteredEvents: unregisteredEvents == freezed
          ? _value.unregisteredEvents
          : unregisteredEvents // ignore: cast_nullable_to_non_nullable
              as List<AvailableUserEventModel>,
    ));
  }
}

/// @nodoc
abstract class _$$_UserEventCollectionModelCopyWith<$Res>
    implements $UserEventCollectionModelCopyWith<$Res> {
  factory _$$_UserEventCollectionModelCopyWith(
          _$_UserEventCollectionModel value,
          $Res Function(_$_UserEventCollectionModel) then) =
      __$$_UserEventCollectionModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<UpcomingUserEventModel> upcomingEvents,
      List<AvailableUserEventModel> registeredEvents,
      List<AvailableUserEventModel> unregisteredEvents});
}

/// @nodoc
class __$$_UserEventCollectionModelCopyWithImpl<$Res>
    extends _$UserEventCollectionModelCopyWithImpl<$Res>
    implements _$$_UserEventCollectionModelCopyWith<$Res> {
  __$$_UserEventCollectionModelCopyWithImpl(_$_UserEventCollectionModel _value,
      $Res Function(_$_UserEventCollectionModel) _then)
      : super(_value, (v) => _then(v as _$_UserEventCollectionModel));

  @override
  _$_UserEventCollectionModel get _value =>
      super._value as _$_UserEventCollectionModel;

  @override
  $Res call({
    Object? upcomingEvents = freezed,
    Object? registeredEvents = freezed,
    Object? unregisteredEvents = freezed,
  }) {
    return _then(_$_UserEventCollectionModel(
      upcomingEvents: upcomingEvents == freezed
          ? _value._upcomingEvents
          : upcomingEvents // ignore: cast_nullable_to_non_nullable
              as List<UpcomingUserEventModel>,
      registeredEvents: registeredEvents == freezed
          ? _value._registeredEvents
          : registeredEvents // ignore: cast_nullable_to_non_nullable
              as List<AvailableUserEventModel>,
      unregisteredEvents: unregisteredEvents == freezed
          ? _value._unregisteredEvents
          : unregisteredEvents // ignore: cast_nullable_to_non_nullable
              as List<AvailableUserEventModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserEventCollectionModel implements _UserEventCollectionModel {
  const _$_UserEventCollectionModel(
      {required final List<UpcomingUserEventModel> upcomingEvents,
      required final List<AvailableUserEventModel> registeredEvents,
      required final List<AvailableUserEventModel> unregisteredEvents})
      : _upcomingEvents = upcomingEvents,
        _registeredEvents = registeredEvents,
        _unregisteredEvents = unregisteredEvents;

  factory _$_UserEventCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserEventCollectionModelFromJson(json);

  final List<UpcomingUserEventModel> _upcomingEvents;
  @override
  List<UpcomingUserEventModel> get upcomingEvents {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingEvents);
  }

  final List<AvailableUserEventModel> _registeredEvents;
  @override
  List<AvailableUserEventModel> get registeredEvents {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_registeredEvents);
  }

  final List<AvailableUserEventModel> _unregisteredEvents;
  @override
  List<AvailableUserEventModel> get unregisteredEvents {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unregisteredEvents);
  }

  @override
  String toString() {
    return 'UserEventCollectionModel(upcomingEvents: $upcomingEvents, registeredEvents: $registeredEvents, unregisteredEvents: $unregisteredEvents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserEventCollectionModel &&
            const DeepCollectionEquality()
                .equals(other._upcomingEvents, _upcomingEvents) &&
            const DeepCollectionEquality()
                .equals(other._registeredEvents, _registeredEvents) &&
            const DeepCollectionEquality()
                .equals(other._unregisteredEvents, _unregisteredEvents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_upcomingEvents),
      const DeepCollectionEquality().hash(_registeredEvents),
      const DeepCollectionEquality().hash(_unregisteredEvents));

  @JsonKey(ignore: true)
  @override
  _$$_UserEventCollectionModelCopyWith<_$_UserEventCollectionModel>
      get copyWith => __$$_UserEventCollectionModelCopyWithImpl<
          _$_UserEventCollectionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserEventCollectionModelToJson(this);
  }
}

abstract class _UserEventCollectionModel implements UserEventCollectionModel {
  const factory _UserEventCollectionModel(
          {required final List<UpcomingUserEventModel> upcomingEvents,
          required final List<AvailableUserEventModel> registeredEvents,
          required final List<AvailableUserEventModel> unregisteredEvents}) =
      _$_UserEventCollectionModel;

  factory _UserEventCollectionModel.fromJson(Map<String, dynamic> json) =
      _$_UserEventCollectionModel.fromJson;

  @override
  List<UpcomingUserEventModel> get upcomingEvents =>
      throw _privateConstructorUsedError;
  @override
  List<AvailableUserEventModel> get registeredEvents =>
      throw _privateConstructorUsedError;
  @override
  List<AvailableUserEventModel> get unregisteredEvents =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UserEventCollectionModelCopyWith<_$_UserEventCollectionModel>
      get copyWith => throw _privateConstructorUsedError;
}
