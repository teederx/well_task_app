import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';
import '../../../../domain/entities/task.dart';
import '../../../providers/tasks_providers/task_list/task_list_provider.dart';
import '../main_screen/widget/upcoming_task_tile.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<Task> _getTasksForDay(List<Task> allTasks, DateTime day) {
    return allTasks.where((task) {
      return isSameDay(task.dueDate, day);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final taskListAsync = ref.watch(taskListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background
      appBar: AppBar(
        title: Text(
          'Calendar',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: taskListAsync.when(
        data: (allTasks) {
          final selectedTasks = _getTasksForDay(allTasks, _selectedDay!);

          return Column(
            children: [
              // Calendar
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TableCalendar<Task>(
                  firstDay: DateTime.utc(2020, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  eventLoader: (day) {
                    return _getTasksForDay(allTasks, day);
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: AppTheme.purple.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: AppTheme.purple,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: AppTheme.green, // Green dots for tasks
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    titleCentered: true,
                    formatButtonShowsNext: false,
                    formatButtonDecoration: BoxDecoration(
                      border: Border.all(color: AppTheme.purple),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    formatButtonTextStyle: TextStyle(color: AppTheme.purple),
                  ),
                ),
              ),
              20.verticalSpace,
              // Task List
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tasks for ${_selectedDay!.day}/${_selectedDay!.month}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      10.verticalSpace,
                      if (selectedTasks.isEmpty)
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.event_available_rounded,
                                  size: 64.sp,
                                  color: Colors.grey.withValues(alpha: 0.5),
                                ),
                                10.verticalSpace,
                                Text(
                                  'No tasks for this day',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: ListView.separated(
                            itemCount: selectedTasks.length,
                            separatorBuilder:
                                (context, index) => 10.verticalSpace,
                            itemBuilder: (context, index) {
                              final task = selectedTasks[index];
                              return UpcomingTaskTile(
                                id: task.id,
                                title: task.title,
                                description: task.description ?? '',
                                dateTime: task.dueDate,
                                priority: task.priority,
                                onTap: () {
                                  // Navigate to view task
                                },
                                onComplete: () {
                                  ref
                                      .read(taskListProvider.notifier)
                                      .toggleComplete(id: task.id);
                                },
                                onDelete: () {
                                  ref
                                      .read(taskListProvider.notifier)
                                      .removeTask(id: task.id);
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, stack) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}


