// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskModel {

 String get id; int get notificationId; String get title; String? get description; DateTime get dueDate; bool get isCompleted; bool get alarmSet; bool get remind5MinEarly; TaskPriority get priority; TaskCategory get category; List<String> get tags; RecurringType get recurringType; int get recurringInterval; List<SubtaskModel> get subtasks; int get totalTimeSpent; List<TimeLogModel> get timeLogs; DateTime? get timerStartedAt; bool get isTimerRunning; List<AttachmentModel> get attachments;
/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskModelCopyWith<TaskModel> get copyWith => _$TaskModelCopyWithImpl<TaskModel>(this as TaskModel, _$identity);

  /// Serializes this TaskModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.alarmSet, alarmSet) || other.alarmSet == alarmSet)&&(identical(other.remind5MinEarly, remind5MinEarly) || other.remind5MinEarly == remind5MinEarly)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.recurringType, recurringType) || other.recurringType == recurringType)&&(identical(other.recurringInterval, recurringInterval) || other.recurringInterval == recurringInterval)&&const DeepCollectionEquality().equals(other.subtasks, subtasks)&&(identical(other.totalTimeSpent, totalTimeSpent) || other.totalTimeSpent == totalTimeSpent)&&const DeepCollectionEquality().equals(other.timeLogs, timeLogs)&&(identical(other.timerStartedAt, timerStartedAt) || other.timerStartedAt == timerStartedAt)&&(identical(other.isTimerRunning, isTimerRunning) || other.isTimerRunning == isTimerRunning)&&const DeepCollectionEquality().equals(other.attachments, attachments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,notificationId,title,description,dueDate,isCompleted,alarmSet,remind5MinEarly,priority,category,const DeepCollectionEquality().hash(tags),recurringType,recurringInterval,const DeepCollectionEquality().hash(subtasks),totalTimeSpent,const DeepCollectionEquality().hash(timeLogs),timerStartedAt,isTimerRunning,const DeepCollectionEquality().hash(attachments)]);

@override
String toString() {
  return 'TaskModel(id: $id, notificationId: $notificationId, title: $title, description: $description, dueDate: $dueDate, isCompleted: $isCompleted, alarmSet: $alarmSet, remind5MinEarly: $remind5MinEarly, priority: $priority, category: $category, tags: $tags, recurringType: $recurringType, recurringInterval: $recurringInterval, subtasks: $subtasks, totalTimeSpent: $totalTimeSpent, timeLogs: $timeLogs, timerStartedAt: $timerStartedAt, isTimerRunning: $isTimerRunning, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class $TaskModelCopyWith<$Res>  {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) _then) = _$TaskModelCopyWithImpl;
@useResult
$Res call({
 String id, int notificationId, String title, String? description, DateTime dueDate, bool isCompleted, bool alarmSet, bool remind5MinEarly, TaskPriority priority, TaskCategory category, List<String> tags, RecurringType recurringType, int recurringInterval, List<SubtaskModel> subtasks, int totalTimeSpent, List<TimeLogModel> timeLogs, DateTime? timerStartedAt, bool isTimerRunning, List<AttachmentModel> attachments
});




}
/// @nodoc
class _$TaskModelCopyWithImpl<$Res>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._self, this._then);

  final TaskModel _self;
  final $Res Function(TaskModel) _then;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? notificationId = null,Object? title = null,Object? description = freezed,Object? dueDate = null,Object? isCompleted = null,Object? alarmSet = null,Object? remind5MinEarly = null,Object? priority = null,Object? category = null,Object? tags = null,Object? recurringType = null,Object? recurringInterval = null,Object? subtasks = null,Object? totalTimeSpent = null,Object? timeLogs = null,Object? timerStartedAt = freezed,Object? isTimerRunning = null,Object? attachments = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,alarmSet: null == alarmSet ? _self.alarmSet : alarmSet // ignore: cast_nullable_to_non_nullable
as bool,remind5MinEarly: null == remind5MinEarly ? _self.remind5MinEarly : remind5MinEarly // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TaskCategory,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,recurringType: null == recurringType ? _self.recurringType : recurringType // ignore: cast_nullable_to_non_nullable
as RecurringType,recurringInterval: null == recurringInterval ? _self.recurringInterval : recurringInterval // ignore: cast_nullable_to_non_nullable
as int,subtasks: null == subtasks ? _self.subtasks : subtasks // ignore: cast_nullable_to_non_nullable
as List<SubtaskModel>,totalTimeSpent: null == totalTimeSpent ? _self.totalTimeSpent : totalTimeSpent // ignore: cast_nullable_to_non_nullable
as int,timeLogs: null == timeLogs ? _self.timeLogs : timeLogs // ignore: cast_nullable_to_non_nullable
as List<TimeLogModel>,timerStartedAt: freezed == timerStartedAt ? _self.timerStartedAt : timerStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isTimerRunning: null == isTimerRunning ? _self.isTimerRunning : isTimerRunning // ignore: cast_nullable_to_non_nullable
as bool,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<AttachmentModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskModel].
extension TaskModelPatterns on TaskModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int notificationId,  String title,  String? description,  DateTime dueDate,  bool isCompleted,  bool alarmSet,  bool remind5MinEarly,  TaskPriority priority,  TaskCategory category,  List<String> tags,  RecurringType recurringType,  int recurringInterval,  List<SubtaskModel> subtasks,  int totalTimeSpent,  List<TimeLogModel> timeLogs,  DateTime? timerStartedAt,  bool isTimerRunning,  List<AttachmentModel> attachments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that.id,_that.notificationId,_that.title,_that.description,_that.dueDate,_that.isCompleted,_that.alarmSet,_that.remind5MinEarly,_that.priority,_that.category,_that.tags,_that.recurringType,_that.recurringInterval,_that.subtasks,_that.totalTimeSpent,_that.timeLogs,_that.timerStartedAt,_that.isTimerRunning,_that.attachments);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int notificationId,  String title,  String? description,  DateTime dueDate,  bool isCompleted,  bool alarmSet,  bool remind5MinEarly,  TaskPriority priority,  TaskCategory category,  List<String> tags,  RecurringType recurringType,  int recurringInterval,  List<SubtaskModel> subtasks,  int totalTimeSpent,  List<TimeLogModel> timeLogs,  DateTime? timerStartedAt,  bool isTimerRunning,  List<AttachmentModel> attachments)  $default,) {final _that = this;
switch (_that) {
case _TaskModel():
return $default(_that.id,_that.notificationId,_that.title,_that.description,_that.dueDate,_that.isCompleted,_that.alarmSet,_that.remind5MinEarly,_that.priority,_that.category,_that.tags,_that.recurringType,_that.recurringInterval,_that.subtasks,_that.totalTimeSpent,_that.timeLogs,_that.timerStartedAt,_that.isTimerRunning,_that.attachments);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int notificationId,  String title,  String? description,  DateTime dueDate,  bool isCompleted,  bool alarmSet,  bool remind5MinEarly,  TaskPriority priority,  TaskCategory category,  List<String> tags,  RecurringType recurringType,  int recurringInterval,  List<SubtaskModel> subtasks,  int totalTimeSpent,  List<TimeLogModel> timeLogs,  DateTime? timerStartedAt,  bool isTimerRunning,  List<AttachmentModel> attachments)?  $default,) {final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that.id,_that.notificationId,_that.title,_that.description,_that.dueDate,_that.isCompleted,_that.alarmSet,_that.remind5MinEarly,_that.priority,_that.category,_that.tags,_that.recurringType,_that.recurringInterval,_that.subtasks,_that.totalTimeSpent,_that.timeLogs,_that.timerStartedAt,_that.isTimerRunning,_that.attachments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskModel implements TaskModel {
  const _TaskModel({required this.id, required this.notificationId, required this.title, this.description, required this.dueDate, this.isCompleted = false, this.alarmSet = false, this.remind5MinEarly = false, this.priority = TaskPriority.medium, this.category = TaskCategory.other, final  List<String> tags = const [], this.recurringType = RecurringType.none, this.recurringInterval = 1, final  List<SubtaskModel> subtasks = const [], this.totalTimeSpent = 0, final  List<TimeLogModel> timeLogs = const [], this.timerStartedAt, this.isTimerRunning = false, final  List<AttachmentModel> attachments = const []}): _tags = tags,_subtasks = subtasks,_timeLogs = timeLogs,_attachments = attachments;
  factory _TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

@override final  String id;
@override final  int notificationId;
@override final  String title;
@override final  String? description;
@override final  DateTime dueDate;
@override@JsonKey() final  bool isCompleted;
@override@JsonKey() final  bool alarmSet;
@override@JsonKey() final  bool remind5MinEarly;
@override@JsonKey() final  TaskPriority priority;
@override@JsonKey() final  TaskCategory category;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  RecurringType recurringType;
@override@JsonKey() final  int recurringInterval;
 final  List<SubtaskModel> _subtasks;
@override@JsonKey() List<SubtaskModel> get subtasks {
  if (_subtasks is EqualUnmodifiableListView) return _subtasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subtasks);
}

@override@JsonKey() final  int totalTimeSpent;
 final  List<TimeLogModel> _timeLogs;
@override@JsonKey() List<TimeLogModel> get timeLogs {
  if (_timeLogs is EqualUnmodifiableListView) return _timeLogs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeLogs);
}

@override final  DateTime? timerStartedAt;
@override@JsonKey() final  bool isTimerRunning;
 final  List<AttachmentModel> _attachments;
@override@JsonKey() List<AttachmentModel> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}


/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskModelCopyWith<_TaskModel> get copyWith => __$TaskModelCopyWithImpl<_TaskModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.alarmSet, alarmSet) || other.alarmSet == alarmSet)&&(identical(other.remind5MinEarly, remind5MinEarly) || other.remind5MinEarly == remind5MinEarly)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.recurringType, recurringType) || other.recurringType == recurringType)&&(identical(other.recurringInterval, recurringInterval) || other.recurringInterval == recurringInterval)&&const DeepCollectionEquality().equals(other._subtasks, _subtasks)&&(identical(other.totalTimeSpent, totalTimeSpent) || other.totalTimeSpent == totalTimeSpent)&&const DeepCollectionEquality().equals(other._timeLogs, _timeLogs)&&(identical(other.timerStartedAt, timerStartedAt) || other.timerStartedAt == timerStartedAt)&&(identical(other.isTimerRunning, isTimerRunning) || other.isTimerRunning == isTimerRunning)&&const DeepCollectionEquality().equals(other._attachments, _attachments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,notificationId,title,description,dueDate,isCompleted,alarmSet,remind5MinEarly,priority,category,const DeepCollectionEquality().hash(_tags),recurringType,recurringInterval,const DeepCollectionEquality().hash(_subtasks),totalTimeSpent,const DeepCollectionEquality().hash(_timeLogs),timerStartedAt,isTimerRunning,const DeepCollectionEquality().hash(_attachments)]);

@override
String toString() {
  return 'TaskModel(id: $id, notificationId: $notificationId, title: $title, description: $description, dueDate: $dueDate, isCompleted: $isCompleted, alarmSet: $alarmSet, remind5MinEarly: $remind5MinEarly, priority: $priority, category: $category, tags: $tags, recurringType: $recurringType, recurringInterval: $recurringInterval, subtasks: $subtasks, totalTimeSpent: $totalTimeSpent, timeLogs: $timeLogs, timerStartedAt: $timerStartedAt, isTimerRunning: $isTimerRunning, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class _$TaskModelCopyWith<$Res> implements $TaskModelCopyWith<$Res> {
  factory _$TaskModelCopyWith(_TaskModel value, $Res Function(_TaskModel) _then) = __$TaskModelCopyWithImpl;
@override @useResult
$Res call({
 String id, int notificationId, String title, String? description, DateTime dueDate, bool isCompleted, bool alarmSet, bool remind5MinEarly, TaskPriority priority, TaskCategory category, List<String> tags, RecurringType recurringType, int recurringInterval, List<SubtaskModel> subtasks, int totalTimeSpent, List<TimeLogModel> timeLogs, DateTime? timerStartedAt, bool isTimerRunning, List<AttachmentModel> attachments
});




}
/// @nodoc
class __$TaskModelCopyWithImpl<$Res>
    implements _$TaskModelCopyWith<$Res> {
  __$TaskModelCopyWithImpl(this._self, this._then);

  final _TaskModel _self;
  final $Res Function(_TaskModel) _then;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? notificationId = null,Object? title = null,Object? description = freezed,Object? dueDate = null,Object? isCompleted = null,Object? alarmSet = null,Object? remind5MinEarly = null,Object? priority = null,Object? category = null,Object? tags = null,Object? recurringType = null,Object? recurringInterval = null,Object? subtasks = null,Object? totalTimeSpent = null,Object? timeLogs = null,Object? timerStartedAt = freezed,Object? isTimerRunning = null,Object? attachments = null,}) {
  return _then(_TaskModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,alarmSet: null == alarmSet ? _self.alarmSet : alarmSet // ignore: cast_nullable_to_non_nullable
as bool,remind5MinEarly: null == remind5MinEarly ? _self.remind5MinEarly : remind5MinEarly // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TaskCategory,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,recurringType: null == recurringType ? _self.recurringType : recurringType // ignore: cast_nullable_to_non_nullable
as RecurringType,recurringInterval: null == recurringInterval ? _self.recurringInterval : recurringInterval // ignore: cast_nullable_to_non_nullable
as int,subtasks: null == subtasks ? _self._subtasks : subtasks // ignore: cast_nullable_to_non_nullable
as List<SubtaskModel>,totalTimeSpent: null == totalTimeSpent ? _self.totalTimeSpent : totalTimeSpent // ignore: cast_nullable_to_non_nullable
as int,timeLogs: null == timeLogs ? _self._timeLogs : timeLogs // ignore: cast_nullable_to_non_nullable
as List<TimeLogModel>,timerStartedAt: freezed == timerStartedAt ? _self.timerStartedAt : timerStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isTimerRunning: null == isTimerRunning ? _self.isTimerRunning : isTimerRunning // ignore: cast_nullable_to_non_nullable
as bool,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<AttachmentModel>,
  ));
}


}

// dart format on
