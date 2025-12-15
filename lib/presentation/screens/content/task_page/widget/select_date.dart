import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({
    super.key,
    required TextEditingController controller,
    required this.onTap,
  }) : _controller = controller;

  final TextEditingController _controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: Colors.black45,
      borderRadius: BorderRadius.circular(10.r),
      child: TextFormField(
        controller: _controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Select Date & Time',
          prefixIconConstraints: BoxConstraints(
            minHeight: 40.h,
            minWidth: 40.w,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 5.w),
            child: SvgPicture.asset(
              'assets/svg/icons/calendar.svg',
              height: 5.h,
              width: 5.w,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select date and time';
          }
          return null;
        },
      ),
    );
  }
}


