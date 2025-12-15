import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:well_task_app/core/utils/constants/app_theme.dart';
import '../../../widget/tile_animation.dart';

class ProfileTile extends StatefulWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    required this.index,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final int index;

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  bool _isPressed = false;

  void _handleHighlight(bool value) {
    setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasTap = widget.onTap != null;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color titleColor = isDark ? Colors.white : Colors.black87;
    final Color subtitleColor =
        isDark ? Colors.white70 : Colors.black.withValues(alpha: 0.6);
    final List<Color> backgroundGradient =
        isDark
            ? [const Color(0xFF1B1539), const Color(0xFF0F0A24)]
            : [const Color(0xFFF6F2FF), const Color(0xFFF2ECFF)];

    return TilesAnimation(
      index: widget.index,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1,
        duration: AppTheme.fastAnimation,
        curve: Curves.easeOut,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            onHighlightChanged: _handleHighlight,
            borderRadius: BorderRadius.circular(18.r),
            splashColor: _ProfileTileColors.primary.withValues(alpha: 0.08),
            child: AnimatedContainer(
              duration: AppTheme.mediumAnimation,
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: backgroundGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color:
                      isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.black.withValues(alpha: 0.04),
                ),
                boxShadow: isDark
                    ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ]
                    : [
                      BoxShadow(
                        color: _ProfileTileColors.primary.withValues(alpha: 0.12),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppTheme.purpleGradient,
                      boxShadow: [
                        BoxShadow(
                          color: _ProfileTileColors.primary.withValues(alpha: 0.2),
                          blurRadius: 14,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 22.r,
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: titleColor,
                          ),
                        ),
                        if (widget.subtitle != null) ...[
                          4.verticalSpace,
                          Text(
                            widget.subtitle!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: subtitleColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (hasTap)
                    Icon(
                      Icons.chevron_right_rounded,
                      color: subtitleColor,
                      size: 22.r,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileTileColors {
  static const Color primary = AppTheme.purple;
}


