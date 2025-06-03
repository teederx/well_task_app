import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/data/models/task_model/task_model.dart';

import '../../../../providers/tasks_providers/task_list/task_list_provider.dart';
import '../widget/all_tasks.dart';
import '../widget/custom_appbar.dart';
import '../widget/date_picker.dart';

class Tasks extends ConsumerWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<TaskModel>>>(taskListProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) {
          if (!next.isLoading) {
            showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error', textAlign: TextAlign.center),
                  content: Text(e.toString(), textAlign: TextAlign.center),
                );
              },
            );
          }
        },
      );
    });

    final tasksListState = ref.watch(taskListProvider);

    return tasksListState.when(
      data: (tasksList) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                CustomAppbar(title: 'All Tasks (${tasksList.length})'),
                5.verticalSpace,
                DatePickerScreen(),
                20.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    child: AllTasks(tasksList: tasksList),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error loading tasks',
                style: TextStyle(
                  fontFamily: 'optician',
                  fontSize: 18.sp,
                  color: Colors.red,
                ),
              ),
              10.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(taskListProvider);
                },
                child: Text('Retry'),
              ),
            ],
          ),
        );
      },
    );
  }
}
