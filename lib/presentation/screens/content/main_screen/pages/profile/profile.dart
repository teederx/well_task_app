import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:well_task_app/core/utils/config/notification_sound_prefs.dart';
import 'package:well_task_app/core/utils/config/show_confirm_dialog.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';
import 'package:well_task_app/presentation/providers/settings/notification_sound_provider.dart';
import 'package:well_task_app/presentation/screens/auth/change_password_page.dart';
import 'package:well_task_app/presentation/screens/content/insights_page/insights_page.dart';

import '../../../../../../data/models/custom_error_model.dart';
import '../../../../../providers/auth/sign_out/sign_out_provider.dart';
import '../../../../../providers/user/user_provider.dart';
import '../../../stats_page/stats_page.dart';
import '../../widget/show_custom_dialog.dart';
import 'widget/about_us.dart';
import 'widget/profile_head.dart';
import 'widget/profile_tile.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to signOutProvider for logout errors
    ref.listen(signOutProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) {
          final error = e as CustomErrorModel;
          showConfirmDialog(
            context: context,
            title: error.code,
            message: error.message,
            showNO: false,
          );
        },
      );
    });

    final userState = ref.watch(userProvider); // Use `watch` not `read`
    final soundSelection = ref.watch(notificationSoundProvider);
    final soundNotifier = ref.read(notificationSoundProvider.notifier);

    return userState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (err, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error'),
                10.verticalSpace,
                Text(err.toString()),
                ElevatedButton(
                  onPressed:
                      () => ref.invalidate(userProvider), // Refresh user data
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
      data: (user) {
        void copyToClipboard(String label, String value) {
          Clipboard.setData(ClipboardData(text: value));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label copied'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHead(name: user.name),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.r,
                    vertical: 10.r,
                  ),
                  child: Column(
                    children: [
                      ProfileTile(
                        icon: Icons.mail_outline_rounded,
                        title: user.email,
                        subtitle: 'Tap to copy your email',
                        onTap: () => copyToClipboard('Email', user.email),
                        index: 1,
                      ),
                      5.verticalSpace,
                      ProfileTile(
                        icon: Icons.phone_outlined,
                        title: user.phone,
                        subtitle: 'Tap to copy your phone number',
                        onTap: () => copyToClipboard('Phone', user.phone),
                        index: 2,
                      ),
                      5.verticalSpace,
                      ProfileTile(
                        icon: Icons.bar_chart_rounded,
                        title: 'Statistics',
                        subtitle: 'Track streaks and progress',
                        onTap:
                            () => showCustomDialog(
                              context: context,
                              barrierLabel: 'Statistics',
                              child: const StatsPage(),
                              height: 0.9,
                            ),
                        index: 3,
                      ),
                      5.verticalSpace,
                      ProfileTile(
                        icon: Icons.auto_awesome_rounded,
                        title: 'AI Insights',
                        subtitle: 'Let the assistant summarize your week',
                        onTap:
                            () => showCustomDialog(
                              context: context,
                              barrierLabel: 'AI Insights',
                              child: const InsightsPage(),
                              height: 0.9,
                            ),
                        index: 4,
                      ),
                      /*5.verticalSpace, 
                      ThemeToggle(index: 5), */
                      //TODO: Implement theme toggle later
                      5.verticalSpace,
                      ProfileTile(
                        icon: Icons.music_note_rounded,
                        title: 'Notification sound',
                        subtitle: _soundLabel(soundSelection),
                        onTap:
                            () => _showSoundPicker(
                              context,
                              soundSelection,
                              soundNotifier,
                            ),
                        index: 6,
                      ),
                      5.verticalSpace,
                      ProfileTile(
                        icon: Icons.info_outline_rounded,
                        title: 'About the App',
                        subtitle: 'Learn how Well Task supports your flow',
                        onTap:
                            () => showCustomDialog(
                              context: context,
                              barrierLabel: 'About the App',
                              child: const AboutApp(),
                              height: 0.65,
                            ),
                        index: 7,
                      ),
                      5.verticalSpace,
                      ProfileTile(
                        icon: Icons.password_rounded,
                        title: 'Change Password',
                        onTap:
                            () =>
                                context.pushNamed(ChangePasswordPage.routeName),
                        index: 8,
                      ),
                      5.verticalSpace,
                      ProfileTile(
                        icon: Icons.exit_to_app_rounded,
                        title: 'Logout',
                        onTap:
                            () => showConfirmDialog(
                              context: context,
                              title: 'Logout',
                              message: 'Are you sure you want to logout?',
                              onYes:
                                  () =>
                                      ref
                                          .read(signOutProvider.notifier)
                                          .signOut(),
                            ),
                        index: 9,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String _soundLabel(NotificationSoundOption option) {
  switch (option) {
    case NotificationSoundOption.system:
      return 'Use system/default sound';
    case NotificationSoundOption.alarm:
      return 'Use alarm sound';
  }
}

void _showSoundPicker(
  BuildContext context,
  NotificationSoundOption current,
  NotificationSoundNotifier notifier,
) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.volume_up_rounded,
                color:
                    current == NotificationSoundOption.system
                        ? AppTheme.purple
                        : Colors.grey,
              ),
              title: const Text('System / default'),
              subtitle: const Text('Use device default notification sound'),
              trailing:
                  current == NotificationSoundOption.system
                      ? const Icon(Icons.check, color: AppTheme.purple)
                      : null,
              onTap: () {
                notifier.setSound(NotificationSoundOption.system);
                Navigator.of(ctx).pop();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.alarm_rounded,
                color:
                    current == NotificationSoundOption.alarm
                        ? AppTheme.purple
                        : Colors.grey,
              ),
              title: const Text('Alarm'),
              subtitle: const Text('Use bundled alarm.wav for reminders'),
              trailing:
                  current == NotificationSoundOption.alarm
                      ? const Icon(Icons.check, color: AppTheme.purple)
                      : null,
              onTap: () {
                notifier.setSound(NotificationSoundOption.alarm);
                Navigator.of(ctx).pop();
              },
            ),
            10.verticalSpace,
          ],
        ),
      );
    },
  );
}
