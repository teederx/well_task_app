import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/main_screen.dart';

import '../../../../../utils/constants/app_theme.dart';

class AddTaskField extends StatelessWidget {
  const AddTaskField({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
    required this.labelText,
    this.maxLines = 1,
    required this.iconData,
    required this.pageType,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final String labelText;
  final int maxLines;
  final IconData iconData;
  final PageType pageType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: Color.fromARGB(100, 182, 163, 240),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.purple2.withAlpha(60),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(iconData, color: AppTheme.purple, size: 15.sp),
            ),
            10.horizontalSpace,
            Text(
              labelText,
              style: TextStyle(
                fontFamily: 'Optician',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        10.verticalSpace,
        Material(
          elevation: 5,
          shadowColor: Colors.black45,
          borderRadius: BorderRadius.circular(10.r),
          child: TextFormField(
            readOnly: pageType == PageType.viewTask,
            maxLines: maxLines,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              hintText: hintText,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
