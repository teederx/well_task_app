import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../providers/tasks_providers/completed_task_list/completed_task_list_provider.dart';
import '../widget/all_tasks.dart';
import '../widget/custom_appbar.dart';
import '../widget/skeleton_list.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksListState = ref.watch(completedTaskListProvider);

    return tasksListState.when(
      data: (tasksList) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                CustomAppbar(title: 'Completed Tasks (${tasksList.length})'),
                20.verticalSpace,
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return ref.refresh(completedTaskListProvider.future);
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: AllTasks(
                        tasksList: tasksList,
                        isCompletedScreen: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                CustomAppbar(title: 'Completed Tasks'),
                20.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(child: const SkeletonList()),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error loading completed tasks'));
      },
    );
  }
}


