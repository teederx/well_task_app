import 'package:flutter/material.dart';
import 'package:well_task_app/presentation/screens/content/task_page/task_page.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/main_screen.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';
import 'package:well_task_app/core/utils/config/haptic_service.dart';

import 'show_custom_dialog.dart';

class Fab extends StatefulWidget {
  const Fab({super.key, required this.pageType, this.taskId});

  final PageType pageType;
  final String? taskId;

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handlePress() {
    setState(() => _isPressed = true);
    HapticService.mediumImpact();

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() => _isPressed = false);
      }
    });

    showCustomDialog(
      context: context,
      barrierLabel: 'Add Task',
      child: TaskPage(pageType: widget.pageType, id: widget.taskId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _pulseAnimation.value, child: child);
      },
      child: Hero(
        tag: 'fab_hero',
        child: AnimatedRotation(
          turns: _isPressed ? 0.125 : 0.0, // 45 degree rotation on press
          duration: AppTheme.fastAnimation,
          curve: Curves.easeOut,
          child: Material(
            elevation: 8.0,
            shape: const CircleBorder(),
            shadowColor: AppTheme.purple.withValues(alpha: 0.5),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.purpleGradient,
                boxShadow: AppTheme.purpleGlowShadow,
              ),
              child: InkWell(
                onTap: _handlePress,
                customBorder: const CircleBorder(),
                child: Icon(
                  widget.pageType == PageType.addTask
                      ? Icons.add
                      : widget.pageType == PageType.editTask
                      ? Icons.edit
                      : Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


