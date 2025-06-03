import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/models/task_model/task_model.dart';
import '../../task_page/task_page.dart';
import '../main_screen.dart';
import 'show_custom_dialog.dart';
import 'task_formats.dart';
import 'tile_animation.dart';
import 'upcoming_task_tile.dart';

class UpcomingTasks extends StatelessWidget {
  const UpcomingTasks({super.key, required this.tasksList});
  final List<TaskModel> tasksList;

  @override
  Widget build(BuildContext context) {
    final List<TaskModel> filteredTasks = tasksAfterToday(tasksList);

    if (filteredTasks.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/no-task.png', height: 200.h, width: 300.w),
          5.verticalSpace,
          Text(
            'No undone task upcoming',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'optician',
            ),
          ),
        ],
      );
    }

    return Column(
      children: List.generate(
        filteredTasks.length < 3 ? filteredTasks.length : 3,
        (index) {
          final task = filteredTasks[index];
          return TilesAnimation(
            index: index,
            child: UpcomingTaskTile(
              title: task.title,
              description: task.description ?? '',
              dateTime: task.dueDate,
              onTap: () {
                showCustomDialog(
                  context: context,
                  child: TaskPage(pageType: PageType.viewTask, id: task.id),
                  barrierLabel: 'View Task',
                );
              },
            ),
          );
        },
      ),
    );
  }
}
