import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';

class ProductivityScoreCard extends StatelessWidget {
  final double score;

  const ProductivityScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    // Score is 0-100, percent indicator needs 0.0-1.0
    final double percent = (score / 100).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 50.r,
            lineWidth: 10.w,
            percent: percent,
            center: Text(
              '${score.toInt()}%',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.purple,
              ),
            ),
            progressColor: AppTheme.purple,
            backgroundColor: AppTheme.purple.withValues(alpha: 0.1),
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            animationDuration: 1200,
          ),
          20.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Productivity Score',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Optician',
                  ),
                ),
                8.verticalSpace,
                Text(
                  _getMotivationalText(score),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getMotivationalText(double score) {
    if (score >= 80) return 'Excellent work! You are crushing your goals.';
    if (score >= 60) return 'Good job! Keep pushing to reach your potential.';
    if (score >= 40) return 'You can do better. Focus on high priority tasks.';
    return 'Let\'s get started. Create some tasks to track progress.';
  }
}


