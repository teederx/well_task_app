import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable glassmorphism container for modern UI elements
class GlassmorphicContainer extends StatelessWidget {
  const GlassmorphicContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.blur = 10.0,
    this.opacity = 0.1,
    this.border,
    this.gradient,
    this.padding,
    this.margin,
  });

  final Widget child;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final double blur;
  final double opacity;
  final Border? border;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor =
        isDark
            ? Colors.white.withValues(alpha: opacity)
            : Colors.white.withValues(alpha: opacity);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: border,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient:
                  gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      defaultColor.withValues(alpha: opacity * 1.2),
                      defaultColor.withValues(alpha: opacity * 0.8),
                    ],
                  ),
              borderRadius: borderRadius ?? BorderRadius.circular(16),
              border: border,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Preset glassmorphic styles
class GlassPresets {
  static GlassmorphicContainer light({
    required Widget child,
    double? width,
    double? height,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      blur: 10,
      opacity: 0.15,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.2),
        width: 1.5,
      ),
      child: child,
    );
  }

  static GlassmorphicContainer dark({
    required Widget child,
    double? width,
    double? height,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      blur: 10,
      opacity: 0.1,
      border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
      child: child,
    );
  }

  static GlassmorphicContainer strong({
    required Widget child,
    double? width,
    double? height,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      blur: 15,
      opacity: 0.25,
      border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
      child: child,
    );
  }
}
