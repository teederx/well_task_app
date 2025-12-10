import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/models/task_model/task_model.dart';
import '../../../../../utils/config/alarms_services.dart';
import '../../../../../utils/config/show_confirm_dialog.dart';
import '../../../../providers/tasks_providers/task_list/task_list_provider.dart';
import '../../task_page/task_page.dart';
import '../main_screen.dart';
import 'all_tasks_tile.dart';
import 'empty_state_widget.dart';
import 'show_custom_dialog.dart';
import 'task_formats.dart';
import 'tile_animation.dart';

final notificationService = AlarmServicesImpl();

class TodaysTasks extends ConsumerWidget {
  const TodaysTasks({super.key, required this.tasksList});
  final List<TaskModel> tasksList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTasks = tasksForToday(tasksList);

    if (filteredTasks.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.wb_sunny,
        iconColor: Colors.orange,
        iconSize: 100.sp,
        title: 'No Tasks for Today',
        subtitle: 'Enjoy your free day or create a new task to stay productive',
        buttonText: 'Add Task',
        onButtonPressed: () {
          showCustomDialog(
            context: context,
            barrierLabel: 'Add Task',
            child: TaskPage(pageType: PageType.addTask),
          );
        },
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredTasks.length,
      separatorBuilder: (_, __) => 10.verticalSpace,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        return TilesAnimation(
          index: index,
          child: AllTasksTile(
            id: task.id,
            title: task.title,
            description: task.description ?? '',
            dateTime: task.dueDate,
            isCompleted: task.isCompleted,
            priority: task.priority,
            onTap: () {
              HapticFeedback.lightImpact();
              ref.read(taskListProvider.notifier).toggleComplete(id: task.id);
            },
            handleMenuSelection: (String value) {
              if (value == 'view') {
                showCustomDialog(
                  context: context,
                  barrierLabel: 'View Task',
                  child: TaskPage(pageType: PageType.viewTask, id: task.id),
                );
              } else if (value == 'delete') {
                showConfirmDialog(
                  context: context,
                  title: 'Delete Task',
                  message: 'Are you sure you want to delete this task?',
                  onYes: () {
                    HapticFeedback.mediumImpact();
                    ref.read(taskListProvider.notifier).removeTask(id: task.id);
                    notificationService.cancelTaskNotification(
                      notificationId: task.notificationId,
                      dateTime: task.dueDate,
                      title: task.title,
                      context: context,
                    );
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        content: const Text('Task deleted successfully'),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
