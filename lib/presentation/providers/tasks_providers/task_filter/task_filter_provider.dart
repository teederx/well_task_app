import 'package:flutter/material.dart'; // For DateRange
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../data/models/task_model/task_enums.dart';
import '../../../../data/models/task_model/task_model.dart';
import '../task_list/task_list_provider.dart';

part 'task_filter_provider.g.dart';

@riverpod
class TaskFilter extends _$TaskFilter {
  @override
  TaskFilterState build() {
    return TaskFilterState();
  }

  void setCategory(TaskCategory? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setPriority(TaskPriority? priority) {
    state = state.copyWith(selectedPriority: priority);
  }

  void setDateRange(DateTimeRange? range) {
    state = state.copyWith(selectedDateRange: range);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void toggleTag(String tag) {
    final currentTags = List<String>.from(state.selectedTags);
    if (currentTags.contains(tag)) {
      currentTags.remove(tag);
    } else {
      currentTags.add(tag);
    }
    state = state.copyWith(selectedTags: currentTags);
  }

  void clearFilters() {
    state = TaskFilterState();
  }
}

class TaskFilterState {
  final TaskCategory? selectedCategory;
  final TaskPriority? selectedPriority;
  final DateTimeRange? selectedDateRange;
  final String searchQuery;
  final List<String> selectedTags;

  TaskFilterState({
    this.selectedCategory,
    this.selectedPriority,
    this.selectedDateRange,
    this.searchQuery = '',
    this.selectedTags = const [],
  });

  TaskFilterState copyWith({
    TaskCategory? selectedCategory,
    TaskPriority? selectedPriority,
    DateTimeRange? selectedDateRange,
    String? searchQuery,
    List<String>? selectedTags,
  }) {
    return TaskFilterState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTags: selectedTags ?? this.selectedTags,
    );
  }
}

@riverpod
Future<List<TaskModel>> filteredTaskList(FilteredTaskListRef ref) async {
  final taskListAsync = ref.watch(taskListProvider);
  final filterState = ref.watch(taskFilterProvider);

  return taskListAsync.when(
    data: (tasks) {
      return tasks.where((task) {
        // 1. Filter by Category
        if (filterState.selectedCategory != null &&
            task.category != filterState.selectedCategory) {
          return false;
        }

        // 2. Filter by Search Query
        if (filterState.searchQuery.isNotEmpty) {
          final query = filterState.searchQuery.toLowerCase();
          final titleMatch = task.title.toLowerCase().contains(query);
          final descMatch =
              task.description?.toLowerCase().contains(query) ?? false;
          if (!titleMatch && !descMatch) {
            return false;
          }
        }

        // 3. Filter by Tags
        if (filterState.selectedTags.isNotEmpty) {
          if (!filterState.selectedTags.every(
            (tag) => task.tags.contains(tag),
          )) {
            return false;
          }
        }

        // 4. Filter by Priority
        if (filterState.selectedPriority != null &&
            task.priority != filterState.selectedPriority) {
          return false;
        }

        // 5. Filter by Date Range
        if (filterState.selectedDateRange != null) {
          final start = filterState.selectedDateRange!.start;
          final end = filterState.selectedDateRange!.end.add(
            const Duration(days: 1),
          ); // End of day

          if (task.dueDate.isBefore(start) || task.dueDate.isAfter(end)) {
            return false;
          }
        }

        return true;
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
}
