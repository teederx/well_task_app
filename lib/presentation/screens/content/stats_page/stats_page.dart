import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/utils/constants/app_theme.dart';
import '../../../../data/models/task_model/task_enums.dart';
import '../../../providers/tasks_providers/task_list/task_list_provider.dart';

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListAsync = ref.watch(taskListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: taskListAsync.when(
        data: (tasks) {
          final completedTasks = tasks.where((t) => t.isCompleted).length;
          final totalTasks = tasks.length;
          final completionRate =
              totalTasks > 0 ? (completedTasks / totalTasks * 100) : 0.0;

          // Category distribution
          final categoryMap = <TaskCategory, int>{};
          for (var task in tasks) {
            categoryMap[task.category] = (categoryMap[task.category] ?? 0) + 1;
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Cards
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Total Tasks',
                        value: totalTasks.toString(),
                        icon: Icons.assignment,
                        color: AppTheme.purple,
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: _StatCard(
                        title: 'Completed',
                        value: completedTasks.toString(),
                        icon: Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Active',
                        value: (totalTasks - completedTasks).toString(),
                        icon: Icons.pending_actions,
                        color: Colors.orange,
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: _StatCard(
                        title: 'Completion Rate',
                        value: '${completionRate.toStringAsFixed(0)}%',
                        icon: Icons.trending_up,
                        color: AppTheme.green,
                      ),
                    ),
                  ],
                ),
                30.verticalSpace,

                // Completion Rate Pie Chart
                Text(
                  'Completion Overview',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                15.verticalSpace,
                Container(
                  height: 250.h,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child:
                      totalTasks > 0
                          ? PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  color: Colors.green,
                                  value: completedTasks.toDouble(),
                                  title: '$completedTasks',
                                  radius: 60.r,
                                  titleStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                PieChartSectionData(
                                  color: Colors.orange,
                                  value:
                                      (totalTasks - completedTasks).toDouble(),
                                  title: '${totalTasks - completedTasks}',
                                  radius: 60.r,
                                  titleStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                              sectionsSpace: 2,
                              centerSpaceRadius: 40.r,
                            ),
                          )
                          : Center(
                            child: Text(
                              'No tasks to display',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Legend(color: Colors.green, label: 'Completed'),
                    20.horizontalSpace,
                    _Legend(color: Colors.orange, label: 'Active'),
                  ],
                ),
                30.verticalSpace,

                // Category Distribution
                Text(
                  'Tasks by Category',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                15.verticalSpace,
                Container(
                  height: 300.h,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child:
                      categoryMap.isNotEmpty
                          ? BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY:
                                  categoryMap.values
                                      .reduce((a, b) => a > b ? a : b)
                                      .toDouble() +
                                  2,
                              barGroups:
                                  categoryMap.entries.map((entry) {
                                    return BarChartGroupData(
                                      x: entry.key.index,
                                      barRods: [
                                        BarChartRodData(
                                          toY: entry.value.toDouble(),
                                          color: entry.key.color,
                                          width: 20.w,
                                          borderRadius: BorderRadius.circular(
                                            4.r,
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() >= 0 &&
                                          value.toInt() <
                                              TaskCategory.values.length) {
                                        final category =
                                            TaskCategory.values[value.toInt()];
                                        return Padding(
                                          padding: EdgeInsets.only(top: 8.h),
                                          child: Text(
                                            category.label.substring(0, 3),
                                            style: TextStyle(fontSize: 10.sp),
                                          ),
                                        );
                                      }
                                      return const Text('');
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30.w,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: TextStyle(fontSize: 10.sp),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                            ),
                          )
                          : Center(
                            child: Text(
                              'No category data',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                ),
              ],
            ),
          );
        },
        error: (error, stack) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28.sp),
          10.verticalSpace,
          Text(
            value,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          4.verticalSpace,
          Text(title, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        8.horizontalSpace,
        Text(label, style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }
}
