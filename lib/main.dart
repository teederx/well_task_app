import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:url_strategy/url_strategy.dart';

import 'data/data_sources/firebase_options.dart';
import 'presentation/providers/theme_provider.dart';
import 'core/utils/config/local_notification_service.dart';
import 'core/utils/config/router/route_provider.dart';
import 'core/utils/constants/app_theme.dart';

LocalNotificationService _localNotificationService = LocalNotificationService();

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      setPathUrlStrategy();
      await dotenv.load(fileName: '.env');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      tz.initializeTimeZones();

      await _localNotificationService.initialize();
      await _localNotificationService.requestNotificationPermissions();

      await Hive.initFlutter();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        // TODO: Log error to Crashlytics or other service
        debugPrint('Flutter Error: ${details.exception}');
      };

      runApp(
        ProviderScope(
          /* overrides: [
          tasksRepositoryProvider.overrideWithValue(TasksRepositoryImpl()),
          userRepositoryProvider.overrideWithValue(UserRepositoryImpl()),
        ], */
          child: const MyApp(),
        ),
      );
    },
    (error, stack) {
      // TODO: Log error to Crashlytics or other service
      debugPrint('Global Error: $error');
      debugPrint('Stack Trace: $stack');
    },
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeNotifierProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          title: 'Well Task App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
