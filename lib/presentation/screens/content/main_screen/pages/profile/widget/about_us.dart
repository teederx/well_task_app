import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/svg/icons/Arrow - Left.svg',
                    ),
                  ),
                  10.horizontalSpace,
                  Text(
                    'About the App',
                    style: TextStyle(
                      fontFamily: 'Optician',
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Well Task keeps your day intentional. Plan with clarity, track progress without friction, and let smart reminders handle the nudges so you can stay in flow.',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      12.verticalSpace,
                      Text(
                        'What you get:',
                        style: TextStyle(
                          fontFamily: 'Optician',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      8.verticalSpace,
                      _AboutBullet(
                        title: 'Adaptive scheduling',
                        body:
                            'Reorder and reschedule tasks in seconds when priorities change.',
                      ),
                      _AboutBullet(
                        title: 'Insightful summaries',
                        body:
                            'See streaks, time spent, and quick wins so you always know what matters next.',
                      ),
                      _AboutBullet(
                        title: 'Device harmony',
                        body:
                            'Syncs securely across your devices so your plan is always up to date.',
                      ),
                      16.verticalSpace,
                      Text(
                        'Built to be lightweight, reliable, and delightful — so you can plan smarter and live better.',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      18.verticalSpace,
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            fontFamily: 'Optician',
                            color: Colors.grey,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        'Designed for people who want to move with clarity.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutBullet extends StatelessWidget {
  const _AboutBullet({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6.h),
            width: 8.r,
            height: 8.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.purple.withValues(alpha: 1),
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                4.verticalSpace,
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withValues(alpha: 0.78),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
