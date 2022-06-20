// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'error_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ErrorMessageModel _$ErrorMessageModelFromJson(Map<String, dynamic> json) {
  return _ErrorMessageModel.fromJson(json);
}

/// @nodoc
mixin _$ErrorMessageModel {
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorMessageModelCopyWith<ErrorMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorMessageModelCopyWith<$Res> {
  factory $ErrorMessageModelCopyWith(
          ErrorMessageModel value, $Res Function(ErrorMessageModel) then) =
      _$ErrorMessageModelCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$ErrorMessageModelCopyWithImpl<$Res>
    implements $ErrorMessageModelCopyWith<$Res> {
  _$ErrorMessageModelCopyWithImpl(this._value, this._then);

  final ErrorMessageModel _value;
  // ignore: unused_field
  final $Res Function(ErrorMessageModel) _then;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ErrorMessageModelCopyWith<$Res>
    implements $ErrorMessageModelCopyWith<$Res> {
  factory _$$_ErrorMessageModelCopyWith(_$_ErrorMessageModel value,
          $Res Function(_$_ErrorMessageModel) then) =
      __$$_ErrorMessageModelCopyWithImpl<$Res>;
  @override
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorMessageModelCopyWithImpl<$Res>
    extends _$ErrorMessageModelCopyWithImpl<$Res>
    implements _$$_ErrorMessageModelCopyWith<$Res> {
  __$$_ErrorMessageModelCopyWithImpl(
      _$_ErrorMessageModel _value, $Res Function(_$_ErrorMessageModel) _then)
      : super(_value, (v) => _then(v as _$_ErrorMessageModel));

  @override
  _$_ErrorMessageModel get _value => super._value as _$_ErrorMessageModel;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_ErrorMessageModel(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ErrorMessageModel implements _ErrorMessageModel {
  const _$_ErrorMessageModel({required this.message});

  factory _$_ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      _$$_ErrorMessageModelFromJson(json);

  @override
  final String message;

  @override
  String toString() {
    return 'ErrorMessageModel(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorMessageModel &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_ErrorMessageModelCopyWith<_$_ErrorMessageModel> get copyWith =>
      __$$_ErrorMessageModelCopyWithImpl<_$_ErrorMessageModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ErrorMessageModelToJson(this);
  }
}

abstract class _ErrorMessageModel implements ErrorMessageModel {
  const factory _ErrorMessageModel({required final String message}) =
      _$_ErrorMessageModel;

  factory _ErrorMessageModel.fromJson(Map<String, dynamic> json) =
      _$_ErrorMessageModel.fromJson;

  @override
  String get message => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ErrorMessageModelCopyWith<_$_ErrorMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
