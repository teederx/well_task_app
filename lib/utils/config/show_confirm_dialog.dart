import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';

void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  VoidCallback? onYes,
  bool showNO = true,
  VoidCallback? onNo,
}) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible:
        false, // Prevents dialog from closing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 5,
        icon: Icon(Icons.warning_amber_outlined, size: 50.sp),
        iconColor: AppTheme.red,
        title: Text(title),
        titleTextStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppTheme.purple,
        ),
        content: Text(message),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              if (onYes != null) onYes();
            },
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: AppTheme.purple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(showNO ? 'Yes' : 'OK'),
          ),
          if (showNO)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (onNo != null) onNo();
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: AppTheme.purple),
                ),
              ),
              child: const Text('No'),
            ),
        ],
      );
    },
  );
}
