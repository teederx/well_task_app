import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:well_task_app/core/utils/constants/app_theme.dart';
import '../../../../providers/tasks_providers/notifications/notifications_provider.dart';
import '../../../../providers/user/user_provider.dart';
import '../../notifications_page/notifications_page.dart';
import '../../insights_page/insights_page.dart';

class Appbar extends ConsumerWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(notificationsProvider);
    final today = DateTime.now().day;
    final userState = ref.watch(userProvider);

    final hasDueToday = task.any((t) => t.dueDate.day == today);

    return Row(
      children: [
        Icon(Icons.account_circle_rounded, color: AppTheme.purple, size: 50.r),
        5.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello!', style: TextStyle(fontSize: 15.sp)),
            Text(
              userState.maybeWhen(
                orElse: () => 'User',
                data: (user) => user.name,
              ),
              style: TextStyle(
                fontFamily: 'Optician',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.auto_awesome_outlined,
                color: AppTheme.purple,
                size: 28.sp,
              ),
              onPressed: () => context.pushNamed(InsightsPage.routeName),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/icons/notification.svg',
                    semanticsLabel: 'Notifications',
                  ),
                  onPressed:
                      () => context.pushNamed(NotificationsPage.routeName),
                ),
                if (hasDueToday)
                  Positioned(
                    right: 15.w,
                    top: 10.h,
                    child: SvgPicture.asset('assets/svg/icons/Ellipse.svg'),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


