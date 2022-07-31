// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'upcoming_user_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UpcomingUserEventModel _$UpcomingUserEventModelFromJson(
    Map<String, dynamic> json) {
  return _UpcomingUserEventModel.fromJson(json);
}

/// @nodoc
mixin _$UpcomingUserEventModel {
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime get eventStart => throw _privateConstructorUsedError;
  DateTime get eventEnd => throw _privateConstructorUsedError;
  DateTime get firstSignupDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpcomingUserEventModelCopyWith<UpcomingUserEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpcomingUserEventModelCopyWith<$Res> {
  factory $UpcomingUserEventModelCopyWith(UpcomingUserEventModel value,
          $Res Function(UpcomingUserEventModel) then) =
      _$UpcomingUserEventModelCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String type,
      DateTime eventStart,
      DateTime eventEnd,
      DateTime firstSignupDate});
}

/// @nodoc
class _$UpcomingUserEventModelCopyWithImpl<$Res>
    implements $UpcomingUserEventModelCopyWith<$Res> {
  _$UpcomingUserEventModelCopyWithImpl(this._value, this._then);

  final UpcomingUserEventModel _value;
  // ignore: unused_field
  final $Res Function(UpcomingUserEventModel) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? type = freezed,
    Object? eventStart = freezed,
    Object? eventEnd = freezed,
    Object? firstSignupDate = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      eventStart: eventStart == freezed
          ? _value.eventStart
          : eventStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventEnd: eventEnd == freezed
          ? _value.eventEnd
          : eventEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      firstSignupDate: firstSignupDate == freezed
          ? _value.firstSignupDate
          : firstSignupDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_UpcomingUserEventModelCopyWith<$Res>
    implements $UpcomingUserEventModelCopyWith<$Res> {
  factory _$$_UpcomingUserEventModelCopyWith(_$_UpcomingUserEventModel value,
          $Res Function(_$_UpcomingUserEventModel) then) =
      __$$_UpcomingUserEventModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String type,
      DateTime eventStart,
      DateTime eventEnd,
      DateTime firstSignupDate});
}

/// @nodoc
class __$$_UpcomingUserEventModelCopyWithImpl<$Res>
    extends _$UpcomingUserEventModelCopyWithImpl<$Res>
    implements _$$_UpcomingUserEventModelCopyWith<$Res> {
  __$$_UpcomingUserEventModelCopyWithImpl(_$_UpcomingUserEventModel _value,
      $Res Function(_$_UpcomingUserEventModel) _then)
      : super(_value, (v) => _then(v as _$_UpcomingUserEventModel));

  @override
  _$_UpcomingUserEventModel get _value =>
      super._value as _$_UpcomingUserEventModel;

  @override
  $Res call({
    Object? title = freezed,
    Object? type = freezed,
    Object? eventStart = freezed,
    Object? eventEnd = freezed,
    Object? firstSignupDate = freezed,
  }) {
    return _then(_$_UpcomingUserEventModel(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      eventStart: eventStart == freezed
          ? _value.eventStart
          : eventStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventEnd: eventEnd == freezed
          ? _value.eventEnd
          : eventEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      firstSignupDate: firstSignupDate == freezed
          ? _value.firstSignupDate
          : firstSignupDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UpcomingUserEventModel implements _UpcomingUserEventModel {
  const _$_UpcomingUserEventModel(
      {required this.title,
      required this.type,
      required this.eventStart,
      required this.eventEnd,
      required this.firstSignupDate});

  factory _$_UpcomingUserEventModel.fromJson(Map<String, dynamic> json) =>
      _$$_UpcomingUserEventModelFromJson(json);

  @override
  final String title;
  @override
  final String type;
  @override
  final DateTime eventStart;
  @override
  final DateTime eventEnd;
  @override
  final DateTime firstSignupDate;

  @override
  String toString() {
    return 'UpcomingUserEventModel(title: $title, type: $type, eventStart: $eventStart, eventEnd: $eventEnd, firstSignupDate: $firstSignupDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpcomingUserEventModel &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.eventStart, eventStart) &&
            const DeepCollectionEquality().equals(other.eventEnd, eventEnd) &&
            const DeepCollectionEquality()
                .equals(other.firstSignupDate, firstSignupDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(eventStart),
      const DeepCollectionEquality().hash(eventEnd),
      const DeepCollectionEquality().hash(firstSignupDate));

  @JsonKey(ignore: true)
  @override
  _$$_UpcomingUserEventModelCopyWith<_$_UpcomingUserEventModel> get copyWith =>
      __$$_UpcomingUserEventModelCopyWithImpl<_$_UpcomingUserEventModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UpcomingUserEventModelToJson(this);
  }
}

abstract class _UpcomingUserEventModel implements UpcomingUserEventModel {
  const factory _UpcomingUserEventModel(
      {required final String title,
      required final String type,
      required final DateTime eventStart,
      required final DateTime eventEnd,
      required final DateTime firstSignupDate}) = _$_UpcomingUserEventModel;

  factory _UpcomingUserEventModel.fromJson(Map<String, dynamic> json) =
      _$_UpcomingUserEventModel.fromJson;

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  DateTime get eventStart => throw _privateConstructorUsedError;
  @override
  DateTime get eventEnd => throw _privateConstructorUsedError;
  @override
  DateTime get firstSignupDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UpcomingUserEventModelCopyWith<_$_UpcomingUserEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}
