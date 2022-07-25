// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'schedule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) {
  return _ScheduleModel.fromJson(json);
}

/// @nodoc
mixin _$ScheduleModel {
  String get cachedAt => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  List<Day> get days => throw _privateConstructorUsedError;
  Courses get courses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleModelCopyWith<ScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleModelCopyWith<$Res> {
  factory $ScheduleModelCopyWith(
          ScheduleModel value, $Res Function(ScheduleModel) then) =
      _$ScheduleModelCopyWithImpl<$Res>;
  $Res call({String cachedAt, String id, List<Day> days, Courses courses});

  $CoursesCopyWith<$Res> get courses;
}

/// @nodoc
class _$ScheduleModelCopyWithImpl<$Res>
    implements $ScheduleModelCopyWith<$Res> {
  _$ScheduleModelCopyWithImpl(this._value, this._then);

  final ScheduleModel _value;
  // ignore: unused_field
  final $Res Function(ScheduleModel) _then;

  @override
  $Res call({
    Object? cachedAt = freezed,
    Object? id = freezed,
    Object? days = freezed,
    Object? courses = freezed,
  }) {
    return _then(_value.copyWith(
      cachedAt: cachedAt == freezed
          ? _value.cachedAt
          : cachedAt // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      days: days == freezed
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<Day>,
      courses: courses == freezed
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as Courses,
    ));
  }

  @override
  $CoursesCopyWith<$Res> get courses {
    return $CoursesCopyWith<$Res>(_value.courses, (value) {
      return _then(_value.copyWith(courses: value));
    });
  }
}

/// @nodoc
abstract class _$$_ScheduleModelCopyWith<$Res>
    implements $ScheduleModelCopyWith<$Res> {
  factory _$$_ScheduleModelCopyWith(
          _$_ScheduleModel value, $Res Function(_$_ScheduleModel) then) =
      __$$_ScheduleModelCopyWithImpl<$Res>;
  @override
  $Res call({String cachedAt, String id, List<Day> days, Courses courses});

  @override
  $CoursesCopyWith<$Res> get courses;
}

/// @nodoc
class __$$_ScheduleModelCopyWithImpl<$Res>
    extends _$ScheduleModelCopyWithImpl<$Res>
    implements _$$_ScheduleModelCopyWith<$Res> {
  __$$_ScheduleModelCopyWithImpl(
      _$_ScheduleModel _value, $Res Function(_$_ScheduleModel) _then)
      : super(_value, (v) => _then(v as _$_ScheduleModel));

  @override
  _$_ScheduleModel get _value => super._value as _$_ScheduleModel;

  @override
  $Res call({
    Object? cachedAt = freezed,
    Object? id = freezed,
    Object? days = freezed,
    Object? courses = freezed,
  }) {
    return _then(_$_ScheduleModel(
      cachedAt: cachedAt == freezed
          ? _value.cachedAt
          : cachedAt // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      days: days == freezed
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<Day>,
      courses: courses == freezed
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as Courses,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScheduleModel implements _ScheduleModel {
  const _$_ScheduleModel(
      {required this.cachedAt,
      required this.id,
      required final List<Day> days,
      required this.courses})
      : _days = days;

  factory _$_ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$$_ScheduleModelFromJson(json);

  @override
  final String cachedAt;
  @override
  final String id;
  final List<Day> _days;
  @override
  List<Day> get days {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  final Courses courses;

  @override
  String toString() {
    return 'ScheduleModel(cachedAt: $cachedAt, id: $id, days: $days, courses: $courses)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScheduleModel &&
            const DeepCollectionEquality().equals(other.cachedAt, cachedAt) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            const DeepCollectionEquality().equals(other.courses, courses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(cachedAt),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(_days),
      const DeepCollectionEquality().hash(courses));

  @JsonKey(ignore: true)
  @override
  _$$_ScheduleModelCopyWith<_$_ScheduleModel> get copyWith =>
      __$$_ScheduleModelCopyWithImpl<_$_ScheduleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScheduleModelToJson(this);
  }
}

abstract class _ScheduleModel implements ScheduleModel {
  const factory _ScheduleModel(
      {required final String cachedAt,
      required final String id,
      required final List<Day> days,
      required final Courses courses}) = _$_ScheduleModel;

  factory _ScheduleModel.fromJson(Map<String, dynamic> json) =
      _$_ScheduleModel.fromJson;

  @override
  String get cachedAt => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  List<Day> get days => throw _privateConstructorUsedError;
  @override
  Courses get courses => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ScheduleModelCopyWith<_$_ScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Courses _$CoursesFromJson(Map<String, dynamic> json) {
  return _Courses.fromJson(json);
}

/// @nodoc
mixin _$Courses {
  CourseId get courseId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoursesCopyWith<Courses> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoursesCopyWith<$Res> {
  factory $CoursesCopyWith(Courses value, $Res Function(Courses) then) =
      _$CoursesCopyWithImpl<$Res>;
  $Res call({CourseId courseId});

  $CourseIdCopyWith<$Res> get courseId;
}

/// @nodoc
class _$CoursesCopyWithImpl<$Res> implements $CoursesCopyWith<$Res> {
  _$CoursesCopyWithImpl(this._value, this._then);

  final Courses _value;
  // ignore: unused_field
  final $Res Function(Courses) _then;

  @override
  $Res call({
    Object? courseId = freezed,
  }) {
    return _then(_value.copyWith(
      courseId: courseId == freezed
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as CourseId,
    ));
  }

  @override
  $CourseIdCopyWith<$Res> get courseId {
    return $CourseIdCopyWith<$Res>(_value.courseId, (value) {
      return _then(_value.copyWith(courseId: value));
    });
  }
}

/// @nodoc
abstract class _$$_CoursesCopyWith<$Res> implements $CoursesCopyWith<$Res> {
  factory _$$_CoursesCopyWith(
          _$_Courses value, $Res Function(_$_Courses) then) =
      __$$_CoursesCopyWithImpl<$Res>;
  @override
  $Res call({CourseId courseId});

  @override
  $CourseIdCopyWith<$Res> get courseId;
}

/// @nodoc
class __$$_CoursesCopyWithImpl<$Res> extends _$CoursesCopyWithImpl<$Res>
    implements _$$_CoursesCopyWith<$Res> {
  __$$_CoursesCopyWithImpl(_$_Courses _value, $Res Function(_$_Courses) _then)
      : super(_value, (v) => _then(v as _$_Courses));

  @override
  _$_Courses get _value => super._value as _$_Courses;

  @override
  $Res call({
    Object? courseId = freezed,
  }) {
    return _then(_$_Courses(
      courseId: courseId == freezed
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as CourseId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Courses implements _Courses {
  const _$_Courses({required this.courseId});

  factory _$_Courses.fromJson(Map<String, dynamic> json) =>
      _$$_CoursesFromJson(json);

  @override
  final CourseId courseId;

  @override
  String toString() {
    return 'Courses(courseId: $courseId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Courses &&
            const DeepCollectionEquality().equals(other.courseId, courseId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(courseId));

  @JsonKey(ignore: true)
  @override
  _$$_CoursesCopyWith<_$_Courses> get copyWith =>
      __$$_CoursesCopyWithImpl<_$_Courses>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CoursesToJson(this);
  }
}

abstract class _Courses implements Courses {
  const factory _Courses({required final CourseId courseId}) = _$_Courses;

  factory _Courses.fromJson(Map<String, dynamic> json) = _$_Courses.fromJson;

  @override
  CourseId get courseId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CoursesCopyWith<_$_Courses> get copyWith =>
      throw _privateConstructorUsedError;
}

CourseId _$CourseIdFromJson(Map<String, dynamic> json) {
  return _CourseId.fromJson(json);
}

/// @nodoc
mixin _$CourseId {
  String get id => throw _privateConstructorUsedError;
  String get swedishName => throw _privateConstructorUsedError;
  String get englishName => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseIdCopyWith<CourseId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseIdCopyWith<$Res> {
  factory $CourseIdCopyWith(CourseId value, $Res Function(CourseId) then) =
      _$CourseIdCopyWithImpl<$Res>;
  $Res call({String id, String swedishName, String englishName, String color});
}

/// @nodoc
class _$CourseIdCopyWithImpl<$Res> implements $CourseIdCopyWith<$Res> {
  _$CourseIdCopyWithImpl(this._value, this._then);

  final CourseId _value;
  // ignore: unused_field
  final $Res Function(CourseId) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? swedishName = freezed,
    Object? englishName = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      swedishName: swedishName == freezed
          ? _value.swedishName
          : swedishName // ignore: cast_nullable_to_non_nullable
              as String,
      englishName: englishName == freezed
          ? _value.englishName
          : englishName // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_CourseIdCopyWith<$Res> implements $CourseIdCopyWith<$Res> {
  factory _$$_CourseIdCopyWith(
          _$_CourseId value, $Res Function(_$_CourseId) then) =
      __$$_CourseIdCopyWithImpl<$Res>;
  @override
  $Res call({String id, String swedishName, String englishName, String color});
}

/// @nodoc
class __$$_CourseIdCopyWithImpl<$Res> extends _$CourseIdCopyWithImpl<$Res>
    implements _$$_CourseIdCopyWith<$Res> {
  __$$_CourseIdCopyWithImpl(
      _$_CourseId _value, $Res Function(_$_CourseId) _then)
      : super(_value, (v) => _then(v as _$_CourseId));

  @override
  _$_CourseId get _value => super._value as _$_CourseId;

  @override
  $Res call({
    Object? id = freezed,
    Object? swedishName = freezed,
    Object? englishName = freezed,
    Object? color = freezed,
  }) {
    return _then(_$_CourseId(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      swedishName: swedishName == freezed
          ? _value.swedishName
          : swedishName // ignore: cast_nullable_to_non_nullable
              as String,
      englishName: englishName == freezed
          ? _value.englishName
          : englishName // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CourseId implements _CourseId {
  const _$_CourseId(
      {required this.id,
      required this.swedishName,
      required this.englishName,
      required this.color});

  factory _$_CourseId.fromJson(Map<String, dynamic> json) =>
      _$$_CourseIdFromJson(json);

  @override
  final String id;
  @override
  final String swedishName;
  @override
  final String englishName;
  @override
  final String color;

  @override
  String toString() {
    return 'CourseId(id: $id, swedishName: $swedishName, englishName: $englishName, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CourseId &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.swedishName, swedishName) &&
            const DeepCollectionEquality()
                .equals(other.englishName, englishName) &&
            const DeepCollectionEquality().equals(other.color, color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(swedishName),
      const DeepCollectionEquality().hash(englishName),
      const DeepCollectionEquality().hash(color));

  @JsonKey(ignore: true)
  @override
  _$$_CourseIdCopyWith<_$_CourseId> get copyWith =>
      __$$_CourseIdCopyWithImpl<_$_CourseId>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CourseIdToJson(this);
  }
}

abstract class _CourseId implements CourseId {
  const factory _CourseId(
      {required final String id,
      required final String swedishName,
      required final String englishName,
      required final String color}) = _$_CourseId;

  factory _CourseId.fromJson(Map<String, dynamic> json) = _$_CourseId.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get swedishName => throw _privateConstructorUsedError;
  @override
  String get englishName => throw _privateConstructorUsedError;
  @override
  String get color => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CourseIdCopyWith<_$_CourseId> get copyWith =>
      throw _privateConstructorUsedError;
}

Day _$DayFromJson(Map<String, dynamic> json) {
  return _Day.fromJson(json);
}

/// @nodoc
mixin _$Day {
  String get name => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get dayOfMonth => throw _privateConstructorUsedError;
  int get dayOfWeek => throw _privateConstructorUsedError;
  int get weekNumber => throw _privateConstructorUsedError;
  List<Event> get events => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DayCopyWith<Day> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayCopyWith<$Res> {
  factory $DayCopyWith(Day value, $Res Function(Day) then) =
      _$DayCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String date,
      int year,
      int month,
      int dayOfMonth,
      int dayOfWeek,
      int weekNumber,
      List<Event> events});
}

/// @nodoc
class _$DayCopyWithImpl<$Res> implements $DayCopyWith<$Res> {
  _$DayCopyWithImpl(this._value, this._then);

  final Day _value;
  // ignore: unused_field
  final $Res Function(Day) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? date = freezed,
    Object? year = freezed,
    Object? month = freezed,
    Object? dayOfMonth = freezed,
    Object? dayOfWeek = freezed,
    Object? weekNumber = freezed,
    Object? events = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      dayOfMonth: dayOfMonth == freezed
          ? _value.dayOfMonth
          : dayOfMonth // ignore: cast_nullable_to_non_nullable
              as int,
      dayOfWeek: dayOfWeek == freezed
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      weekNumber: weekNumber == freezed
          ? _value.weekNumber
          : weekNumber // ignore: cast_nullable_to_non_nullable
              as int,
      events: events == freezed
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>,
    ));
  }
}

/// @nodoc
abstract class _$$_DayCopyWith<$Res> implements $DayCopyWith<$Res> {
  factory _$$_DayCopyWith(_$_Day value, $Res Function(_$_Day) then) =
      __$$_DayCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String date,
      int year,
      int month,
      int dayOfMonth,
      int dayOfWeek,
      int weekNumber,
      List<Event> events});
}

/// @nodoc
class __$$_DayCopyWithImpl<$Res> extends _$DayCopyWithImpl<$Res>
    implements _$$_DayCopyWith<$Res> {
  __$$_DayCopyWithImpl(_$_Day _value, $Res Function(_$_Day) _then)
      : super(_value, (v) => _then(v as _$_Day));

  @override
  _$_Day get _value => super._value as _$_Day;

  @override
  $Res call({
    Object? name = freezed,
    Object? date = freezed,
    Object? year = freezed,
    Object? month = freezed,
    Object? dayOfMonth = freezed,
    Object? dayOfWeek = freezed,
    Object? weekNumber = freezed,
    Object? events = freezed,
  }) {
    return _then(_$_Day(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      dayOfMonth: dayOfMonth == freezed
          ? _value.dayOfMonth
          : dayOfMonth // ignore: cast_nullable_to_non_nullable
              as int,
      dayOfWeek: dayOfWeek == freezed
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      weekNumber: weekNumber == freezed
          ? _value.weekNumber
          : weekNumber // ignore: cast_nullable_to_non_nullable
              as int,
      events: events == freezed
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Day implements _Day {
  const _$_Day(
      {required this.name,
      required this.date,
      required this.year,
      required this.month,
      required this.dayOfMonth,
      required this.dayOfWeek,
      required this.weekNumber,
      required final List<Event> events})
      : _events = events;

  factory _$_Day.fromJson(Map<String, dynamic> json) => _$$_DayFromJson(json);

  @override
  final String name;
  @override
  final String date;
  @override
  final int year;
  @override
  final int month;
  @override
  final int dayOfMonth;
  @override
  final int dayOfWeek;
  @override
  final int weekNumber;
  final List<Event> _events;
  @override
  List<Event> get events {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  String toString() {
    return 'Day(name: $name, date: $date, year: $year, month: $month, dayOfMonth: $dayOfMonth, dayOfWeek: $dayOfWeek, weekNumber: $weekNumber, events: $events)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Day &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.year, year) &&
            const DeepCollectionEquality().equals(other.month, month) &&
            const DeepCollectionEquality()
                .equals(other.dayOfMonth, dayOfMonth) &&
            const DeepCollectionEquality().equals(other.dayOfWeek, dayOfWeek) &&
            const DeepCollectionEquality()
                .equals(other.weekNumber, weekNumber) &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(year),
      const DeepCollectionEquality().hash(month),
      const DeepCollectionEquality().hash(dayOfMonth),
      const DeepCollectionEquality().hash(dayOfWeek),
      const DeepCollectionEquality().hash(weekNumber),
      const DeepCollectionEquality().hash(_events));

  @JsonKey(ignore: true)
  @override
  _$$_DayCopyWith<_$_Day> get copyWith =>
      __$$_DayCopyWithImpl<_$_Day>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DayToJson(this);
  }
}

abstract class _Day implements Day {
  const factory _Day(
      {required final String name,
      required final String date,
      required final int year,
      required final int month,
      required final int dayOfMonth,
      required final int dayOfWeek,
      required final int weekNumber,
      required final List<Event> events}) = _$_Day;

  factory _Day.fromJson(Map<String, dynamic> json) = _$_Day.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get date => throw _privateConstructorUsedError;
  @override
  int get year => throw _privateConstructorUsedError;
  @override
  int get month => throw _privateConstructorUsedError;
  @override
  int get dayOfMonth => throw _privateConstructorUsedError;
  @override
  int get dayOfWeek => throw _privateConstructorUsedError;
  @override
  int get weekNumber => throw _privateConstructorUsedError;
  @override
  List<Event> get events => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DayCopyWith<_$_Day> get copyWith => throw _privateConstructorUsedError;
}

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  DateTime get timeStart => throw _privateConstructorUsedError;
  DateTime get timeEnd => throw _privateConstructorUsedError;
  List<Location> get locations => throw _privateConstructorUsedError;
  List<Teacher> get teachers => throw _privateConstructorUsedError;
  bool get isSpecial => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      String courseId,
      DateTime timeStart,
      DateTime timeEnd,
      List<Location> locations,
      List<Teacher> teachers,
      bool isSpecial});
}

/// @nodoc
class _$EventCopyWithImpl<$Res> implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  final Event _value;
  // ignore: unused_field
  final $Res Function(Event) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? courseId = freezed,
    Object? timeStart = freezed,
    Object? timeEnd = freezed,
    Object? locations = freezed,
    Object? teachers = freezed,
    Object? isSpecial = freezed,
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
      courseId: courseId == freezed
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      timeStart: timeStart == freezed
          ? _value.timeStart
          : timeStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeEnd: timeEnd == freezed
          ? _value.timeEnd
          : timeEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      locations: locations == freezed
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<Location>,
      teachers: teachers == freezed
          ? _value.teachers
          : teachers // ignore: cast_nullable_to_non_nullable
              as List<Teacher>,
      isSpecial: isSpecial == freezed
          ? _value.isSpecial
          : isSpecial // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$_EventCopyWith(_$_Event value, $Res Function(_$_Event) then) =
      __$$_EventCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      String courseId,
      DateTime timeStart,
      DateTime timeEnd,
      List<Location> locations,
      List<Teacher> teachers,
      bool isSpecial});
}

/// @nodoc
class __$$_EventCopyWithImpl<$Res> extends _$EventCopyWithImpl<$Res>
    implements _$$_EventCopyWith<$Res> {
  __$$_EventCopyWithImpl(_$_Event _value, $Res Function(_$_Event) _then)
      : super(_value, (v) => _then(v as _$_Event));

  @override
  _$_Event get _value => super._value as _$_Event;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? courseId = freezed,
    Object? timeStart = freezed,
    Object? timeEnd = freezed,
    Object? locations = freezed,
    Object? teachers = freezed,
    Object? isSpecial = freezed,
  }) {
    return _then(_$_Event(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: courseId == freezed
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      timeStart: timeStart == freezed
          ? _value.timeStart
          : timeStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeEnd: timeEnd == freezed
          ? _value.timeEnd
          : timeEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      locations: locations == freezed
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<Location>,
      teachers: teachers == freezed
          ? _value._teachers
          : teachers // ignore: cast_nullable_to_non_nullable
              as List<Teacher>,
      isSpecial: isSpecial == freezed
          ? _value.isSpecial
          : isSpecial // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Event implements _Event {
  const _$_Event(
      {required this.id,
      required this.title,
      required this.courseId,
      required this.timeStart,
      required this.timeEnd,
      required final List<Location> locations,
      required final List<Teacher> teachers,
      required this.isSpecial})
      : _locations = locations,
        _teachers = teachers;

  factory _$_Event.fromJson(Map<String, dynamic> json) =>
      _$$_EventFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String courseId;
  @override
  final DateTime timeStart;
  @override
  final DateTime timeEnd;
  final List<Location> _locations;
  @override
  List<Location> get locations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  final List<Teacher> _teachers;
  @override
  List<Teacher> get teachers {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teachers);
  }

  @override
  final bool isSpecial;

  @override
  String toString() {
    return 'Event(id: $id, title: $title, courseId: $courseId, timeStart: $timeStart, timeEnd: $timeEnd, locations: $locations, teachers: $teachers, isSpecial: $isSpecial)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Event &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.courseId, courseId) &&
            const DeepCollectionEquality().equals(other.timeStart, timeStart) &&
            const DeepCollectionEquality().equals(other.timeEnd, timeEnd) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            const DeepCollectionEquality().equals(other._teachers, _teachers) &&
            const DeepCollectionEquality().equals(other.isSpecial, isSpecial));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(courseId),
      const DeepCollectionEquality().hash(timeStart),
      const DeepCollectionEquality().hash(timeEnd),
      const DeepCollectionEquality().hash(_locations),
      const DeepCollectionEquality().hash(_teachers),
      const DeepCollectionEquality().hash(isSpecial));

  @JsonKey(ignore: true)
  @override
  _$$_EventCopyWith<_$_Event> get copyWith =>
      __$$_EventCopyWithImpl<_$_Event>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventToJson(this);
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {required final String id,
      required final String title,
      required final String courseId,
      required final DateTime timeStart,
      required final DateTime timeEnd,
      required final List<Location> locations,
      required final List<Teacher> teachers,
      required final bool isSpecial}) = _$_Event;

  factory _Event.fromJson(Map<String, dynamic> json) = _$_Event.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get courseId => throw _privateConstructorUsedError;
  @override
  DateTime get timeStart => throw _privateConstructorUsedError;
  @override
  DateTime get timeEnd => throw _privateConstructorUsedError;
  @override
  List<Location> get locations => throw _privateConstructorUsedError;
  @override
  List<Teacher> get teachers => throw _privateConstructorUsedError;
  @override
  bool get isSpecial => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_EventCopyWith<_$_Event> get copyWith =>
      throw _privateConstructorUsedError;
}

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get building => throw _privateConstructorUsedError;
  String get floor => throw _privateConstructorUsedError;
  String get maxSeats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res>;
  $Res call(
      {String id, String name, String building, String floor, String maxSeats});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res> implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  final Location _value;
  // ignore: unused_field
  final $Res Function(Location) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? building = freezed,
    Object? floor = freezed,
    Object? maxSeats = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      building: building == freezed
          ? _value.building
          : building // ignore: cast_nullable_to_non_nullable
              as String,
      floor: floor == freezed
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String,
      maxSeats: maxSeats == freezed
          ? _value.maxSeats
          : maxSeats // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_LocationCopyWith<$Res> implements $LocationCopyWith<$Res> {
  factory _$$_LocationCopyWith(
          _$_Location value, $Res Function(_$_Location) then) =
      __$$_LocationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id, String name, String building, String floor, String maxSeats});
}

/// @nodoc
class __$$_LocationCopyWithImpl<$Res> extends _$LocationCopyWithImpl<$Res>
    implements _$$_LocationCopyWith<$Res> {
  __$$_LocationCopyWithImpl(
      _$_Location _value, $Res Function(_$_Location) _then)
      : super(_value, (v) => _then(v as _$_Location));

  @override
  _$_Location get _value => super._value as _$_Location;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? building = freezed,
    Object? floor = freezed,
    Object? maxSeats = freezed,
  }) {
    return _then(_$_Location(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      building: building == freezed
          ? _value.building
          : building // ignore: cast_nullable_to_non_nullable
              as String,
      floor: floor == freezed
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String,
      maxSeats: maxSeats == freezed
          ? _value.maxSeats
          : maxSeats // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Location implements _Location {
  const _$_Location(
      {required this.id,
      required this.name,
      required this.building,
      required this.floor,
      required this.maxSeats});

  factory _$_Location.fromJson(Map<String, dynamic> json) =>
      _$$_LocationFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String building;
  @override
  final String floor;
  @override
  final String maxSeats;

  @override
  String toString() {
    return 'Location(id: $id, name: $name, building: $building, floor: $floor, maxSeats: $maxSeats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Location &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.building, building) &&
            const DeepCollectionEquality().equals(other.floor, floor) &&
            const DeepCollectionEquality().equals(other.maxSeats, maxSeats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(building),
      const DeepCollectionEquality().hash(floor),
      const DeepCollectionEquality().hash(maxSeats));

  @JsonKey(ignore: true)
  @override
  _$$_LocationCopyWith<_$_Location> get copyWith =>
      __$$_LocationCopyWithImpl<_$_Location>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationToJson(this);
  }
}

abstract class _Location implements Location {
  const factory _Location(
      {required final String id,
      required final String name,
      required final String building,
      required final String floor,
      required final String maxSeats}) = _$_Location;

  factory _Location.fromJson(Map<String, dynamic> json) = _$_Location.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get building => throw _privateConstructorUsedError;
  @override
  String get floor => throw _privateConstructorUsedError;
  @override
  String get maxSeats => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_LocationCopyWith<_$_Location> get copyWith =>
      throw _privateConstructorUsedError;
}

Teacher _$TeacherFromJson(Map<String, dynamic> json) {
  return _Teacher.fromJson(json);
}

/// @nodoc
mixin _$Teacher {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeacherCopyWith<Teacher> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeacherCopyWith<$Res> {
  factory $TeacherCopyWith(Teacher value, $Res Function(Teacher) then) =
      _$TeacherCopyWithImpl<$Res>;
  $Res call({String id, String firstName, String lastName});
}

/// @nodoc
class _$TeacherCopyWithImpl<$Res> implements $TeacherCopyWith<$Res> {
  _$TeacherCopyWithImpl(this._value, this._then);

  final Teacher _value;
  // ignore: unused_field
  final $Res Function(Teacher) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TeacherCopyWith<$Res> implements $TeacherCopyWith<$Res> {
  factory _$$_TeacherCopyWith(
          _$_Teacher value, $Res Function(_$_Teacher) then) =
      __$$_TeacherCopyWithImpl<$Res>;
  @override
  $Res call({String id, String firstName, String lastName});
}

/// @nodoc
class __$$_TeacherCopyWithImpl<$Res> extends _$TeacherCopyWithImpl<$Res>
    implements _$$_TeacherCopyWith<$Res> {
  __$$_TeacherCopyWithImpl(_$_Teacher _value, $Res Function(_$_Teacher) _then)
      : super(_value, (v) => _then(v as _$_Teacher));

  @override
  _$_Teacher get _value => super._value as _$_Teacher;

  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
  }) {
    return _then(_$_Teacher(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Teacher implements _Teacher {
  const _$_Teacher(
      {required this.id, required this.firstName, required this.lastName});

  factory _$_Teacher.fromJson(Map<String, dynamic> json) =>
      _$$_TeacherFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;

  @override
  String toString() {
    return 'Teacher(id: $id, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Teacher &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName));

  @JsonKey(ignore: true)
  @override
  _$$_TeacherCopyWith<_$_Teacher> get copyWith =>
      __$$_TeacherCopyWithImpl<_$_Teacher>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TeacherToJson(this);
  }
}

abstract class _Teacher implements Teacher {
  const factory _Teacher(
      {required final String id,
      required final String firstName,
      required final String lastName}) = _$_Teacher;

  factory _Teacher.fromJson(Map<String, dynamic> json) = _$_Teacher.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get firstName => throw _privateConstructorUsedError;
  @override
  String get lastName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TeacherCopyWith<_$_Teacher> get copyWith =>
      throw _privateConstructorUsedError;
}
