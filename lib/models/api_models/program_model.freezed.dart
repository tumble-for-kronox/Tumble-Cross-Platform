// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'program_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProgramModel _$ProgramModelFromJson(Map<String, dynamic> json) {
  return _ProgramModel.fromJson(json);
}

/// @nodoc
mixin _$ProgramModel {
  List<RequestedSchedule> get requestedSchedule =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgramModelCopyWith<ProgramModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramModelCopyWith<$Res> {
  factory $ProgramModelCopyWith(
          ProgramModel value, $Res Function(ProgramModel) then) =
      _$ProgramModelCopyWithImpl<$Res>;
  $Res call({List<RequestedSchedule> requestedSchedule});
}

/// @nodoc
class _$ProgramModelCopyWithImpl<$Res> implements $ProgramModelCopyWith<$Res> {
  _$ProgramModelCopyWithImpl(this._value, this._then);

  final ProgramModel _value;
  // ignore: unused_field
  final $Res Function(ProgramModel) _then;

  @override
  $Res call({
    Object? requestedSchedule = freezed,
  }) {
    return _then(_value.copyWith(
      requestedSchedule: requestedSchedule == freezed
          ? _value.requestedSchedule
          : requestedSchedule // ignore: cast_nullable_to_non_nullable
              as List<RequestedSchedule>,
    ));
  }
}

/// @nodoc
abstract class _$$_ProgramModelCopyWith<$Res>
    implements $ProgramModelCopyWith<$Res> {
  factory _$$_ProgramModelCopyWith(
          _$_ProgramModel value, $Res Function(_$_ProgramModel) then) =
      __$$_ProgramModelCopyWithImpl<$Res>;
  @override
  $Res call({List<RequestedSchedule> requestedSchedule});
}

/// @nodoc
class __$$_ProgramModelCopyWithImpl<$Res>
    extends _$ProgramModelCopyWithImpl<$Res>
    implements _$$_ProgramModelCopyWith<$Res> {
  __$$_ProgramModelCopyWithImpl(
      _$_ProgramModel _value, $Res Function(_$_ProgramModel) _then)
      : super(_value, (v) => _then(v as _$_ProgramModel));

  @override
  _$_ProgramModel get _value => super._value as _$_ProgramModel;

  @override
  $Res call({
    Object? requestedSchedule = freezed,
  }) {
    return _then(_$_ProgramModel(
      requestedSchedule: requestedSchedule == freezed
          ? _value._requestedSchedule
          : requestedSchedule // ignore: cast_nullable_to_non_nullable
              as List<RequestedSchedule>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProgramModel implements _ProgramModel {
  const _$_ProgramModel(
      {required final List<RequestedSchedule> requestedSchedule})
      : _requestedSchedule = requestedSchedule;

  factory _$_ProgramModel.fromJson(Map<String, dynamic> json) =>
      _$$_ProgramModelFromJson(json);

  final List<RequestedSchedule> _requestedSchedule;
  @override
  List<RequestedSchedule> get requestedSchedule {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requestedSchedule);
  }

  @override
  String toString() {
    return 'ProgramModel(requestedSchedule: $requestedSchedule)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProgramModel &&
            const DeepCollectionEquality()
                .equals(other._requestedSchedule, _requestedSchedule));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_requestedSchedule));

  @JsonKey(ignore: true)
  @override
  _$$_ProgramModelCopyWith<_$_ProgramModel> get copyWith =>
      __$$_ProgramModelCopyWithImpl<_$_ProgramModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgramModelToJson(this);
  }
}

abstract class _ProgramModel implements ProgramModel {
  const factory _ProgramModel(
          {required final List<RequestedSchedule> requestedSchedule}) =
      _$_ProgramModel;

  factory _ProgramModel.fromJson(Map<String, dynamic> json) =
      _$_ProgramModel.fromJson;

  @override
  List<RequestedSchedule> get requestedSchedule =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ProgramModelCopyWith<_$_ProgramModel> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestedSchedule _$RequestedScheduleFromJson(Map<String, dynamic> json) {
  return _RequestedSchedule.fromJson(json);
}

/// @nodoc
mixin _$RequestedSchedule {
  String get scheduleId => throw _privateConstructorUsedError;
  String get scheduleName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestedScheduleCopyWith<RequestedSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestedScheduleCopyWith<$Res> {
  factory $RequestedScheduleCopyWith(
          RequestedSchedule value, $Res Function(RequestedSchedule) then) =
      _$RequestedScheduleCopyWithImpl<$Res>;
  $Res call({String scheduleId, String scheduleName});
}

/// @nodoc
class _$RequestedScheduleCopyWithImpl<$Res>
    implements $RequestedScheduleCopyWith<$Res> {
  _$RequestedScheduleCopyWithImpl(this._value, this._then);

  final RequestedSchedule _value;
  // ignore: unused_field
  final $Res Function(RequestedSchedule) _then;

  @override
  $Res call({
    Object? scheduleId = freezed,
    Object? scheduleName = freezed,
  }) {
    return _then(_value.copyWith(
      scheduleId: scheduleId == freezed
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleName: scheduleName == freezed
          ? _value.scheduleName
          : scheduleName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_RequestedScheduleCopyWith<$Res>
    implements $RequestedScheduleCopyWith<$Res> {
  factory _$$_RequestedScheduleCopyWith(_$_RequestedSchedule value,
          $Res Function(_$_RequestedSchedule) then) =
      __$$_RequestedScheduleCopyWithImpl<$Res>;
  @override
  $Res call({String scheduleId, String scheduleName});
}

/// @nodoc
class __$$_RequestedScheduleCopyWithImpl<$Res>
    extends _$RequestedScheduleCopyWithImpl<$Res>
    implements _$$_RequestedScheduleCopyWith<$Res> {
  __$$_RequestedScheduleCopyWithImpl(
      _$_RequestedSchedule _value, $Res Function(_$_RequestedSchedule) _then)
      : super(_value, (v) => _then(v as _$_RequestedSchedule));

  @override
  _$_RequestedSchedule get _value => super._value as _$_RequestedSchedule;

  @override
  $Res call({
    Object? scheduleId = freezed,
    Object? scheduleName = freezed,
  }) {
    return _then(_$_RequestedSchedule(
      scheduleId: scheduleId == freezed
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleName: scheduleName == freezed
          ? _value.scheduleName
          : scheduleName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RequestedSchedule implements _RequestedSchedule {
  const _$_RequestedSchedule(
      {required this.scheduleId, required this.scheduleName});

  factory _$_RequestedSchedule.fromJson(Map<String, dynamic> json) =>
      _$$_RequestedScheduleFromJson(json);

  @override
  final String scheduleId;
  @override
  final String scheduleName;

  @override
  String toString() {
    return 'RequestedSchedule(scheduleId: $scheduleId, scheduleName: $scheduleName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RequestedSchedule &&
            const DeepCollectionEquality()
                .equals(other.scheduleId, scheduleId) &&
            const DeepCollectionEquality()
                .equals(other.scheduleName, scheduleName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(scheduleId),
      const DeepCollectionEquality().hash(scheduleName));

  @JsonKey(ignore: true)
  @override
  _$$_RequestedScheduleCopyWith<_$_RequestedSchedule> get copyWith =>
      __$$_RequestedScheduleCopyWithImpl<_$_RequestedSchedule>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RequestedScheduleToJson(this);
  }
}

abstract class _RequestedSchedule implements RequestedSchedule {
  const factory _RequestedSchedule(
      {required final String scheduleId,
      required final String scheduleName}) = _$_RequestedSchedule;

  factory _RequestedSchedule.fromJson(Map<String, dynamic> json) =
      _$_RequestedSchedule.fromJson;

  @override
  String get scheduleId => throw _privateConstructorUsedError;
  @override
  String get scheduleName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RequestedScheduleCopyWith<_$_RequestedSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}
