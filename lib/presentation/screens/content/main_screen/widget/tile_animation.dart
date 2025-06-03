import 'package:flutter/material.dart';

class TilesAnimation extends StatelessWidget {
  const TilesAnimation({super.key, required this.index, required this.child});
  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + index * 100), // staggered effect
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20), // slide up 20px
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
