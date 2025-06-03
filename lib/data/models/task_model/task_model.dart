import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

const Uuid uuid = Uuid();

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required int notificationId,
    required String title,
    String? description,
    required DateTime dueDate,
    @Default(false) bool isCompleted,
    @Default(false) bool alarmSet,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  factory TaskModel.createTask({
    required String id,
    required String title,
    required int notificationId,
    String? description,
    required DateTime dueDate,
    bool alarmSet = false,
  }) {
    return TaskModel(
      id: id, // generate the uuid here
      notificationId: notificationId,
      title: title,
      description: description,
      dueDate: dueDate,
      alarmSet: alarmSet,
    );
  }
}

// ✅ Helper function outside
