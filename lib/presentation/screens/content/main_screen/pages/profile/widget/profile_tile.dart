import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/constants/app_theme.dart';
import '../../../widget/tile_animation.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    required this.index,
  });
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TilesAnimation(
      index: index,
      child: Card(
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: AppTheme.purple),
          title: Text(title, style: TextStyle(fontSize: 16.sp)),
        ),
      ),
    );
  }
}
