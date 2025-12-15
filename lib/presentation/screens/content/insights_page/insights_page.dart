import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:well_task_app/data/models/ai_insight_model/ai_insight_model.dart';
import 'package:well_task_app/presentation/providers/ai_insights_provider.dart';
import 'package:well_task_app/presentation/screens/content/insights_page/widgets/insight_card.dart';
import 'package:well_task_app/presentation/screens/content/insights_page/widgets/productivity_score_card.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';

class InsightsPage extends ConsumerWidget {
  static const String routeName = 'insights';
  static const String routeSettings = '/insights';

  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightsState = ref.watch(aiInsightsProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/svg/icons/Arrow - Left.svg',
                    ),
                  ),
                  20.horizontalSpace,
                  Text(
                    'AI Insights',
                    style: TextStyle(
                      fontFamily: 'Optician',
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              // Content
              insightsState.when(
                data: (data) => _buildContent(data, ref),
                loading: () => _buildLoading(),
                error: (error, stack) => _buildError(error, ref),
              ),
              20.verticalSpace,
              // Generate Button
              GestureDetector(
                onTap:
                    insightsState.isLoading
                        ? null
                        : () {
                          ref
                              .read(aiInsightsProvider.notifier)
                              .generateInsights();
                        },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: AppTheme.purple,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.purple.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child:
                        insightsState.isLoading
                            ? SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                8.horizontalSpace,
                                Text(
                                  'Generate Insights',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(AIInsightModel? data, WidgetRef ref) {
    if (data == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lightbulb_outline, size: 64.sp, color: AppTheme.purple),
            20.verticalSpace,
            Text(
              'Unlock Productivity Insights',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            10.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                'Let our AI analyze your tasks and suggest improvements.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductivityScoreCard(score: data.productivityScore),
        25.verticalSpace,
        Text(
          'Summary',
          style: TextStyle(
            fontFamily: 'Optician',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        10.verticalSpace,
        Text(
          data.summary,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
        25.verticalSpace,
        Text(
          'Recommendations',
          style: TextStyle(
            fontFamily: 'Optician',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        10.verticalSpace,
        ...data.recommendations.asMap().entries.map((entry) {
          return InsightCard(index: entry.key, recommendation: entry.value);
        }),
      ],
    );
  }

  Widget _buildLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              25.verticalSpace,
              Container(
                height: 24.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              10.verticalSpace,
              Container(
                height: 60.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              25.verticalSpace,
              Container(
                height: 24.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              10.verticalSpace,
              Container(
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildError(Object error, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60.sp, color: Colors.amber),
            16.verticalSpace,
            Text(
              'Generation Failed',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            8.verticalSpace,
            Text(
              error.toString().replaceAll('Exception: ', ''),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            20.verticalSpace,
            TextButton(
              onPressed: () {
                ref.read(aiInsightsProvider.notifier).generateInsights();
              },
              child: Text(
                'Try Again',
                style: TextStyle(color: AppTheme.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


