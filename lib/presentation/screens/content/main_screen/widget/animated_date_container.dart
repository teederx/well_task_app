import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:well_task_app/core/utils/constants/app_theme.dart';

class AnimatedDateContainer extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const AnimatedDateContainer({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppTheme.normalAnimation,
        curve: Curves.easeOutCubic,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        height: isSelected ? 100.h : 90.h,
        width: 60.w,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          gradient: isSelected ? AppTheme.purpleGradient : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(isSelected ? 20.r : 12.r),
          boxShadow:
              isSelected ? AppTheme.purpleGlowShadow : AppTheme.cardShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.MMM().format(date),
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: isSelected ? Colors.white70 : Colors.black54,
                fontWeight: FontWeight.w700,
              ),
            ),
            4.verticalSpace,
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: AppTheme.mediumAnimation,
              curve: Curves.elasticOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: isSelected ? scale : 1.0,
                  child: child,
                );
              },
              child: Text(
                DateFormat.d().format(date),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24.sp,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            4.verticalSpace,
            Text(
              DateFormat.E().format(date),
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: isSelected ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


