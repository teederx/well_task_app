import 'package:flutter/material.dart';
import 'package:well_task_app/presentation/screens/content/main_screen/widget/skeleton_tile.dart';

class SkeletonList extends StatelessWidget {
  const SkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5, // Show 5 skeleton tiles
        (index) => const SkeletonTile(),
      ),
    );
  }
}


