import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:well_task_app/presentation/widgets/shimmer_effect.dart';

import '../../../../../utils/constants/app_theme.dart';

class ProgressCard extends StatefulWidget {
  const ProgressCard({
    super.key,
    required this.onPressed,
    required this.percentage,
  });

  final VoidCallback onPressed;
  final double percentage;

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = widget.percentage >= 1.0;

    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_floatAnimation.value),
          child: child,
        );
      },
      child: ShimmerEffect(
        enabled: isComplete,
        duration: AppTheme.shimmerDuration,
        child: Container(
          height: 150.h,
          width: double.infinity,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            gradient: AppTheme.purpleGradient,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: AppTheme.purpleGlowShadow,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  width: 150.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Let\'s get right in to today\'s tasks!',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      25.verticalSpace,
                      _buildButton(),
                    ],
                  ),
                ),
              ),
              Positioned(right: 0, child: _buildProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: 1.0),
      duration: AppTheme.normalAnimation,
      builder: (context, scale, child) {
        return AnimatedScale(
          scale: scale,
          duration: AppTheme.fastAnimation,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            ),
            child: Text(
              'View Tasks',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.purple,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressIndicator() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: widget.percentage),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        int percent = (value * 100).toInt();
        bool isComplete = value >= 1.0;

        return TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: 1.0,
            end: isComplete ? 1.1 : 1.0, // pulse when complete
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          builder: (context, scale, _) {
            return Transform.scale(
              scale: scale,
              child: CircularPercentIndicator(
                radius: 60.r,
                lineWidth: 15.w,
                percent: value.clamp(0.0, 1.0),
                center: Text(
                  "$percent%",
                  style: TextStyle(
                    fontFamily: 'Magnolia',
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white.withAlpha(100),
                progressColor: Colors.white,
                circularStrokeCap: CircularStrokeCap.round,
                animation: false,
                startAngle: 0,
                reverse: true,
              ),
            );
          },
        );
      },
    );
  }
}
