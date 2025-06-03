import 'package:flutter/material.dart';
import 'package:well_task_app/presentation/screens/content/task_page/task_page.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/main_screen.dart';
import 'package:well_task_app/utils/constants/app_theme.dart';

import 'show_custom_dialog.dart';

class Fab extends StatelessWidget {
  const Fab({super.key, required this.pageType, this.taskId});

  final PageType pageType;
  final String? taskId;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showCustomDialog(
          context: context,
          barrierLabel: 'Add Task',
          child: TaskPage(pageType: pageType, id: taskId),
        );
      },
      backgroundColor: AppTheme.purple,
      child: Icon(
        pageType == PageType.addTask
            ? Icons.add
            : pageType == PageType.editTask
            ? Icons.edit
            : null,
        color: Colors.white,
      ),
    );
  }
}
