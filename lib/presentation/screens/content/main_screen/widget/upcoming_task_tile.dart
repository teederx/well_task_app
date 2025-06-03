import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/utils/config/formatted_date_time.dart';

import '../../../../../utils/constants/app_theme.dart';

class UpcomingTaskTile extends StatelessWidget {
  const UpcomingTaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.onTap,
  });
  final String title;
  final String description;
  final DateTime dateTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                height: 60.h,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppTheme.purple,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.purple2.withAlpha(60),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  formatShortDate(dateTime),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Optician',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5.h,
              left: 70.w,
              child: SizedBox(
                width: 150.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.replaceAll(
                        '\n',
                        ' ',
                      ), 
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5.h,
              left: 70.w,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, color: AppTheme.purple2, size: 15.sp),
                  2.horizontalSpace,
                  Text(
                    formatTime(dateTime),
                    style: TextStyle(fontSize: 14.sp, color: AppTheme.purple2),
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
