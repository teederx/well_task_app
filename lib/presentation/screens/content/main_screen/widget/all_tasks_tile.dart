import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:well_task_app/presentation/screens/content/main_screen/main_screen.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/widget/show_custom_dialog.dart';
import 'package:well_task_app/presentation/screens/content/task_page/task_page.dart';
import 'package:well_task_app/core/utils/config/formatted_date_time.dart';
import 'package:well_task_app/core/utils/config/haptic_service.dart';
import 'package:well_task_app/core/utils/constants/priority_constants.dart';
import 'package:well_task_app/domain/entities/task_enums.dart';
import 'package:well_task_app/presentation/widgets/glassmorphic_container.dart';

import 'package:well_task_app/core/utils/constants/app_theme.dart';
import 'package:well_task_app/domain/entities/subtask.dart';

class AllTasksTile extends StatelessWidget {
  const AllTasksTile({
    super.key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isCompleted,
    required this.onTap,
    required this.id,
    required this.handleMenuSelection,
    required this.priority,
    this.subtasks = const [],
  });
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isCompleted;
  final VoidCallback onTap;
  final void Function(String value) handleMenuSelection;
  final TaskPriority priority;
  final List<Subtask> subtasks;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isOverdue = dateTime.isBefore(now);

    return Dismissible(
      key: Key(id),
      confirmDismiss: (direction) async {
        // Trigger haptic feedback
        await HapticService.mediumImpact();
        if (!context.mounted) return false;

        if (direction == DismissDirection.startToEnd) {
          // Right swipe - Complete task
          onTap(); // Toggle completion
          return false; // Don't remove from list
        } else if (direction == DismissDirection.endToStart) {
          // Left swipe - Delete task (with confirmation)
          return await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Delete Task'),
                      content: const Text(
                        'Are you sure you want to delete this task?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            handleMenuSelection('delete');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.red,
                          ),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
              ) ??
              false;
        }
        return false;
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: AppTheme.green,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.w),
        child: Icon(Icons.check_circle, color: Colors.white, size: 32.sp),
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: AppTheme.red,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        child: Icon(Icons.delete_rounded, color: Colors.white, size: 32.sp),
      ),
      child: GestureDetector(
        onTap:
            () => showCustomDialog(
              context: context,
              barrierLabel: 'View Task',
              child: TaskPage(pageType: PageType.viewTask, id: id),
            ),
        child: Container(
          height: 100.h,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: AppTheme.priorityGlowShadow(
              PriorityConstants.getPriorityColor(priority),
            ),
          ),
          child: Stack(
            children: [
              SizedBox(height: 100.h, width: double.infinity),
              Positioned(
                top: 5.h,
                child: GlassmorphicContainer(
                  blur: 10,
                  opacity: 0.15,
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: AppTheme.accentGradient,
                  padding: EdgeInsets.all(5.r),
                  child: Icon(
                    Icons.assignment_rounded,
                    color: AppTheme.purple,
                    size: 20.sp,
                  ),
                ),
              ),
              Positioned(
                top: 5.h,
                right: 5.w,
                child: GestureDetector(
                  onTap: onTap,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted ? AppTheme.purple : Colors.transparent,
                      border: Border.all(
                        color: isCompleted ? AppTheme.purple : AppTheme.purple2,
                        width: 2,
                      ),
                    ),
                    child:
                        isCompleted
                            ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                            : null,
                  ),
                ),
              ),
              Positioned(
                top: 5.h,
                left: 40.w,
                child: SizedBox(
                  width: 150.w,
                  height: 45.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.replaceAll(
                          '\n',
                          ' ',
                        ), // Replace line breaks with space
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          decoration:
                              isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                          decorationColor:
                              isCompleted
                                  ? AppTheme.purple
                                  : Colors.transparent,
                        ),
                      ),
                      Text(
                        description.replaceAll('\n', ' '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          decoration:
                              isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                          decorationColor:
                              isCompleted
                                  ? AppTheme.purple
                                  : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 5.h,
                left: 40.w,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule,
                      color: isOverdue ? AppTheme.red : AppTheme.purple2,
                      size: 15.sp,
                    ),
                    2.horizontalSpace,
                    Text(
                      formatTime(dateTime),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isOverdue ? AppTheme.red : AppTheme.purple2,
                      ),
                    ),
                    if (subtasks.isNotEmpty) ...[
                      10.horizontalSpace,
                      Icon(
                        Icons.checklist_rounded,
                        color: AppTheme.purple2,
                        size: 15.sp,
                      ),
                      2.horizontalSpace,
                      Text(
                        '${subtasks.where((s) => s.isCompleted).length}/${subtasks.length}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppTheme.purple2,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Positioned(
                bottom: -5.h,
                right: -5.w,
                child: PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: AppTheme.purple2,
                    size: 20.sp,
                  ),
                  onSelected: handleMenuSelection,
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(value: 'view', child: Text('View Task')),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete Task'),
                        ),
                      ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
