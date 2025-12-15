import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/presentation/providers/theme_provider.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';

/// Theme toggle widget for the profile page
/// Allows users to switch between Light, Dark, and System themes
class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key, this.index = 0});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: AppTheme.purple.withValues(alpha: 0.1),
        ),
        child: ExpansionTile(
          leading: Icon(_getThemeIcon(themeMode), color: AppTheme.purple),
          title: const Text(
            'Theme',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            themeNotifier.themeModeName,
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          children: [
            _buildThemeOption(
              context: context,
              title: 'Light',
              icon: Icons.light_mode,
              isSelected: themeMode == ThemeMode.light,
              onTap: () => themeNotifier.setLightTheme(),
            ),
            _buildThemeOption(
              context: context,
              title: 'Dark',
              icon: Icons.dark_mode,
              isSelected: themeMode == ThemeMode.dark,
              onTap: () => themeNotifier.setDarkTheme(),
            ),
            _buildThemeOption(
              context: context,
              title: 'System',
              icon: Icons.settings_suggest,
              isSelected: themeMode == ThemeMode.system,
              onTap: () => themeNotifier.setSystemTheme(),
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.purple : Colors.grey,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          color:
              isSelected
                  ? AppTheme.purple
                  : Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing:
          isSelected
              ? const Icon(Icons.check_circle, color: AppTheme.purple, size: 20)
              : null,
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
    );
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_suggest;
    }
  }
}


