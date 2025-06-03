import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:well_task_app/utils/firebase_error.dart';

import '../../../data/repositories/auth_repository/provider/auth_repository_provider.dart';
import '../../../onboarding_screen.dart';
import '../../../page_not_found.dart';
import '../../../presentation/screens/auth/change_password_page.dart';
import '../../../presentation/screens/auth/reset_password_page.dart';
import '../../../presentation/screens/content/main_screen/main_screen.dart';
import '../../../presentation/screens/content/notifications_page/notifications_page.dart';

part 'route_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  // ignore: avoid_manual_providers_as_generated_provider_dependency
  final authState = ref.watch(authStateStreamProvider);
  return GoRouter(
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
    ],
    errorBuilder:
        (context, state) => PageNotFound(eMsg: state.error.toString()),
  );
}
