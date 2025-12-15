import '../../domain/entities/attachment.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/task.dart';

import '../../domain/entities/time_log.dart';
import '../models/attachment_model/attachment_model.dart';
import '../models/subtask_model/subtask_model.dart';
import '../models/task_model/task_model.dart';
import '../models/time_log_model/time_log_model.dart';

extension TaskModelMapper on TaskModel {
  Task toEntity() {
    return Task(
      id: id,
      notificationId: notificationId,
      title: title,
      description: description,
      dueDate: dueDate,
      isCompleted: isCompleted,
      alarmSet: alarmSet,
      remind5MinEarly: remind5MinEarly,
      priority: priority,
      category: category,
      tags: tags,
      recurringType: recurringType,
      recurringInterval: recurringInterval,
      subtasks: subtasks.map((e) => e.toEntity()).toList(),
      totalTimeSpent: totalTimeSpent,
      timeLogs: timeLogs.map((e) => e.toEntity()).toList(),
      timerStartedAt: timerStartedAt,
      isTimerRunning: isTimerRunning,
      attachments: attachments.map((e) => e.toEntity()).toList(),
    );
  }
}

extension TaskEntityMapper on Task {
  TaskModel toModel() {
    return TaskModel(
      id: id,
      notificationId: notificationId,
      title: title,
      description: description,
      dueDate: dueDate,
      isCompleted: isCompleted,
      alarmSet: alarmSet,
      remind5MinEarly: remind5MinEarly,
      priority: priority,
      category: category,
      tags: tags,
      recurringType: recurringType,
      recurringInterval: recurringInterval,
      subtasks: subtasks.map((e) => e.toModel()).toList(),
      totalTimeSpent: totalTimeSpent,
      timeLogs: timeLogs.map((e) => e.toModel()).toList(),
      timerStartedAt: timerStartedAt,
      isTimerRunning: isTimerRunning,
      attachments: attachments.map((e) => e.toModel()).toList(),
    );
  }
}

extension SubtaskModelMapper on SubtaskModel {
  Subtask toEntity() {
    return Subtask(
      id: id,
      title: title,
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
    );
  }
}

extension SubtaskEntityMapper on Subtask {
  SubtaskModel toModel() {
    return SubtaskModel(
      id: id,
      title: title,
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
    );
  }
}

extension TimeLogModelMapper on TimeLogModel {
  TimeLog toEntity() {
    return TimeLog(
      id: id,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
      note: note,
    );
  }
}

extension TimeLogEntityMapper on TimeLog {
  TimeLogModel toModel() {
    return TimeLogModel(
      id: id,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
      note: note,
    );
  }
}

extension AttachmentModelMapper on AttachmentModel {
  Attachment toEntity() {
    return Attachment(
      id: id,
      fileName: fileName,
      filePath: filePath,
      fileType: fileType,
      fileSize: fileSize,
      uploadedAt: uploadedAt,
    );
  }
}

extension AttachmentEntityMapper on Attachment {
  AttachmentModel toModel() {
    return AttachmentModel(
      id: id,
      fileName: fileName,
      filePath: filePath,
      fileType: fileType,
      fileSize: fileSize,
      uploadedAt: uploadedAt,
    );
  }
}


