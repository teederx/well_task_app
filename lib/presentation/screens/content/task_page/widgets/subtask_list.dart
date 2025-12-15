import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';
import '../../../../../domain/entities/subtask.dart';

class SubtaskList extends ConsumerStatefulWidget {
  final List<Subtask> subtasks;
  final Function(List<Subtask>) onSubtasksChanged;

  const SubtaskList({
    super.key,
    required this.subtasks,
    required this.onSubtasksChanged,
  });

  @override
  ConsumerState<SubtaskList> createState() => _SubtaskListState();
}

class _SubtaskListState extends ConsumerState<SubtaskList> {
  final TextEditingController _subtaskController = TextEditingController();
  final Uuid _uuid = const Uuid();

  @override
  void dispose() {
    _subtaskController.dispose();
    super.dispose();
  }

  void _addSubtask() {
    if (_subtaskController.text.trim().isEmpty) return;

    final newSubtask = Subtask(
      id: _uuid.v4(),
      title: _subtaskController.text.trim(),
      createdAt: DateTime.now(),
    );

    final updatedSubtasks = [...widget.subtasks, newSubtask];
    widget.onSubtasksChanged(updatedSubtasks);
    _subtaskController.clear();
  }

  void _toggleSubtask(int index) {
    final subtask = widget.subtasks[index];
    final updatedSubtask = subtask.copyWith(
      isCompleted: !subtask.isCompleted,
      completedAt: !subtask.isCompleted ? DateTime.now() : null,
    );

    final updatedSubtasks = List<Subtask>.from(widget.subtasks);
    updatedSubtasks[index] = updatedSubtask;
    widget.onSubtasksChanged(updatedSubtasks);
  }

  void _deleteSubtask(int index) {
    final updatedSubtasks = List<Subtask>.from(widget.subtasks);
    updatedSubtasks.removeAt(index);
    widget.onSubtasksChanged(updatedSubtasks);
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = widget.subtasks.where((s) => s.isCompleted).length;
    final totalCount = widget.subtasks.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with progress
        Row(
          children: [
            Icon(Icons.checklist_rounded, color: AppTheme.purple, size: 20.sp),
            8.horizontalSpace,
            Text(
              'Subtasks',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            if (totalCount > 0)
              Text(
                '$completedCount/$totalCount',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        12.verticalSpace,

        // Subtask list
        if (widget.subtasks.isNotEmpty) ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.subtasks.length,
            itemBuilder: (context, index) {
              final subtask = widget.subtasks[index];
              return _SubtaskTile(
                subtask: subtask,
                onToggle: () => _toggleSubtask(index),
                onDelete: () => _deleteSubtask(index),
              );
            },
          ),
          8.verticalSpace,
        ],

        // Add subtask input
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _subtaskController,
                decoration: InputDecoration(
                  hintText: 'Add a subtask...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppTheme.purple, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                onSubmitted: (_) => _addSubtask(),
              ),
            ),
            8.horizontalSpace,
            IconButton(
              onPressed: _addSubtask,
              icon: Icon(Icons.add_circle, color: AppTheme.purple),
              iconSize: 32.sp,
            ),
          ],
        ),
      ],
    );
  }
}

class _SubtaskTile extends StatelessWidget {
  final Subtask subtask;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _SubtaskTile({
    required this.subtask,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        leading: GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: subtask.isCompleted ? AppTheme.green : Colors.transparent,
              border: Border.all(
                color: subtask.isCompleted ? AppTheme.green : Colors.grey[400]!,
                width: 2,
              ),
            ),
            child:
                subtask.isCompleted
                    ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                    : null,
          ),
        ),
        title: Text(
          subtask.title,
          style: TextStyle(
            fontSize: 14.sp,
            color: subtask.isCompleted ? Colors.grey[500] : Colors.black87,
            decoration:
                subtask.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: AppTheme.red, size: 20.sp),
          onPressed: onDelete,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
}


