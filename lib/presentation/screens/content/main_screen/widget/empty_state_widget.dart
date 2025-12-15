import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyStateWidget extends StatefulWidget {
  const EmptyStateWidget({
    super.key,
    this.imagePath,
    this.icon,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonPressed,
    this.iconColor,
    this.iconSize,
  });

  final String? imagePath;
  final IconData? icon;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Color? iconColor;
  final double? iconSize;

  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon or Image
            if (widget.imagePath != null) ...[
              Image.asset(widget.imagePath!, height: 200.h, width: 200.w),
            ] else if (widget.icon != null) ...[
              Icon(
                widget.icon,
                size: widget.iconSize ?? 100.sp,
                color: widget.iconColor ?? Colors.grey.shade400,
              ),
            ],

            20.verticalSpace,

            // Divider decoration
            Container(
              width: 60.w,
              height: 4.h,
              decoration: BoxDecoration(
                color:
                    widget.iconColor?.withValues(alpha: 0.3) ??
                    Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            20.verticalSpace,

            // Title
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            12.verticalSpace,

            // Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Button (if provided)
            if (widget.buttonText != null &&
                widget.onButtonPressed != null) ...[
              30.verticalSpace,
              ElevatedButton.icon(
                onPressed: widget.onButtonPressed,
                icon: Icon(Icons.add, size: 20.sp),
                label: Text(widget.buttonText!),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      widget.iconColor ?? Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 2,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


