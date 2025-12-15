import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:well_task_app/presentation/screens/auth/auth_page.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';
import 'button_data.dart';

class NavToAuthButton extends ConsumerWidget {
  const NavToAuthButton({super.key, required this.size, required this.button});

  final Size size;
  final ButtonData button;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ElevatedButton(
        onPressed: () {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: "Sign In",
            transitionDuration: Duration(milliseconds: 400),
            transitionBuilder: (_, animation, __, child) {
              Tween<Offset> tween;
              tween = Tween(begin: Offset(0, -1), end: Offset.zero);
              return SlideTransition(
                position: tween.animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutBack,
                  ),
                ),
                child: child,
              );
            },
            pageBuilder: (context, _, __) {
              return Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.10),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  height: size.height * 0.85,
                  decoration: BoxDecoration(
                    color: AppTheme.latte,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: AuthPage(size: size),
                ),
              );
            },
          );
          /* .then((value) {
            if (value == true) {
              Navigator.pushNamed(
                context,
                MainScreen.routeName,
              );
            }
          }); */
        },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: button.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
        ),
        child: Text(
          button.name,
          style: TextStyle(
            fontFamily: 'Optician',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


