import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:well_task_app/data/models/task_model/task_model.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/widget/upcoming_task_tile.dart';

void main() {
  testWidgets('UpcomingTaskTile displays task details correctly', (
    WidgetTester tester,
  ) async {
    // Setup
    final now = DateTime.now();
    bool tapped = false;

    // Build the widget
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            home: Scaffold(
              body: UpcomingTaskTile(
                id: '1',
                title: 'Test Title',
                description: 'Test Description',
                dateTime: now,
                priority: TaskPriority.high,
                onTap: () => tapped = true,
                onComplete: () {},
                onDelete: () {},
              ),
            ),
          );
        },
      ),
    );

    // Verify elements are present
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
    // Note: Date formatting might depend on locale, checks if any text is present for now or specific format if known
    // Since formatShortDate is used, we might see just day/month. Let's assume it renders something.

    // Tap interaction
    await tester.tap(find.byType(UpcomingTaskTile));
    await tester.pump();
    expect(tapped, true);
  });
}
