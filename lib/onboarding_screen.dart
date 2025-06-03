import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget/button_data.dart';
import 'widget/nav_to_auth_button.dart';
import 'widget/top_image.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeSetting = '/';
  static const String routeName = 'onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          spacing: 20.h,
          children: [
            TopImage(size: size),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(width: 300.w, height: 60.h),
                      Positioned(
                        left: 55.w,
                        child: Image.asset(
                          'assets/images/logo2.png',
                          width: 80.w,
                          height: 80.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 120.w,
                        child: Text(
                          'ell Task',
                          style: TextStyle(
                            fontFamily: 'Magnolia',
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 0, 48, 107),
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Text(
                    'This productive tool is designed to help you better manage your task conveniently!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF6E6A7C),
                    ),
                  ),
                  40.verticalSpace,
                  Column(
                    children: [
                      ...buttons.map((button) {
                        return NavToAuthButton(size: size, button: button);
                      }),
                    ],
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
