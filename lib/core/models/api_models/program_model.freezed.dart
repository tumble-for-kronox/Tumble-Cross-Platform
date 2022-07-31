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
  int get count => throw _privateConstructorUsedError;
  List<Item> get items => throw _privateConstructorUsedError;

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
  $Res call({int count, List<Item> items});
}

/// @nodoc
class _$ProgramModelCopyWithImpl<$Res> implements $ProgramModelCopyWith<$Res> {
  _$ProgramModelCopyWithImpl(this._value, this._then);

  final ProgramModel _value;
  // ignore: unused_field
  final $Res Function(ProgramModel) _then;

  @override
  $Res call({
    Object? count = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
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
  $Res call({int count, List<Item> items});
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
    Object? count = freezed,
    Object? items = freezed,
  }) {
    return _then(_$_ProgramModel(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      items: items == freezed
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProgramModel implements _ProgramModel {
  const _$_ProgramModel({required this.count, required final List<Item> items})
      : _items = items;

  factory _$_ProgramModel.fromJson(Map<String, dynamic> json) =>
      _$$_ProgramModelFromJson(json);

  @override
  final int count;
  final List<Item> _items;
  @override
  List<Item> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'ProgramModel(count: $count, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProgramModel &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(_items));

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
      {required final int count,
      required final List<Item> items}) = _$_ProgramModel;

  factory _ProgramModel.fromJson(Map<String, dynamic> json) =
      _$_ProgramModel.fromJson;

  @override
  int get count => throw _privateConstructorUsedError;
  @override
  List<Item> get items => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ProgramModelCopyWith<_$_ProgramModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res>;
  $Res call({String id, String title, String subtitle});
}

/// @nodoc
class _$ItemCopyWithImpl<$Res> implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  final Item _value;
  // ignore: unused_field
  final $Res Function(Item) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? subtitle = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ItemCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$_ItemCopyWith(_$_Item value, $Res Function(_$_Item) then) =
      __$$_ItemCopyWithImpl<$Res>;
  @override
  $Res call({String id, String title, String subtitle});
}

/// @nodoc
class __$$_ItemCopyWithImpl<$Res> extends _$ItemCopyWithImpl<$Res>
    implements _$$_ItemCopyWith<$Res> {
  __$$_ItemCopyWithImpl(_$_Item _value, $Res Function(_$_Item) _then)
      : super(_value, (v) => _then(v as _$_Item));

  @override
  _$_Item get _value => super._value as _$_Item;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? subtitle = freezed,
  }) {
    return _then(_$_Item(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Item implements _Item {
  const _$_Item(
      {required this.id, required this.title, required this.subtitle});

  factory _$_Item.fromJson(Map<String, dynamic> json) => _$$_ItemFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;

  @override
  String toString() {
    return 'Item(id: $id, title: $title, subtitle: $subtitle)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Item &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.subtitle, subtitle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(subtitle));

  @JsonKey(ignore: true)
  @override
  _$$_ItemCopyWith<_$_Item> get copyWith =>
      __$$_ItemCopyWithImpl<_$_Item>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemToJson(this);
  }
}

abstract class _Item implements Item {
  const factory _Item(
      {required final String id,
      required final String title,
      required final String subtitle}) = _$_Item;

  factory _Item.fromJson(Map<String, dynamic> json) = _$_Item.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get subtitle => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ItemCopyWith<_$_Item> get copyWith => throw _privateConstructorUsedError;
}
