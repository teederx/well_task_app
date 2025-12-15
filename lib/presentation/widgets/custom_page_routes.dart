import 'package:flutter/material.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';

/// Custom page route with smooth fade + slide animation
class FadeSlidePageRoute<T> extends PageRoute<T> {
  FadeSlidePageRoute({
    required this.builder,
    super.settings,
    this.maintainState = true,
    super.fullscreenDialog = false,
  });

  final WidgetBuilder builder;

  @override
  final bool maintainState;

  @override
  Duration get transitionDuration => AppTheme.normalAnimation;

  @override
  Duration get reverseTransitionDuration => AppTheme.fastAnimation;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.05, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeOutCubic;

    var slideTween = Tween(
      begin: begin,
      end: end,
    ).chain(CurveTween(curve: curve));
    var fadeTween = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(slideTween),
      child: FadeTransition(opacity: animation.drive(fadeTween), child: child),
    );
  }
}

/// Custom page route with scale animation for dialogs
class ScalePageRoute<T> extends PageRoute<T> {
  ScalePageRoute({
    required this.builder,
    super.settings,
    this.maintainState = true,
    this.barrierDismissible = true,
    this.barrierLabel,
  });

  final WidgetBuilder builder;
  @override
  final bool barrierDismissible;

  @override
  final bool maintainState;

  @override
  final String? barrierLabel;

  @override
  Duration get transitionDuration => AppTheme.normalAnimation;

  @override
  Duration get reverseTransitionDuration => AppTheme.fastAnimation;

  @override
  Color? get barrierColor => Colors.black54;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const curve = Curves.easeOutCubic;

    var scaleTween = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).chain(CurveTween(curve: curve));
    var fadeTween = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: curve));

    return ScaleTransition(
      scale: animation.drive(scaleTween),
      child: FadeTransition(opacity: animation.drive(fadeTween), child: child),
    );
  }
}

/// Custom page route with slide-up animation for task pages
class SlideUpPageRoute<T> extends PageRoute<T> {
  SlideUpPageRoute({
    required this.builder,
    super.settings,
    this.maintainState = true,
    this.barrierDismissible = true,
    this.barrierLabel,
  });

  final WidgetBuilder builder;
  @override
  final bool barrierDismissible;

  @override
  final bool maintainState;

  @override
  final String? barrierLabel;

  @override
  Duration get transitionDuration => AppTheme.mediumAnimation;

  @override
  Duration get reverseTransitionDuration => AppTheme.normalAnimation;

  @override
  Color? get barrierColor => Colors.black54;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeOutCubic;

    var slideTween = Tween(
      begin: begin,
      end: end,
    ).chain(CurveTween(curve: curve));
    var fadeTween = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(slideTween),
      child: FadeTransition(opacity: animation.drive(fadeTween), child: child),
    );
  }
}


