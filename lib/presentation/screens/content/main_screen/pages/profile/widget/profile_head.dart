import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';

class ProfileHead extends StatelessWidget {
  const ProfileHead({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppTheme.purpleGradient.withOpacity(0.5),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32.r)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -40.w,
            top: -20.h,
            child: Container(
              width: 160.r,
              height: 160.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.purple.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            left: -50.w,
            bottom: -30.h,
            child: Container(
              width: 180.r,
              height: 180.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.purple2.withValues(alpha: 0.12),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 104.r,
                    height: 104.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppTheme.purpleGradient,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x665F33E1),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _initialsFromName(name),
                        style: TextStyle(
                          fontFamily: 'Optician',
                          color: Colors.white,
                          fontSize: 42.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  12.verticalSpace,
                  FittedBox(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Optician',
                        fontSize: 28.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  6.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Intentional, calm, and organized — every single day.',
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  16.verticalSpace,
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 8.h,
                    alignment: WrapAlignment.center,
                    children: const [
                      _ProfilePill(label: 'Focus-first workflow'),
                      _ProfilePill(label: 'Smart reminders'),
                      _ProfilePill(label: 'Syncs across devices'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilePill extends StatelessWidget {
  const _ProfilePill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

String _initialsFromName(String value) {
  final parts = value.trim().split(RegExp(r'\\s+')).where((p) => p.isNotEmpty);
  if (parts.isEmpty) return '?';
  final initials = parts.take(2).map((p) => p.characters.first).join();
  return initials.toUpperCase();
}
