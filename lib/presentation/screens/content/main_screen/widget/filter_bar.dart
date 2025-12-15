import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:well_task_app/domain/entities/task_enums.dart';

import 'package:well_task_app/core/utils/constants/app_theme.dart';
import 'package:well_task_app/core/utils/constants/priority_constants.dart';
import '../../../../providers/tasks_providers/task_filter/task_filter_provider.dart';
import '../../../../providers/tasks_providers/task_list/task_list_provider.dart';

class FilterBar extends ConsumerWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(taskFilterProvider);
    final filterNotifier = ref.read(taskFilterProvider.notifier);
    final tasksAsync = ref.watch(taskListProvider);
    final tags = tasksAsync.maybeWhen(
      data: (tasks) => tasks.expand((t) => t.tags).toSet().toList()..sort(),
      orElse: () => <String>[],
    );

    return Column(
      children: [
        // Category Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Priority Filter
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: PopupMenuButton<TaskPriority?>(
                  initialValue: filterState.selectedPriority,
                  tooltip: 'Filter by Priority',
                  onSelected: (TaskPriority? priority) {
                    filterNotifier.setPriority(priority);
                  },
                  itemBuilder:
                      (BuildContext context) => <PopupMenuEntry<TaskPriority?>>[
                        const PopupMenuItem<TaskPriority?>(
                          value: null,
                          child: Text('All Priorities'),
                        ),
                        ...TaskPriority.values.map(
                          (priority) => PopupMenuItem<TaskPriority?>(
                            value: priority,
                            child: Text(
                              PriorityConstants.getPriorityLabel(priority),
                            ),
                          ),
                        ),
                      ],
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          filterState.selectedPriority != null
                              ? PriorityConstants.getPriorityColor(
                                filterState.selectedPriority!,
                              )
                              : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color:
                            filterState.selectedPriority != null
                                ? Colors.transparent
                                : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          size: 16.sp,
                          color:
                              filterState.selectedPriority != null
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        if (filterState.selectedPriority != null) ...[
                          6.horizontalSpace,
                          Text(
                            PriorityConstants.getPriorityLabel(
                              filterState.selectedPriority!,
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              // Date Filter
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: GestureDetector(
                  onTap: () async {
                    final DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      initialDateRange: filterState.selectedDateRange,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: AppTheme.purple,
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      filterNotifier.setDateRange(picked);
                    } else if (filterState.selectedDateRange != null) {
                      // Optional: Clear date filter if cancelled? Or maybe add a "Clear Date" option?
                      // For now, let's keep it simple: tap to set. To clear, we need a clear button.
                    }
                  },
                  onLongPress: () {
                    // Long press to clear date
                    filterNotifier.setDateRange(null);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          filterState.selectedDateRange != null
                              ? AppTheme.purple
                              : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color:
                            filterState.selectedDateRange != null
                                ? Colors.transparent
                                : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 16.sp,
                          color:
                              filterState.selectedDateRange != null
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        if (filterState.selectedDateRange != null) ...[
                          6.horizontalSpace,
                          Text(
                            '${filterState.selectedDateRange!.start.day}/${filterState.selectedDateRange!.start.month} - ${filterState.selectedDateRange!.end.day}/${filterState.selectedDateRange!.end.month}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              // All Categories
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: FilterChip(
                  label: Text('All'),
                  selected: filterState.selectedCategory == null,
                  onSelected: (selected) {
                    if (selected) {
                      filterNotifier.setCategory(null);
                    }
                  },
                  backgroundColor: Colors.white,
                  selectedColor: AppTheme.purple,
                  labelStyle: TextStyle(
                    color:
                        filterState.selectedCategory == null
                            ? Colors.white
                            : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    side: BorderSide(
                      color:
                          filterState.selectedCategory == null
                              ? Colors.transparent
                              : Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
              ...TaskCategory.values.map((category) {
                final isSelected = filterState.selectedCategory == category;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: FilterChip(
                    label: Text(category.label),
                    selected: isSelected,
                    onSelected: (selected) {
                      filterNotifier.setCategory(selected ? category : null);
                    },
                    backgroundColor: Colors.white,
                    selectedColor: category.color,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide(
                        color:
                            isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        10.verticalSpace,
        if (tags.isNotEmpty) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                FilterChip(
                  label: const Text('All Tags'),
                  selected: filterState.selectedTags.isEmpty,
                  onSelected: (selected) {
                    if (selected) {
                      filterNotifier.setTags([]);
                    }
                  },
                  backgroundColor: Colors.white,
                  selectedColor: AppTheme.purple,
                  labelStyle: TextStyle(
                    color:
                        filterState.selectedTags.isEmpty
                            ? Colors.white
                            : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    side: BorderSide(
                      color:
                          filterState.selectedTags.isEmpty
                              ? Colors.transparent
                              : Colors.grey.shade300,
                    ),
                  ),
                ),
                ...tags.map((tag) {
                  final isSelected = filterState.selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        filterNotifier.toggleTag(tag);
                      } else {
                        filterNotifier.toggleTag(tag);
                      }
                    },
                    backgroundColor: Colors.white,
                    selectedColor: AppTheme.purple,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide(
                        color:
                            isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          10.verticalSpace,
        ],
        // Search Field
        TextField(
          onChanged: (value) => filterNotifier.setSearchQuery(value),
          decoration: InputDecoration(
            hintText: 'Search tasks...',
            prefixIcon: Icon(Icons.search, color: AppTheme.purple),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: AppTheme.purple, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}


