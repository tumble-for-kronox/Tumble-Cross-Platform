// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CourseUiModel _$CourseUiModelFromJson(Map<String, dynamic> json) {
  return _CourseUiModel.fromJson(json);
}

/// @nodoc
mixin _$CourseUiModel {
  String get id => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseUiModelCopyWith<CourseUiModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseUiModelCopyWith<$Res> {
  factory $CourseUiModelCopyWith(
          CourseUiModel value, $Res Function(CourseUiModel) then) =
      _$CourseUiModelCopyWithImpl<$Res>;
  $Res call({String id, int color});
}

/// @nodoc
class _$CourseUiModelCopyWithImpl<$Res>
    implements $CourseUiModelCopyWith<$Res> {
  _$CourseUiModelCopyWithImpl(this._value, this._then);

  final CourseUiModel _value;
  // ignore: unused_field
  final $Res Function(CourseUiModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_CourseUiModelCopyWith<$Res>
    implements $CourseUiModelCopyWith<$Res> {
  factory _$$_CourseUiModelCopyWith(
          _$_CourseUiModel value, $Res Function(_$_CourseUiModel) then) =
      __$$_CourseUiModelCopyWithImpl<$Res>;
  @override
  $Res call({String id, int color});
}

/// @nodoc
class __$$_CourseUiModelCopyWithImpl<$Res>
    extends _$CourseUiModelCopyWithImpl<$Res>
    implements _$$_CourseUiModelCopyWith<$Res> {
  __$$_CourseUiModelCopyWithImpl(
      _$_CourseUiModel _value, $Res Function(_$_CourseUiModel) _then)
      : super(_value, (v) => _then(v as _$_CourseUiModel));

  @override
  _$_CourseUiModel get _value => super._value as _$_CourseUiModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? color = freezed,
  }) {
    return _then(_$_CourseUiModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CourseUiModel implements _CourseUiModel {
  const _$_CourseUiModel({required this.id, required this.color});

  factory _$_CourseUiModel.fromJson(Map<String, dynamic> json) =>
      _$$_CourseUiModelFromJson(json);

  @override
  final String id;
  @override
  final int color;

  @override
  String toString() {
    return 'CourseUiModel(id: $id, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CourseUiModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.color, color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(color));

  @JsonKey(ignore: true)
  @override
  _$$_CourseUiModelCopyWith<_$_CourseUiModel> get copyWith =>
      __$$_CourseUiModelCopyWithImpl<_$_CourseUiModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CourseUiModelToJson(this);
  }
}

abstract class _CourseUiModel implements CourseUiModel {
  const factory _CourseUiModel(
      {required final String id, required final int color}) = _$_CourseUiModel;

  factory _CourseUiModel.fromJson(Map<String, dynamic> json) =
      _$_CourseUiModel.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  int get color => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CourseUiModelCopyWith<_$_CourseUiModel> get copyWith =>
      throw _privateConstructorUsedError;
}
