import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:well_task_app/core/utils/config/formatted_date_time.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';
import '../../../providers/tasks_providers/notifications/notifications_provider.dart';
import '../main_screen/widget/tile_animation.dart';

class NotificationsPage extends ConsumerWidget {
  static const String routeSettings = '/notifications';
  static const String routeName = 'notifications';
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.r),
        child: ListView.builder(
          itemCount: tasks.length, // Replace with your notifications count
          itemBuilder: (context, index) {
            final date = tasks[index].dueDate;
            return TilesAnimation(
              index: index,
              child: Card(
                color: Colors.white,
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppTheme.purple2.withAlpha(100),
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/icons/notification.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppTheme.purple,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  title: Text(
                    tasks[index].title,
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    'Scheduled for ${formatDateTime(date)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


