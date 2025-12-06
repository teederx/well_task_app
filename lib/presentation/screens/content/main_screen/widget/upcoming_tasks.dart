import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/utils/constants/app_theme.dart';

import '../../../../../data/models/task_model/task_model.dart';
import '../../../../../utils/config/alarms_services.dart';
import '../../../../../utils/config/show_confirm_dialog.dart';
import '../../../../providers/tasks_providers/task_list/task_list_provider.dart';
import '../../task_page/task_page.dart';
import '../main_screen.dart';
import 'empty_state_widget.dart';
import 'show_custom_dialog.dart';
import 'task_formats.dart';
import 'tile_animation.dart';
import 'upcoming_task_tile.dart';

class UpcomingTasks extends ConsumerWidget {
  const UpcomingTasks({super.key, required this.tasksList});
  final List<TaskModel> tasksList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingTasks = getUpcomingTasks(tasksList);

    if (upcomingTasks.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.calendar_today,
        iconColor: AppTheme.purple,
        iconSize: 100.sp,
        title: 'All Caught Up!',
        subtitle: 'You have no upcoming tasks. Take a break or plan ahead!',
      );
    }

    return Column(
      children: List.generate(
        upcomingTasks.length < 3 ? upcomingTasks.length : 3,
        (index) {
          final task = upcomingTasks[index];
          return TilesAnimation(
            index: index,
            child: UpcomingTaskTile(
              id: task.id,
              title: task.title,
              description: task.description ?? '',
              dateTime: task.dueDate,
              priority: task.priority,
              onTap: () {
                showCustomDialog(
                  context: context,
                  child: TaskPage(pageType: PageType.viewTask, id: task.id),
                  barrierLabel: 'View Task',
                );
              },
              onComplete: () {
                HapticFeedback.lightImpact();
                ref.read(taskListProvider.notifier).toggleComplete(id: task.id);
              },
              onDelete: () {
                showConfirmDialog(
                  context: context,
                  title: 'Delete Task',
                  message: 'Are you sure you want to delete this task?',
                  onYes: () {
                    HapticFeedback.mediumImpact();
                    ref.read(taskListProvider.notifier).removeTask(id: task.id);
                    AlarmServicesImpl().cancelTaskNotification(
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
              },
            ),
          );
        },
      ),
    );
  }
}
