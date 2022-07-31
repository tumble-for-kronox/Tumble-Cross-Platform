// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'kronox_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KronoxUserModel _$KronoxUserModelFromJson(Map<String, dynamic> json) {
  return _KronoxUserModel.fromJson(json);
}

/// @nodoc
mixin _$KronoxUserModel {
  String get name => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get sessionToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KronoxUserModelCopyWith<KronoxUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KronoxUserModelCopyWith<$Res> {
  factory $KronoxUserModelCopyWith(
          KronoxUserModel value, $Res Function(KronoxUserModel) then) =
      _$KronoxUserModelCopyWithImpl<$Res>;
  $Res call(
      {String name, String username, String sessionToken, String refreshToken});
}

/// @nodoc
class _$KronoxUserModelCopyWithImpl<$Res>
    implements $KronoxUserModelCopyWith<$Res> {
  _$KronoxUserModelCopyWithImpl(this._value, this._then);

  final KronoxUserModel _value;
  // ignore: unused_field
  final $Res Function(KronoxUserModel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? username = freezed,
    Object? sessionToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      sessionToken: sessionToken == freezed
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_KronoxUserModelCopyWith<$Res>
    implements $KronoxUserModelCopyWith<$Res> {
  factory _$$_KronoxUserModelCopyWith(
          _$_KronoxUserModel value, $Res Function(_$_KronoxUserModel) then) =
      __$$_KronoxUserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name, String username, String sessionToken, String refreshToken});
}

/// @nodoc
class __$$_KronoxUserModelCopyWithImpl<$Res>
    extends _$KronoxUserModelCopyWithImpl<$Res>
    implements _$$_KronoxUserModelCopyWith<$Res> {
  __$$_KronoxUserModelCopyWithImpl(
      _$_KronoxUserModel _value, $Res Function(_$_KronoxUserModel) _then)
      : super(_value, (v) => _then(v as _$_KronoxUserModel));

  @override
  _$_KronoxUserModel get _value => super._value as _$_KronoxUserModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? username = freezed,
    Object? sessionToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_$_KronoxUserModel(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      sessionToken: sessionToken == freezed
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_KronoxUserModel implements _KronoxUserModel {
  const _$_KronoxUserModel(
      {required this.name,
      required this.username,
      required this.sessionToken,
      required this.refreshToken});

  factory _$_KronoxUserModel.fromJson(Map<String, dynamic> json) =>
      _$$_KronoxUserModelFromJson(json);

  @override
  final String name;
  @override
  final String username;
  @override
  final String sessionToken;
  @override
  final String refreshToken;

  @override
  String toString() {
    return 'KronoxUserModel(name: $name, username: $username, sessionToken: $sessionToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KronoxUserModel &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality()
                .equals(other.sessionToken, sessionToken) &&
            const DeepCollectionEquality()
                .equals(other.refreshToken, refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(sessionToken),
      const DeepCollectionEquality().hash(refreshToken));

  @JsonKey(ignore: true)
  @override
  _$$_KronoxUserModelCopyWith<_$_KronoxUserModel> get copyWith =>
      __$$_KronoxUserModelCopyWithImpl<_$_KronoxUserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_KronoxUserModelToJson(this);
  }
}

abstract class _KronoxUserModel implements KronoxUserModel {
  const factory _KronoxUserModel(
      {required final String name,
      required final String username,
      required final String sessionToken,
      required final String refreshToken}) = _$_KronoxUserModel;

  factory _KronoxUserModel.fromJson(Map<String, dynamic> json) =
      _$_KronoxUserModel.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get username => throw _privateConstructorUsedError;
  @override
  String get sessionToken => throw _privateConstructorUsedError;
  @override
  String get refreshToken => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_KronoxUserModelCopyWith<_$_KronoxUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
