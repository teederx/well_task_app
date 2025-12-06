import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/data/models/attachment_model/attachment_model.dart';
import 'package:well_task_app/utils/constants/app_theme.dart';

class AttachmentListWidget extends StatelessWidget {
  final List<AttachmentModel> attachments;
  final Function(AttachmentModel) onDelete;
  final Function() onAddAttachment;

  const AttachmentListWidget({
    super.key,
    required this.attachments,
    required this.onDelete,
    required this.onAddAttachment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.attach_file, color: AppTheme.purple, size: 20.sp),
                8.horizontalSpace,
                Text(
                  'Attachments',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.purple,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: onAddAttachment,
              icon: Icon(Icons.add_circle, color: AppTheme.purple, size: 24.sp),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        if (attachments.isNotEmpty) ...[
          12.verticalSpace,
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: attachments.length,
              separatorBuilder: (context, index) => 12.horizontalSpace,
              itemBuilder: (context, index) {
                final attachment = attachments[index];
                return Stack(
                  children: [
                    Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppTheme.purple.withValues(alpha: 0.2),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child:
                            attachment.fileType == AttachmentType.image
                                ? Image.file(
                                  File(attachment.filePath),
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          _buildFilePlaceholder(),
                                )
                                : _buildFilePlaceholder(),
                      ),
                    ),
                    Positioned(
                      top: 4.h,
                      right: 4.w,
                      child: GestureDetector(
                        onTap: () => onDelete(attachment),
                        child: Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.close,
                            size: 14.sp,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFilePlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_drive_file_outlined,
            color: AppTheme.purple,
            size: 32.sp,
          ),
          4.verticalSpace,
          Text(
            'File',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
