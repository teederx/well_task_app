import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:well_task_app/data/models/task_model/task_model.dart';
import 'package:well_task_app/presentation/screens/content/task_page/widgets/time_tracker_widget.dart';

void main() {
  final now = DateTime.now();
  final baseTask = TaskModel(
    id: '1',
    notificationId: 1,
    title: 'Test',
    dueDate: now,
  );

  testWidgets('TimeTrackerWidget renders correctly', (
    WidgetTester tester,
  ) async {
    // Set a large surface size to prevent overflow
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      ProviderScope(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              home: Scaffold(
                body: TimeTrackerWidget(
                  task: baseTask,
                  onTimerChanged: (_, __, ___, ____) {},
                ),
              ),
            );
          },
        ),
      ),
    );

    expect(find.text('Time Tracker'), findsOneWidget);
    expect(find.text('Start Timer'), findsOneWidget);
  });

  testWidgets('TimeTrackerWidget shows Stop Timer when running', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final runningTask = baseTask.copyWith(
      isTimerRunning: true,
      timerStartedAt: DateTime.now(),
      totalTimeSpent: 60,
    );

    await tester.pumpWidget(
      ProviderScope(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              home: Scaffold(
                body: TimeTrackerWidget(
                  task: runningTask,
                  onTimerChanged: (_, __, ___, ____) {},
                ),
              ),
            );
          },
        ),
      ),
    );

    expect(find.text('Stop Timer'), findsOneWidget);
  });
}
