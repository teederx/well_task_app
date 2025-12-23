import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;
import 'package:url_strategy/url_strategy.dart';

import 'core/utils/config/local_notification_service.dart';
import 'core/utils/config/router/route_provider.dart';
import 'core/utils/constants/app_theme.dart';
import 'data/data_sources/firebase_options.dart';
import 'presentation/providers/theme/theme_provider.dart';

final LocalNotificationService _localNotificationService =
    LocalNotificationService();

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // URL strategy (web)
      setPathUrlStrategy();

      // Environment variables
      await dotenv.load(fileName: '.env');

      // Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // 🔥 TIMEZONE INITIALIZATION (CRITICAL)
      tzd.initializeTimeZones();
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));

      // Notifications
      await _localNotificationService.initialize();
      await _localNotificationService.requestNotificationPermissions();

      // Local storage
      await Hive.initFlutter();

      // Global Flutter errors
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        debugPrint('Flutter Error: ${details.exception}');
      };

      runApp(const ProviderScope(child: MyApp()));
    },
    (error, stack) {
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
      builder: (_, __) {
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
