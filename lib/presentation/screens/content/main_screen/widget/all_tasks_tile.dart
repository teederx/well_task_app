import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/main_screen.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/widget/show_custom_dialog.dart';
import 'package:well_task_app/presentation/screens/content/task_page/task_page.dart';
import 'package:well_task_app/utils/config/formatted_date_time.dart';

import '../../../../../utils/constants/app_theme.dart';

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
  });
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isCompleted;
  final VoidCallback onTap;
  final void Function(String value) handleMenuSelection;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isOverdue = dateTime.isBefore(now);

    return GestureDetector(
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(60),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            SizedBox(height: 100.h, width: double.infinity),
            Positioned(
              top: 5.h,
              child: Container(
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Color.fromARGB(255, 182, 163, 240),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.purple2.withAlpha(60),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
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
                            isCompleted ? AppTheme.purple : Colors.transparent,
                      ),
                    ),
                    Text(
                      description.replaceAll(
                        '\n',
                        ' ',
                      ), 
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
                            isCompleted ? AppTheme.purple : Colors.transparent,
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
    );
  }
}
