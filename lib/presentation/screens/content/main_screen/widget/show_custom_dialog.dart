import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/presentation/widgets/custom_page_routes.dart';

import 'package:well_task_app/core/utils/constants/app_theme.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required Widget child,
  String? barrierLabel,
  Duration? transitionDuration,
  bool barrierDismissible = true,
  double height = 0.75,
}) {
  return Navigator.of(context).push(
    SlideUpPageRoute(
      barrierLabel: barrierLabel,
      barrierDismissible: barrierDismissible,
      builder:
          (context) => Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * height,
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppTheme.latte,
                borderRadius: BorderRadius.circular(40),
              ),
              child: child,
            ),
          ),
    ),
  );
}


