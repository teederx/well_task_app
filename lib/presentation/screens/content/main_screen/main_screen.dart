import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/presentation/screens/content/calendar_page/calendar_page.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/pages/completed_tasks.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/pages/profile/profile.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/pages/tasks.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';
import 'package:well_task_app/core/utils/config/haptic_service.dart';

import 'pages/home.dart';
import 'widget/fab.dart';
import 'widget/offline_indicator.dart';

class MainScreen extends StatefulWidget {
  static const String routeSetting = '/main';
  static const String routeName = 'main';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      Home(onTodayTap: () => _onTabTapped(1)),
      const Tasks(),
      const CalendarPage(),
      const CompletedTasks(),
      const Profile(),
    ];
  }

  void _onTabTapped(int index) {
    HapticService.selectionClick();
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const OfflineIndicator(),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
          ),
        ],
      ),
      floatingActionButton: Fab(pageType: PageType.addTask),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottonNav(),
    );
  }

  Container bottonNav() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, AppTheme.purple.withValues(alpha: 0.03)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.purple.withValues(alpha: 0.1),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(icon: Icons.home, index: 0),
          Spacer(flex: 1),
          _buildNavItem(icon: Icons.assignment_rounded, index: 1),
          Spacer(flex: 2),
          _buildNavItem(icon: Icons.calendar_month_rounded, index: 2),
          Spacer(flex: 2),
          _buildNavItem(icon: Icons.assignment_turned_in_rounded, index: 3),
          Spacer(flex: 1),
          _buildNavItem(icon: Icons.person, index: 4),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        height: 60.h,
        width: 50.w,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.transparent),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 5.h,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: 4.h,
                width: isSelected ? 30.w : 0,
                decoration: BoxDecoration(
                  color: AppTheme.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Icon(
              icon,
              color: isSelected ? AppTheme.purple : Colors.grey,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}

enum PageType { addTask, editTask, viewTask }


