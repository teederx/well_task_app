import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/app_theme.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required Widget child,
  String? barrierLabel,
  Duration transitionDuration = const Duration(milliseconds: 500),
  bool barrierDismissible = true,
  double height = 0.75,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: barrierLabel,
    transitionDuration: Duration(milliseconds: 500),
    transitionBuilder: (_, animation, __, child) {
      final tween = Tween(begin: Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOutBack),
        ),
        child: child,
      );
    },
    pageBuilder:
        (context, _, __) => Center(
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
  );
}
