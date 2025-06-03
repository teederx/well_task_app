import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset('assets/svg/icons/Arrow - Left.svg'),
              ),
              30.horizontalSpace,
              Text(
                'About Us',
                style: TextStyle(
                  fontFamily: 'Optician',
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          5.verticalSpace,
          ListView(
            shrinkWrap: true,
            children: [
              Text(
                'Welcome Task is a simple and powerful tool designed to help you manage your tasks with ease. Whether it\'s daily errands or big goals, we make it easy to stay organized, on time, and in control.',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              5.verticalSpace,
              Text(
                ' Built for convenience, Welcome Task lets you create, track, and schedule tasks — all in one place. With smart reminders and a clean interface, being productive has never been this effortless.',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              5.verticalSpace,
              Text(
                'Welcome Task — plan smarter, live better.',
                style: TextStyle(
                  fontFamily: 'Optician',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              20.verticalSpace,
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontFamily: 'Optician',
                  color: Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Powered by Bus 200lvl Group 3 students',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
