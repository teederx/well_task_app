import 'package:flutter/material.dart';

/// A reusable shimmer effect widget for loading states and success animations
class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.enabled = true,
    this.direction = ShimmerDirection.leftToRight,
  });

  final Widget child;
  final Duration duration;
  final bool enabled;
  final ShimmerDirection direction;

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(ShimmerEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Alignment _getBeginAlignment() {
    switch (widget.direction) {
      case ShimmerDirection.leftToRight:
        return const Alignment(-1.0, -0.3);
      case ShimmerDirection.rightToLeft:
        return const Alignment(1.0, -0.3);
      case ShimmerDirection.topToBottom:
        return const Alignment(0.0, -1.0);
      case ShimmerDirection.bottomToTop:
        return const Alignment(0.0, 1.0);
    }
  }

  Alignment _getEndAlignment() {
    switch (widget.direction) {
      case ShimmerDirection.leftToRight:
        return const Alignment(1.0, 0.3);
      case ShimmerDirection.rightToLeft:
        return const Alignment(-1.0, 0.3);
      case ShimmerDirection.topToBottom:
        return const Alignment(0.0, 1.0);
      case ShimmerDirection.bottomToTop:
        return const Alignment(0.0, -1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                Color(0x00FFFFFF),
                Color(0x33FFFFFF),
                Color(0x66FFFFFF),
                Color(0x33FFFFFF),
                Color(0x00FFFFFF),
              ],
              stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
              begin: _getBeginAlignment(),
              end: _getEndAlignment(),
              transform: _SlideGradientTransform(
                slidePercent: _controller.value,
              ),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlideGradientTransform extends GradientTransform {
  const _SlideGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * 2 * (slidePercent - 0.5),
      0.0,
      0.0,
    );
  }
}

enum ShimmerDirection { leftToRight, rightToLeft, topToBottom, bottomToTop }
