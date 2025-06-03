import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/constants/app_theme.dart';

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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        height: isSelected ? 100.h : 90.h,
        width: 60.w,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.purple : Colors.white,
          borderRadius: BorderRadius.circular(isSelected ? 20.r : 12.r),
          boxShadow: [
            BoxShadow(
              color:
                  isSelected
                      ? AppTheme.purple.withAlpha(40)
                      : Colors.black.withAlpha(40),
              blurRadius: isSelected ? 8 : 4,
              offset: const Offset(0, 0),
            ),
          ],
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
            Text(
              DateFormat.d().format(date),
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24.sp,
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
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
