// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ScheduleData extends DataClass implements Insertable<ScheduleData> {
  final String id;
  final String jsonString;
  final String cachedAt;
  final String generatedUuids;
  ScheduleData(
      {required this.id,
      required this.jsonString,
      required this.cachedAt,
      required this.generatedUuids});
  factory ScheduleData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ScheduleData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      jsonString: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}jsonString'])!,
      cachedAt: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cachedAt'])!,
      generatedUuids: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}generatedUuids'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['jsonString'] = Variable<String>(jsonString);
    map['cachedAt'] = Variable<String>(cachedAt);
    map['generatedUuids'] = Variable<String>(generatedUuids);
    return map;
  }

  ScheduleCompanion toCompanion(bool nullToAbsent) {
    return ScheduleCompanion(
      id: Value(id),
      jsonString: Value(jsonString),
      cachedAt: Value(cachedAt),
      generatedUuids: Value(generatedUuids),
    );
  }

  factory ScheduleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleData(
      id: serializer.fromJson<String>(json['id']),
      jsonString: serializer.fromJson<String>(json['jsonString']),
      cachedAt: serializer.fromJson<String>(json['cachedAt']),
      generatedUuids: serializer.fromJson<String>(json['generatedUuids']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'jsonString': serializer.toJson<String>(jsonString),
      'cachedAt': serializer.toJson<String>(cachedAt),
      'generatedUuids': serializer.toJson<String>(generatedUuids),
    };
  }

  ScheduleData copyWith(
          {String? id,
          String? jsonString,
          String? cachedAt,
          String? generatedUuids}) =>
      ScheduleData(
        id: id ?? this.id,
        jsonString: jsonString ?? this.jsonString,
        cachedAt: cachedAt ?? this.cachedAt,
        generatedUuids: generatedUuids ?? this.generatedUuids,
      );
  @override
  String toString() {
    return (StringBuffer('ScheduleData(')
          ..write('id: $id, ')
          ..write('jsonString: $jsonString, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('generatedUuids: $generatedUuids')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonString, cachedAt, generatedUuids);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleData &&
          other.id == this.id &&
          other.jsonString == this.jsonString &&
          other.cachedAt == this.cachedAt &&
          other.generatedUuids == this.generatedUuids);
}

class ScheduleCompanion extends UpdateCompanion<ScheduleData> {
  final Value<String> id;
  final Value<String> jsonString;
  final Value<String> cachedAt;
  final Value<String> generatedUuids;
  const ScheduleCompanion({
    this.id = const Value.absent(),
    this.jsonString = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.generatedUuids = const Value.absent(),
  });
  ScheduleCompanion.insert({
    required String id,
    required String jsonString,
    required String cachedAt,
    required String generatedUuids,
  })  : id = Value(id),
        jsonString = Value(jsonString),
        cachedAt = Value(cachedAt),
        generatedUuids = Value(generatedUuids);
  static Insertable<ScheduleData> custom({
    Expression<String>? id,
    Expression<String>? jsonString,
    Expression<String>? cachedAt,
    Expression<String>? generatedUuids,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonString != null) 'jsonString': jsonString,
      if (cachedAt != null) 'cachedAt': cachedAt,
      if (generatedUuids != null) 'generatedUuids': generatedUuids,
    });
  }

  ScheduleCompanion copyWith(
      {Value<String>? id,
      Value<String>? jsonString,
      Value<String>? cachedAt,
      Value<String>? generatedUuids}) {
    return ScheduleCompanion(
      id: id ?? this.id,
      jsonString: jsonString ?? this.jsonString,
      cachedAt: cachedAt ?? this.cachedAt,
      generatedUuids: generatedUuids ?? this.generatedUuids,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (jsonString.present) {
      map['jsonString'] = Variable<String>(jsonString.value);
    }
    if (cachedAt.present) {
      map['cachedAt'] = Variable<String>(cachedAt.value);
    }
    if (generatedUuids.present) {
      map['generatedUuids'] = Variable<String>(generatedUuids.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleCompanion(')
          ..write('id: $id, ')
          ..write('jsonString: $jsonString, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('generatedUuids: $generatedUuids')
          ..write(')'))
        .toString();
  }
}

class Schedule extends Table with TableInfo<Schedule, ScheduleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Schedule(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'PRIMARY KEY NOT NULL');
  final VerificationMeta _jsonStringMeta = const VerificationMeta('jsonString');
  late final GeneratedColumn<String?> jsonString = GeneratedColumn<String?>(
      'jsonString', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _cachedAtMeta = const VerificationMeta('cachedAt');
  late final GeneratedColumn<String?> cachedAt = GeneratedColumn<String?>(
      'cachedAt', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _generatedUuidsMeta =
      const VerificationMeta('generatedUuids');
  late final GeneratedColumn<String?> generatedUuids = GeneratedColumn<String?>(
      'generatedUuids', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, jsonString, cachedAt, generatedUuids];
  @override
  String get aliasedName => _alias ?? 'Schedule';
  @override
  String get actualTableName => 'Schedule';
  @override
  VerificationContext validateIntegrity(Insertable<ScheduleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('jsonString')) {
      context.handle(
          _jsonStringMeta,
          jsonString.isAcceptableOrUnknown(
              data['jsonString']!, _jsonStringMeta));
    } else if (isInserting) {
      context.missing(_jsonStringMeta);
    }
    if (data.containsKey('cachedAt')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cachedAt']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    if (data.containsKey('generatedUuids')) {
      context.handle(
          _generatedUuidsMeta,
          generatedUuids.isAcceptableOrUnknown(
              data['generatedUuids']!, _generatedUuidsMeta));
    } else if (isInserting) {
      context.missing(_generatedUuidsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ScheduleData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Schedule createAlias(String alias) {
    return Schedule(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class PreferenceData extends DataClass implements Insertable<PreferenceData> {
  final int viewType;
  final String theme;
  final String defaultSchool;
  final int preferenceId;
  final String defaultSchedule;
  final String notificationTime;
  PreferenceData(
      {required this.viewType,
      required this.theme,
      required this.defaultSchool,
      required this.preferenceId,
      required this.defaultSchedule,
      required this.notificationTime});
  factory PreferenceData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PreferenceData(
      viewType: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}viewType'])!,
      theme: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}theme'])!,
      defaultSchool: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}defaultSchool'])!,
      preferenceId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}preferenceId'])!,
      defaultSchedule: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}defaultSchedule'])!,
      notificationTime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}notificationTime'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['viewType'] = Variable<int>(viewType);
    map['theme'] = Variable<String>(theme);
    map['defaultSchool'] = Variable<String>(defaultSchool);
    map['preferenceId'] = Variable<int>(preferenceId);
    map['defaultSchedule'] = Variable<String>(defaultSchedule);
    map['notificationTime'] = Variable<String>(notificationTime);
    return map;
  }

  PreferencesCompanion toCompanion(bool nullToAbsent) {
    return PreferencesCompanion(
      viewType: Value(viewType),
      theme: Value(theme),
      defaultSchool: Value(defaultSchool),
      preferenceId: Value(preferenceId),
      defaultSchedule: Value(defaultSchedule),
      notificationTime: Value(notificationTime),
    );
  }

  factory PreferenceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreferenceData(
      viewType: serializer.fromJson<int>(json['viewType']),
      theme: serializer.fromJson<String>(json['theme']),
      defaultSchool: serializer.fromJson<String>(json['defaultSchool']),
      preferenceId: serializer.fromJson<int>(json['preferenceId']),
      defaultSchedule: serializer.fromJson<String>(json['defaultSchedule']),
      notificationTime: serializer.fromJson<String>(json['notificationTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'viewType': serializer.toJson<int>(viewType),
      'theme': serializer.toJson<String>(theme),
      'defaultSchool': serializer.toJson<String>(defaultSchool),
      'preferenceId': serializer.toJson<int>(preferenceId),
      'defaultSchedule': serializer.toJson<String>(defaultSchedule),
      'notificationTime': serializer.toJson<String>(notificationTime),
    };
  }

  PreferenceData copyWith(
          {int? viewType,
          String? theme,
          String? defaultSchool,
          int? preferenceId,
          String? defaultSchedule,
          String? notificationTime}) =>
      PreferenceData(
        viewType: viewType ?? this.viewType,
        theme: theme ?? this.theme,
        defaultSchool: defaultSchool ?? this.defaultSchool,
        preferenceId: preferenceId ?? this.preferenceId,
        defaultSchedule: defaultSchedule ?? this.defaultSchedule,
        notificationTime: notificationTime ?? this.notificationTime,
      );
  @override
  String toString() {
    return (StringBuffer('Preference(')
          ..write('viewType: $viewType, ')
          ..write('theme: $theme, ')
          ..write('defaultSchool: $defaultSchool, ')
          ..write('preferenceId: $preferenceId, ')
          ..write('defaultSchedule: $defaultSchedule, ')
          ..write('notificationTime: $notificationTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(viewType, theme, defaultSchool, preferenceId,
      defaultSchedule, notificationTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreferenceData &&
          other.viewType == this.viewType &&
          other.theme == this.theme &&
          other.defaultSchool == this.defaultSchool &&
          other.preferenceId == this.preferenceId &&
          other.defaultSchedule == this.defaultSchedule &&
          other.notificationTime == this.notificationTime);
}

class PreferencesCompanion extends UpdateCompanion<PreferenceData> {
  final Value<int> viewType;
  final Value<String> theme;
  final Value<String> defaultSchool;
  final Value<int> preferenceId;
  final Value<String> defaultSchedule;
  final Value<String> notificationTime;
  const PreferencesCompanion({
    this.viewType = const Value.absent(),
    this.theme = const Value.absent(),
    this.defaultSchool = const Value.absent(),
    this.preferenceId = const Value.absent(),
    this.defaultSchedule = const Value.absent(),
    this.notificationTime = const Value.absent(),
  });
  PreferencesCompanion.insert({
    required int viewType,
    required String theme,
    required String defaultSchool,
    this.preferenceId = const Value.absent(),
    required String defaultSchedule,
    required String notificationTime,
  })  : viewType = Value(viewType),
        theme = Value(theme),
        defaultSchool = Value(defaultSchool),
        defaultSchedule = Value(defaultSchedule),
        notificationTime = Value(notificationTime);
  static Insertable<PreferenceData> custom({
    Expression<int>? viewType,
    Expression<String>? theme,
    Expression<String>? defaultSchool,
    Expression<int>? preferenceId,
    Expression<String>? defaultSchedule,
    Expression<String>? notificationTime,
  }) {
    return RawValuesInsertable({
      if (viewType != null) 'viewType': viewType,
      if (theme != null) 'theme': theme,
      if (defaultSchool != null) 'defaultSchool': defaultSchool,
      if (preferenceId != null) 'preferenceId': preferenceId,
      if (defaultSchedule != null) 'defaultSchedule': defaultSchedule,
      if (notificationTime != null) 'notificationTime': notificationTime,
    });
  }

  PreferencesCompanion copyWith(
      {Value<int>? viewType,
      Value<String>? theme,
      Value<String>? defaultSchool,
      Value<int>? preferenceId,
      Value<String>? defaultSchedule,
      Value<String>? notificationTime}) {
    return PreferencesCompanion(
      viewType: viewType ?? this.viewType,
      theme: theme ?? this.theme,
      defaultSchool: defaultSchool ?? this.defaultSchool,
      preferenceId: preferenceId ?? this.preferenceId,
      defaultSchedule: defaultSchedule ?? this.defaultSchedule,
      notificationTime: notificationTime ?? this.notificationTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (viewType.present) {
      map['viewType'] = Variable<int>(viewType.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    if (defaultSchool.present) {
      map['defaultSchool'] = Variable<String>(defaultSchool.value);
    }
    if (preferenceId.present) {
      map['preferenceId'] = Variable<int>(preferenceId.value);
    }
    if (defaultSchedule.present) {
      map['defaultSchedule'] = Variable<String>(defaultSchedule.value);
    }
    if (notificationTime.present) {
      map['notificationTime'] = Variable<String>(notificationTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesCompanion(')
          ..write('viewType: $viewType, ')
          ..write('theme: $theme, ')
          ..write('defaultSchool: $defaultSchool, ')
          ..write('preferenceId: $preferenceId, ')
          ..write('defaultSchedule: $defaultSchedule, ')
          ..write('notificationTime: $notificationTime')
          ..write(')'))
        .toString();
  }
}

class Preferences extends Table with TableInfo<Preferences, PreferenceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Preferences(this.attachedDatabase, [this._alias]);
  final VerificationMeta _viewTypeMeta = const VerificationMeta('viewType');
  late final GeneratedColumn<int?> viewType = GeneratedColumn<int?>(
      'viewType', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _themeMeta = const VerificationMeta('theme');
  late final GeneratedColumn<String?> theme = GeneratedColumn<String?>(
      'theme', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _defaultSchoolMeta =
      const VerificationMeta('defaultSchool');
  late final GeneratedColumn<String?> defaultSchool = GeneratedColumn<String?>(
      'defaultSchool', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _preferenceIdMeta =
      const VerificationMeta('preferenceId');
  late final GeneratedColumn<int?> preferenceId = GeneratedColumn<int?>(
      'preferenceId', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY NOT NULL');
  final VerificationMeta _defaultScheduleMeta =
      const VerificationMeta('defaultSchedule');
  late final GeneratedColumn<String?> defaultSchedule =
      GeneratedColumn<String?>('defaultSchedule', aliasedName, false,
          type: const StringType(),
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  final VerificationMeta _notificationTimeMeta =
      const VerificationMeta('notificationTime');
  late final GeneratedColumn<String?> notificationTime =
      GeneratedColumn<String?>('notificationTime', aliasedName, false,
          type: const StringType(),
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [
        viewType,
        theme,
        defaultSchool,
        preferenceId,
        defaultSchedule,
        notificationTime
      ];
  @override
  String get aliasedName => _alias ?? 'Preferences';
  @override
  String get actualTableName => 'Preferences';
  @override
  VerificationContext validateIntegrity(Insertable<PreferenceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('viewType')) {
      context.handle(_viewTypeMeta,
          viewType.isAcceptableOrUnknown(data['viewType']!, _viewTypeMeta));
    } else if (isInserting) {
      context.missing(_viewTypeMeta);
    }
    if (data.containsKey('theme')) {
      context.handle(
          _themeMeta, theme.isAcceptableOrUnknown(data['theme']!, _themeMeta));
    } else if (isInserting) {
      context.missing(_themeMeta);
    }
    if (data.containsKey('defaultSchool')) {
      context.handle(
          _defaultSchoolMeta,
          defaultSchool.isAcceptableOrUnknown(
              data['defaultSchool']!, _defaultSchoolMeta));
    } else if (isInserting) {
      context.missing(_defaultSchoolMeta);
    }
    if (data.containsKey('preferenceId')) {
      context.handle(
          _preferenceIdMeta,
          preferenceId.isAcceptableOrUnknown(
              data['preferenceId']!, _preferenceIdMeta));
    }
    if (data.containsKey('defaultSchedule')) {
      context.handle(
          _defaultScheduleMeta,
          defaultSchedule.isAcceptableOrUnknown(
              data['defaultSchedule']!, _defaultScheduleMeta));
    } else if (isInserting) {
      context.missing(_defaultScheduleMeta);
    }
    if (data.containsKey('notificationTime')) {
      context.handle(
          _notificationTimeMeta,
          notificationTime.isAcceptableOrUnknown(
              data['notificationTime']!, _notificationTimeMeta));
    } else if (isInserting) {
      context.missing(_notificationTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {preferenceId};
  @override
  PreferenceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PreferenceData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Preferences createAlias(String alias) {
    return Preferences(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final Schedule schedule = Schedule(this);
  late final Preferences preferences = Preferences(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [schedule, preferences];
}
