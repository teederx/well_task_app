import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers/tasks_providers/notifications/notifications_provider.dart';
import '../../notifications_page/notifications_page.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(notificationsProvider);
    final today = DateTime.now().day;

    final hasDueToday = task.any((t) => t.dueDate.day == today);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w800,
                fontFamily: 'optician',
              ),
            ),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/svg/icons/notification.svg',
                semanticsLabel: 'Notifications',
              ),
              onPressed: () => context.pushNamed(NotificationsPage.routeName),
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
    );
  }
}
