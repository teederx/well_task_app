import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopImage extends StatelessWidget {
  const TopImage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      width: size.width,
      // color: AppTheme.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(height: 350.h, width: size.width),
          Positioned(
            top: 0,
            right: 1,
            child: Image.asset(
              'assets/images/background/back1.png',
              scale: 3.sp,
            ),
          ),
          Positioned(
            left: 0,
            child: Image.asset(
              'assets/images/background/back3.png',
              scale: 3.sp,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 1,
            child: Image.asset(
              'assets/images/background/back2.png',
              scale: 3.sp,
            ),
          ),
          Image.asset(
            'assets/images/background/female.png',
            scale: 2.5.sp,
          ),
          Positioned(
            right: 30.w,
            bottom: 115.h,
            child: Image.asset(
              'assets/images/background/notifications.png',
              scale: 3.sp,
            ),
          ),
          Positioned(
            top: 20.h,
            left: 40.w,
            child: Image.asset(
              'assets/images/background/stopwatch.png',
              scale: 3.sp,
            ),
          ),
          Positioned(
            top: 50.h,
            right: 40.w,
            child: Image.asset(
              'assets/images/background/calendar.png',
              scale: 3.sp,
            ),
          ),
          Positioned(
            bottom: 30.h,
            left: 30.w,
            child: Image.asset(
              'assets/images/background/vase.png',
              scale: 2.sp,
            ),
          ),
          Positioned(
            bottom: 200.h,
            left: 30.w,
            child: Image.asset(
              'assets/images/background/pie chart.png',
              scale: 2.sp,
            ),
          ),
          Positioned(
            bottom: 30.h,
            left: 20.w,
            child: Image.asset(
              'assets/images/background/coffee_cup.png',
              scale: 2.sp,
            ),
          ),
          Positioned(
            bottom: 20.h,
            right: 100.w,
            child: Image.asset(
              'assets/images/background/Ellipse 5.png',
              scale: 2.sp,
            ),
          ),
          Positioned(
            bottom: 50.h,
            right: 40.w,
            child: Image.asset(
              'assets/images/background/Ellipse 6.png',
              scale: 2.sp,
            ),
          ),
          Positioned(
            top: 50.h,
            right: 100.w,
            child: Image.asset(
              'assets/images/background/Ellipse 7.png',
              scale: 2.sp,
            ),
          ),
          Positioned(
            top: 30.h,
            child: Image.asset(
              'assets/images/background/Ellipse 8.png',
              scale: 2.sp,
            ),
          ),
          Positioned(
            bottom: 10.h,
            left: 80.w,
            child: Image.asset(
              'assets/images/background/Ellipse 9.png',
              scale: 2.sp,
            ),
          ),
          Positioned(
            bottom: -1.h,
            left: 150.w,
            child: Image.asset(
              'assets/images/background/Ellipse 10.png',
              scale: 2.sp,
            ),
          ),
        ],
      ),
    );
  }
}

