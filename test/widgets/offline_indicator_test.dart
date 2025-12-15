import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:well_task_app/presentation/providers/connectivity/connectivity_provider.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/widget/offline_indicator.dart';

void main() {
  testWidgets('OfflineIndicator shows when offline', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [isOfflineProvider.overrideWith((ref) => true)],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, child) {
            return const MaterialApp(
              home: Scaffold(body: Column(children: [OfflineIndicator()])),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No Internet Connection'), findsOneWidget);
    expect(find.byType(OfflineIndicator), findsOneWidget);
  });

  testWidgets('OfflineIndicator hides when online', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [isOfflineProvider.overrideWith((ref) => false)],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, child) {
            return const MaterialApp(
              home: Scaffold(body: Column(children: [OfflineIndicator()])),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No Internet Connection'), findsNothing);
  });
}

