import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:well_task_app/presentation/screens/auth/change_password_page.dart';
import 'package:well_task_app/presentation/screens/content/insights_page/insights_page.dart';

import '../../../../../../data/models/custom_error_model.dart';
import '../../../../../../utils/config/show_confirm_dialog.dart';
import '../../../../../providers/auth/sign_out/sign_out_provider.dart';
import '../../../../../providers/user/user_provider.dart';
import '../../widget/show_custom_dialog.dart';
import 'widget/about_us.dart';
import 'widget/profile_head.dart';
import 'widget/profile_tile.dart';
import '../../../stats_page/stats_page.dart';

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
        return Column(
          children: [
            ProfileHead(name: user.name), // ✅ Pass actual user name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
              child: ListView(
                shrinkWrap: true,
                children: [
                  ProfileTile(
                    icon: Icons.mail_outline_rounded,
                    title: user.email,
                    index: 1,
                  ),
                  5.verticalSpace,
                  ProfileTile(
                    icon: Icons.phone_outlined,
                    title: user.phone,
                    index: 2,
                  ),
                  5.verticalSpace,
                  ProfileTile(
                    icon: Icons.bar_chart_rounded,
                    title: 'Statistics',
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
                    onTap:
                        () => showCustomDialog(
                          context: context,
                          barrierLabel: 'AI Insights',
                          child: const InsightsPage(),
                          height: 0.9,
                        ),
                    index: 4,
                  ),
                  5.verticalSpace,
                  ProfileTile(
                    icon: Icons.info_outline_rounded,
                    title: 'About Us',
                    onTap:
                        () => showCustomDialog(
                          context: context,
                          barrierLabel: 'About Us',
                          child: const AboutUs(),
                          height: 0.65,
                        ),
                    index: 5,
                  ),
                  5.verticalSpace,
                  ProfileTile(
                    icon: Icons.password_rounded,
                    title: 'Change Password',
                    onTap:
                        () => context.pushNamed(ChangePasswordPage.routeName),
                    index: 6,
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
                                  ref.read(signOutProvider.notifier).signOut(),
                        ),
                    index: 7,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
