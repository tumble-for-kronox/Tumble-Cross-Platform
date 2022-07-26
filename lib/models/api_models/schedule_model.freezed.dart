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
  $Res call({String cachedAt, String id, List<Day> days});
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
    ));
  }
}

/// @nodoc
abstract class _$$_ScheduleModelCopyWith<$Res>
    implements $ScheduleModelCopyWith<$Res> {
  factory _$$_ScheduleModelCopyWith(
          _$_ScheduleModel value, $Res Function(_$_ScheduleModel) then) =
      __$$_ScheduleModelCopyWithImpl<$Res>;
  @override
  $Res call({String cachedAt, String id, List<Day> days});
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScheduleModel implements _ScheduleModel {
  const _$_ScheduleModel(
      {required this.cachedAt, required this.id, required final List<Day> days})
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
  String toString() {
    return 'ScheduleModel(cachedAt: $cachedAt, id: $id, days: $days)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScheduleModel &&
            const DeepCollectionEquality().equals(other.cachedAt, cachedAt) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other._days, _days));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(cachedAt),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(_days));

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
      required final List<Day> days}) = _$_ScheduleModel;

  factory _ScheduleModel.fromJson(Map<String, dynamic> json) =
      _$_ScheduleModel.fromJson;

  @override
  String get cachedAt => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  List<Day> get days => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ScheduleModelCopyWith<_$_ScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Day _$DayFromJson(Map<String, dynamic> json) {
  return _Day.fromJson(json);
}

/// @nodoc
mixin _$Day {
  String get name => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  DateTime get isoString => throw _privateConstructorUsedError;
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
      DateTime isoString,
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
    Object? isoString = freezed,
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
      isoString: isoString == freezed
          ? _value.isoString
          : isoString // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      DateTime isoString,
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
    Object? isoString = freezed,
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
      isoString: isoString == freezed
          ? _value.isoString
          : isoString // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      required this.isoString,
      required this.weekNumber,
      required final List<Event> events})
      : _events = events;

  factory _$_Day.fromJson(Map<String, dynamic> json) => _$$_DayFromJson(json);

  @override
  final String name;
  @override
  final String date;
  @override
  final DateTime isoString;
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
    return 'Day(name: $name, date: $date, isoString: $isoString, weekNumber: $weekNumber, events: $events)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Day &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.isoString, isoString) &&
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
      const DeepCollectionEquality().hash(isoString),
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
      required final DateTime isoString,
      required final int weekNumber,
      required final List<Event> events}) = _$_Day;

  factory _Day.fromJson(Map<String, dynamic> json) = _$_Day.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get date => throw _privateConstructorUsedError;
  @override
  DateTime get isoString => throw _privateConstructorUsedError;
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
  Course get course => throw _privateConstructorUsedError;
  DateTime get timeStart => throw _privateConstructorUsedError;
  DateTime get timeEnd => throw _privateConstructorUsedError;
  List<Location> get locations => throw _privateConstructorUsedError;
  List<Teacher> get teachers => throw _privateConstructorUsedError;
  bool get isSpecial => throw _privateConstructorUsedError;
  DateTime get lastModified => throw _privateConstructorUsedError;

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
      Course course,
      DateTime timeStart,
      DateTime timeEnd,
      List<Location> locations,
      List<Teacher> teachers,
      bool isSpecial,
      DateTime lastModified});

  $CourseCopyWith<$Res> get course;
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
    Object? course = freezed,
    Object? timeStart = freezed,
    Object? timeEnd = freezed,
    Object? locations = freezed,
    Object? teachers = freezed,
    Object? isSpecial = freezed,
    Object? lastModified = freezed,
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
      course: course == freezed
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as Course,
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
      lastModified: lastModified == freezed
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  @override
  $CourseCopyWith<$Res> get course {
    return $CourseCopyWith<$Res>(_value.course, (value) {
      return _then(_value.copyWith(course: value));
    });
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
      Course course,
      DateTime timeStart,
      DateTime timeEnd,
      List<Location> locations,
      List<Teacher> teachers,
      bool isSpecial,
      DateTime lastModified});

  @override
  $CourseCopyWith<$Res> get course;
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
    Object? course = freezed,
    Object? timeStart = freezed,
    Object? timeEnd = freezed,
    Object? locations = freezed,
    Object? teachers = freezed,
    Object? isSpecial = freezed,
    Object? lastModified = freezed,
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
      course: course == freezed
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as Course,
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
      lastModified: lastModified == freezed
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Event implements _Event {
  const _$_Event(
      {required this.id,
      required this.title,
      required this.course,
      required this.timeStart,
      required this.timeEnd,
      required final List<Location> locations,
      required final List<Teacher> teachers,
      required this.isSpecial,
      required this.lastModified})
      : _locations = locations,
        _teachers = teachers;

  factory _$_Event.fromJson(Map<String, dynamic> json) =>
      _$$_EventFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final Course course;
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
  final DateTime lastModified;

  @override
  String toString() {
    return 'Event(id: $id, title: $title, course: $course, timeStart: $timeStart, timeEnd: $timeEnd, locations: $locations, teachers: $teachers, isSpecial: $isSpecial, lastModified: $lastModified)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Event &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.course, course) &&
            const DeepCollectionEquality().equals(other.timeStart, timeStart) &&
            const DeepCollectionEquality().equals(other.timeEnd, timeEnd) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            const DeepCollectionEquality().equals(other._teachers, _teachers) &&
            const DeepCollectionEquality().equals(other.isSpecial, isSpecial) &&
            const DeepCollectionEquality()
                .equals(other.lastModified, lastModified));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(course),
      const DeepCollectionEquality().hash(timeStart),
      const DeepCollectionEquality().hash(timeEnd),
      const DeepCollectionEquality().hash(_locations),
      const DeepCollectionEquality().hash(_teachers),
      const DeepCollectionEquality().hash(isSpecial),
      const DeepCollectionEquality().hash(lastModified));

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
      required final Course course,
      required final DateTime timeStart,
      required final DateTime timeEnd,
      required final List<Location> locations,
      required final List<Teacher> teachers,
      required final bool isSpecial,
      required final DateTime lastModified}) = _$_Event;

  factory _Event.fromJson(Map<String, dynamic> json) = _$_Event.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  Course get course => throw _privateConstructorUsedError;
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
  DateTime get lastModified => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_EventCopyWith<_$_Event> get copyWith =>
      throw _privateConstructorUsedError;
}

Course _$CourseFromJson(Map<String, dynamic> json) {
  return _Course.fromJson(json);
}

/// @nodoc
mixin _$Course {
  String get id => throw _privateConstructorUsedError;
  String get swedishName => throw _privateConstructorUsedError;
  String get englishName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res>;
  $Res call({String id, String swedishName, String englishName});
}

/// @nodoc
class _$CourseCopyWithImpl<$Res> implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  final Course _value;
  // ignore: unused_field
  final $Res Function(Course) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? swedishName = freezed,
    Object? englishName = freezed,
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
    ));
  }
}

/// @nodoc
abstract class _$$_CourseCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$$_CourseCopyWith(_$_Course value, $Res Function(_$_Course) then) =
      __$$_CourseCopyWithImpl<$Res>;
  @override
  $Res call({String id, String swedishName, String englishName});
}

/// @nodoc
class __$$_CourseCopyWithImpl<$Res> extends _$CourseCopyWithImpl<$Res>
    implements _$$_CourseCopyWith<$Res> {
  __$$_CourseCopyWithImpl(_$_Course _value, $Res Function(_$_Course) _then)
      : super(_value, (v) => _then(v as _$_Course));

  @override
  _$_Course get _value => super._value as _$_Course;

  @override
  $Res call({
    Object? id = freezed,
    Object? swedishName = freezed,
    Object? englishName = freezed,
  }) {
    return _then(_$_Course(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Course implements _Course {
  const _$_Course(
      {required this.id, required this.swedishName, required this.englishName});

  factory _$_Course.fromJson(Map<String, dynamic> json) =>
      _$$_CourseFromJson(json);

  @override
  final String id;
  @override
  final String swedishName;
  @override
  final String englishName;

  @override
  String toString() {
    return 'Course(id: $id, swedishName: $swedishName, englishName: $englishName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Course &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.swedishName, swedishName) &&
            const DeepCollectionEquality()
                .equals(other.englishName, englishName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(swedishName),
      const DeepCollectionEquality().hash(englishName));

  @JsonKey(ignore: true)
  @override
  _$$_CourseCopyWith<_$_Course> get copyWith =>
      __$$_CourseCopyWithImpl<_$_Course>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CourseToJson(this);
  }
}

abstract class _Course implements Course {
  const factory _Course(
      {required final String id,
      required final String swedishName,
      required final String englishName}) = _$_Course;

  factory _Course.fromJson(Map<String, dynamic> json) = _$_Course.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get swedishName => throw _privateConstructorUsedError;
  @override
  String get englishName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CourseCopyWith<_$_Course> get copyWith =>
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
  int get maxSeats => throw _privateConstructorUsedError;

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
      {String id, String name, String building, String floor, int maxSeats});
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
              as int,
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
      {String id, String name, String building, String floor, int maxSeats});
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
              as int,
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
  final int maxSeats;

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
      required final int maxSeats}) = _$_Location;

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
  int get maxSeats => throw _privateConstructorUsedError;
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
