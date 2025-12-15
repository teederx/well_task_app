import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/widget/todays_task.dart';

import '../widget/skeleton_list.dart';

import '../../../../providers/tasks_providers/task_list/task_list_provider.dart';
import '../widget/app_bar.dart';
import '../widget/progress_card.dart';
import '../widget/task_formats.dart';
import '../widget/upcoming_tasks.dart';

class Home extends ConsumerWidget {
  const Home({super.key, required this.onTodayTap});
  final VoidCallback onTodayTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksListState = ref.watch(taskListProvider);

    return tasksListState.when(
      data: (tasksList) {
        final double percentage =
            tasksList.isEmpty
                ? 0
                : tasksList.where((task) => task.isCompleted).length /
                    tasksList.length;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                Appbar(),
                20.verticalSpace,
                ProgressCard(percentage: percentage, onPressed: onTodayTap),
                15.verticalSpace,
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return ref.refresh(taskListProvider.future);
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Today\'s Tasks',
                                style: TextStyle(
                                  fontFamily: 'optician',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              if (tasksForDate(
                                DateTime.now(),
                                tasksList,
                              ).isNotEmpty)
                                TextButton(
                                  onPressed: onTodayTap,
                                  child: Text('See all'),
                                ),
                            ],
                          ),
                          5.verticalSpace,
                          TodaysTasks(tasksList: tasksList),
                          if (tasksAfterToday(tasksList).isNotEmpty)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                15.verticalSpace,
                                Row(
                                  children: [
                                    Text(
                                      'Upcoming Tasks',
                                      style: TextStyle(
                                        fontFamily: 'optician',
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    TextButton(
                                      onPressed: onTodayTap,
                                      child: Text('See all'),
                                    ),
                                  ],
                                ),
                                5.verticalSpace,
                                UpcomingTasks(tasksList: tasksList),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (e, st) {
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
      loading: () {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                Appbar(),
                20.verticalSpace,
                // Skeleton for Progress Card
                Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                15.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today\'s Tasks',
                          style: TextStyle(
                            fontFamily: 'optician',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        5.verticalSpace,
                        const SkeletonList(),
                        15.verticalSpace,
                        Text(
                          'Upcoming Tasks',
                          style: TextStyle(
                            fontFamily: 'optician',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        5.verticalSpace,
                        const SkeletonList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


