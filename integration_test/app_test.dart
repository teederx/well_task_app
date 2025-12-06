import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:well_task_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('end-to-end task creation', (WidgetTester tester) async {
    // Start app
    app.main();
    await tester.pumpAndSettle();

    // Verify FAB exists (Home Screen loaded)
    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);

    // Tap FAB to add task
    await tester.tap(fab);
    await tester.pumpAndSettle();

    // Fill Title
    final titleField = find.widgetWithText(TextField, 'Task name');
    expect(titleField, findsOneWidget);
    await tester.enterText(titleField, 'Integration Test Task');
    await tester.pumpAndSettle();

    // Save Task
    final createButton = find.text('Create New Task');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    // Verify Task is in the list
    expect(find.text('Integration Test Task'), findsOneWidget);
  });
}
