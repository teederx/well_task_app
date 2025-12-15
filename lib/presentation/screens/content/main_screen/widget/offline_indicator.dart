import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../providers/connectivity/connectivity_provider.dart';

class OfflineIndicator extends ConsumerWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOfflineProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isOffline ? 40.h : 0,
      color: Colors.redAccent,
      child:
          isOffline
              ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, color: Colors.white, size: 16.sp),
                    8.horizontalSpace,
                    Text(
                      'No Internet Connection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
              : const SizedBox.shrink(),
    );
  }
}


