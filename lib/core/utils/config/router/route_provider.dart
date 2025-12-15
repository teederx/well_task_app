import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:well_task_app/core/utils/firebase_error.dart';

import 'package:flutter/material.dart';
import '../../../../data/repositories/auth_repository/provider/auth_repository_provider.dart';
import '../../../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../../../presentation/screens/not_found/page_not_found.dart';
import '../../../../presentation/screens/auth/change_password_page.dart';
import '../../../../presentation/screens/auth/reset_password_page.dart';
import '../../../../presentation/screens/content/main_screen/main_screen.dart';
import '../../../../presentation/screens/content/notifications_page/notifications_page.dart';
import '../../../../presentation/screens/content/insights_page/insights_page.dart';
import '../../../../presentation/screens/content/task_page/task_page.dart';

part 'route_provider.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {
  // ignore: avoid_manual_providers_as_generated_provider_dependency
  final authState = ref.watch(authStateStreamProvider);
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: OnboardingScreen.routeSetting,
    redirect: (context, state) {
      if (authState is AsyncLoading<User?>) {
        return OnboardingScreen.routeSetting;
      }

      if (authState is AsyncError<User?>) {
        return FirebaseErrorPage.routeSetting;
      }

      //value is not null if user is authenticated
      final authenticated = authState.valueOrNull != null;

      final authenticating =
          (state.matchedLocation == OnboardingScreen.routeSetting) ||
          (state.matchedLocation == ResetPasswordPage.routeSettings);

      if (authenticated == false) {
        return authenticating ? null : OnboardingScreen.routeSetting;
      }
      return authenticating ? MainScreen.routeSetting : null;
    },

    routes: [
      GoRoute(
        path: OnboardingScreen.routeSetting,
        name: OnboardingScreen.routeName,
        builder: (context, state) {
          return OnboardingScreen();
        },
      ),
      GoRoute(
        path: FirebaseErrorPage.routeSetting,
        name: FirebaseErrorPage.routeName,
        builder: (context, state) {
          return FirebaseErrorPage();
        },
      ),
      GoRoute(
        path: MainScreen.routeSetting,
        name: MainScreen.routeName,
        builder: (context, state) {
          return MainScreen();
        },
      ),
      GoRoute(
        path: NotificationsPage.routeSettings,
        name: NotificationsPage.routeName,
        builder: (context, state) {
          return NotificationsPage();
        },
      ),
      GoRoute(
        path: ChangePasswordPage.routeSettings,
        name: ChangePasswordPage.routeName,
        builder: (context, state) {
          return ChangePasswordPage();
        },
      ),
      GoRoute(
        path: ResetPasswordPage.routeSettings,
        name: ResetPasswordPage.routeName,
        builder: (context, state) {
          return ResetPasswordPage();
        },
      ),
      GoRoute(
        path: InsightsPage.routeSettings,
        name: InsightsPage.routeName,
        builder: (context, state) {
          return const InsightsPage();
        },
      ),
      GoRoute(
        path: '/task/:id/:pageType',
        name: 'task',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final pageTypeStr = state.pathParameters['pageType'];
          final pageType = PageType.values.firstWhere(
            (e) => e.name == pageTypeStr,
            orElse: () => PageType.viewTask,
          );
          return TaskPage(id: id, pageType: pageType);
        },
      ),
    ],
    errorBuilder:
        (context, state) => PageNotFound(eMsg: state.error.toString()),
  );
}
