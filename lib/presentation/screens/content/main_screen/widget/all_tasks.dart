import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/presentation/screens/content/task_page/task_page.dart';

import '../../../../../data/models/task_model/task_model.dart';
import '../../../../../utils/config/alarms_services.dart';
import '../../../../../utils/config/formatted_date_time.dart';
import '../../../../../utils/config/show_confirm_dialog.dart';
import '../../../../../utils/constants/app_theme.dart';
import '../../../../providers/tasks_providers/selected_date/selected_date_provider.dart';
import '../../../../providers/tasks_providers/task_list/task_list_provider.dart';
import '../main_screen.dart';
import 'all_tasks_tile.dart';
import 'empty_state_widget.dart';
import 'show_custom_dialog.dart';
import 'task_formats.dart';
import 'tile_animation.dart';

final notificationService = AlarmServicesImpl();

class AllTasks extends ConsumerWidget {
  const AllTasks({
    super.key,
    required this.tasksList,
    this.isCompletedScreen = false,
  });

  final List<TaskModel> tasksList;
  final bool isCompletedScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final filteredTasks =
        isCompletedScreen
            ? tasksList.where((task) => task.isCompleted).toList()
            : tasksForDate(selectedDate, tasksList);

    if (filteredTasks.isEmpty) {
      return isCompletedScreen
          ? EmptyStateWidget(
            icon: Icons.task_alt,
            iconColor: Colors.green,
            iconSize: 100.sp,
            title: 'No Completed Tasks Yet',
            subtitle: 'Tasks you complete will appear here',
          )
          : EmptyStateWidget(
            icon: Icons.event_busy,
            iconColor: AppTheme.purple,
            iconSize: 100.sp,
            title: 'No Tasks for ${formatShortDate(selectedDate)}',
            subtitle: 'Create a new task to get started and stay productive',
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

    return Column(
      children: List.generate(filteredTasks.length, (index) {
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
              //Todo: Cancel alarm if task is done (take in value of iscompleted) a provider would be best for this
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
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        content: Text('Task deleted successfully'),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      }),
    );
  }
}
