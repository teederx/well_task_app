import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/models/task_model/task_model.dart' hide uuid;
import '../../../../data/models/task_model/task_enums.dart';
import '../../../../data/models/subtask_model/subtask_model.dart';

import 'package:image_picker/image_picker.dart';
import 'package:well_task_app/data/services/attachment_service.dart';
import '../../../../data/models/attachment_model/attachment_model.dart';
import 'widgets/attachment_list_widget.dart';
import '../../../../utils/config/alarms_services.dart';
import '../../../../utils/config/formatted_date_time.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/priority_constants.dart';
import '../../../providers/tasks_providers/get_a_task/task_provider.dart';
import '../../../providers/tasks_providers/task_list/task_list_provider.dart';
import '../main_screen/main_screen.dart';
import 'widget/add_task_field.dart';
import 'widget/select_date.dart';
import 'widgets/subtask_list.dart';
import '../../../../data/models/time_log_model/time_log_model.dart';
import 'widgets/time_tracker_widget.dart';

final notificationService = AlarmServicesImpl();

class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({super.key, this.id, required this.pageType});

  final PageType pageType;
  final String? id;

  @override
  ConsumerState<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<TaskPage> {
  late String id;
  late int notId;
  late TextEditingController _taskNameController;
  late TextEditingController _taskDescriptionController;
  late TextEditingController _dateController;
  final _formKey = GlobalKey<FormState>();
  bool _scheduleTask = false;
  bool _remind5MinEarly = false;
  TaskPriority _selectedPriority = TaskPriority.medium;
  late DateTime dateTime;
  bool _isInitialized = false;
  late PageType _currentPageType;
  TaskCategory _selectedCategory = TaskCategory.other;
  List<String> _tags = [];
  final TextEditingController _tagController = TextEditingController();
  RecurringType _recurringType = RecurringType.none;
  int _recurringInterval = 1;
  late TextEditingController _recurringIntervalController;
  List<SubtaskModel> _subtasks = [];
  int _totalTimeSpent = 0;
  List<TimeLogModel> _timeLogs = [];
  DateTime? _timerStartedAt;
  bool _isTimerRunning = false;
  List<AttachmentModel> _attachments = [];
  final AttachmentService _attachmentService = AttachmentService();

  @override
  void initState() {
    _taskNameController = TextEditingController();
    _taskDescriptionController = TextEditingController();
    _dateController = TextEditingController();
    _recurringIntervalController = TextEditingController(text: '1');
    _currentPageType = widget.pageType;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      setTask();
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    _dateController.dispose();
    _tagController.dispose();
    _recurringIntervalController.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final attachment = await _attachmentService.pickImage(source);
    if (attachment != null) {
      setState(() {
        _attachments.add(attachment);
      });
    }
  }

  Future<void> _pickFile() async {
    final attachment = await _attachmentService.pickFile();
    if (attachment != null) {
      setState(() {
        _attachments.add(attachment);
      });
    }
  }

  void _deleteAttachment(AttachmentModel attachment) {
    setState(() {
      _attachments.remove(attachment);
    });
    _attachmentService.deleteAttachment(attachment);
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_file),
                title: const Text('File'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime combined = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _dateController.text = formatDateTime(combined);
          dateTime = combined;
        });
      }
    }
  }

  void _scheduleTaskOrNot(bool value) {
    if (value) {
      notificationService.scheduleTaskNotification(
        dateTime: dateTime,
        id: id,
        notificationId: notId,
        title: _taskNameController.text,
        desc: _taskDescriptionController.text,
        context: context,
        remind5MinEarly: _remind5MinEarly,
      );
    } else {
      notificationService.cancelTaskNotification(
        notificationId: notId,
        dateTime: dateTime,
        title: _taskNameController.text,
        context: context,
      );
    }
  }

  void save() {
    if (_currentPageType == PageType.addTask) {
      _scheduleTaskOrNot(_scheduleTask);
      ref
          .read(taskListProvider.notifier)
          .addTask(
            id: id,
            notId: notId,
            title: _taskNameController.text,
            desc: _taskDescriptionController.text,
            dueDate: dateTime,
            alarmSet: _scheduleTask,
            remind5MinEarly: _remind5MinEarly,
            priority: _selectedPriority,
            category: _selectedCategory,
            tags: _tags,
            recurringType: _recurringType,
            recurringInterval: _recurringInterval,

            subtasks: _subtasks,
            totalTimeSpent: _totalTimeSpent,
            timeLogs: _timeLogs,
            timerStartedAt: _timerStartedAt,
            isTimerRunning: _isTimerRunning,
            attachments: _attachments,
          );
    } else if (_currentPageType == PageType.editTask ||
        _currentPageType == PageType.viewTask) {
      _scheduleTaskOrNot(_scheduleTask);
      ref
          .read(taskListProvider.notifier)
          .editTask(
            id: id,
            title: _taskNameController.text,
            desc: _taskDescriptionController.text,
            dueDate: dateTime,
            alarmSet: _scheduleTask,
            remind5MinEarly: _remind5MinEarly,
            priority: _selectedPriority,
            category: _selectedCategory,
            tags: _tags,
            recurringType: _recurringType,
            recurringInterval: _recurringInterval,

            subtasks: _subtasks,
            totalTimeSpent: _totalTimeSpent,
            timeLogs: _timeLogs,
            timerStartedAt: _timerStartedAt,
            isTimerRunning: _isTimerRunning,
            attachments: _attachments,
          );
    }
  }

  TaskModel fetchTask() {
    return ref.watch(taskProvider(id: widget.id!));
  }

  void setTask() {
    if (widget.pageType != PageType.addTask && widget.id != null) {
      final task = fetchTask();
      _dateController.text = formatDateTime(task.dueDate);
      _taskNameController.text = task.title;
      _taskDescriptionController.text = task.description ?? '';
      notId = task.notificationId;
      dateTime = task.dueDate;
      id = task.id;
      _scheduleTask = task.alarmSet;
      _remind5MinEarly = task.remind5MinEarly;
      _selectedPriority = task.priority;
      _selectedCategory = task.category;
      _tags = List.from(task.tags);
      _recurringType = task.recurringType;
      _recurringInterval = task.recurringInterval;
      _recurringIntervalController.text = task.recurringInterval.toString();
      _subtasks = List.from(task.subtasks);
      _totalTimeSpent = task.totalTimeSpent;
      _timeLogs = List.from(task.timeLogs);
      _timerStartedAt = task.timerStartedAt;
      _isTimerRunning = task.isTimerRunning;
      _attachments = List.from(task.attachments);
    } else {
      id = uuid.v4();
      notId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      dateTime = DateTime.now();
      _selectedPriority = TaskPriority.medium;
      _selectedCategory = TaskCategory.other;
      _tags = [];
      _recurringType = RecurringType.none;
      _recurringInterval = 1;
      _totalTimeSpent = 0;
      _timeLogs = [];
      _timerStartedAt = null;
      _isTimerRunning = false;
      _attachments = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isViewOnly = _currentPageType == PageType.viewTask;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        'assets/svg/icons/Arrow - Left.svg',
                      ),
                    ),
                    30.horizontalSpace,
                    Text(
                      _currentPageType == PageType.addTask
                          ? 'Add Task'
                          : _currentPageType == PageType.editTask
                          ? 'Edit Task'
                          : 'View Task',
                      style: TextStyle(
                        fontFamily: 'Optician',
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (_currentPageType == PageType.viewTask) ...[
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.edit, color: AppTheme.purple),
                        onPressed: () {
                          setState(() => _currentPageType = PageType.editTask);
                        },
                      ),
                    ],
                  ],
                ),
                10.verticalSpace,
                AddTaskField(
                  iconData: Icons.assignment_rounded,
                  controller: _taskNameController,
                  hintText: 'Enter task name',
                  labelText: 'Task name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task name';
                    }
                    return null;
                  },
                  pageType: _currentPageType,
                ),
                20.verticalSpace,
                AddTaskField(
                  iconData: Icons.description_rounded,
                  controller: _taskDescriptionController,
                  hintText: 'Enter task description',
                  labelText: 'Task description',
                  maxLines: 3,
                  pageType: _currentPageType,
                ),
                20.verticalSpace,
                // Category Selector
                _buildCategorySelector(isViewOnly),
                20.verticalSpace,
                // Tags Input
                _buildTagsInput(isViewOnly),
                20.verticalSpace,
                // Time Tracker
                if (_currentPageType == PageType.editTask ||
                    _currentPageType == PageType.viewTask) ...[
                  TimeTrackerWidget(
                    task: fetchTask(),
                    onTimerChanged: (
                      isRunning,
                      startTime,
                      totalDuration,
                      logs,
                    ) {
                      setState(() {
                        _isTimerRunning = isRunning;
                        _timerStartedAt = startTime;
                        _totalTimeSpent = totalDuration;
                        _timeLogs = logs;
                      });
                      // Auto-save when timer toggles
                      save();
                    },
                  ),
                  20.verticalSpace,
                ],
                // Subtasks
                if (!isViewOnly) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppTheme.purple.withValues(alpha: 0.2),
                      ),
                    ),
                    child: SubtaskList(
                      subtasks: _subtasks,
                      onSubtasksChanged: (updatedSubtasks) {
                        setState(() {
                          _subtasks = updatedSubtasks;
                        });
                      },
                    ),
                  ),
                  20.verticalSpace,
                ],
                // Attachments
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppTheme.purple.withValues(alpha: 0.2),
                    ),
                  ),
                  child: AttachmentListWidget(
                    attachments: _attachments,
                    onDelete: isViewOnly ? (a) {} : _deleteAttachment,
                    onAddAttachment:
                        isViewOnly ? () {} : _showAttachmentOptions,
                  ),
                ),
                20.verticalSpace,
                // Recurring Selector
                if (!isViewOnly) ...[
                  _buildRecurringSelector(),
                  20.verticalSpace,
                ],
                // Priority Selector
                if (!isViewOnly) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppTheme.purple.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flag_outlined,
                              color: AppTheme.purple,
                              size: 20.sp,
                            ),
                            8.horizontalSpace,
                            Text(
                              'Priority',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.purple,
                              ),
                            ),
                          ],
                        ),
                        12.verticalSpace,
                        SegmentedButton<TaskPriority>(
                          segments: [
                            ButtonSegment(
                              value: TaskPriority.low,
                              label: Text('Low'),
                              icon: Icon(Icons.arrow_downward, size: 16.sp),
                            ),
                            ButtonSegment(
                              value: TaskPriority.medium,
                              label: Text('Medium'),
                              icon: Icon(Icons.drag_handle, size: 16.sp),
                            ),
                            ButtonSegment(
                              value: TaskPriority.high,
                              label: Text('High'),
                              icon: Icon(Icons.arrow_upward, size: 16.sp),
                            ),
                          ],
                          selected: {_selectedPriority},
                          onSelectionChanged: (Set<TaskPriority> newSelection) {
                            setState(() {
                              _selectedPriority = newSelection.first;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith<
                              Color
                            >((states) {
                              if (states.contains(WidgetState.selected)) {
                                if (_selectedPriority == TaskPriority.low) {
                                  return Colors.green;
                                }
                                if (_selectedPriority == TaskPriority.medium) {
                                  return Colors.orange;
                                }
                                return Colors.red;
                              }
                              return Colors.grey.shade200;
                            }),
                            foregroundColor:
                                WidgetStateProperty.resolveWith<Color>((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.selected)) {
                                    return Colors.white;
                                  }
                                  return Colors.black87;
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                ],
                // View Mode Priority Display
                if (isViewOnly) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppTheme.purple.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag,
                          color: PriorityConstants.getPriorityColor(
                            _selectedPriority,
                          ),
                          size: 20.sp,
                        ),
                        10.horizontalSpace,
                        Text(
                          'Priority:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        8.horizontalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: PriorityConstants.getPriorityColor(
                              _selectedPriority,
                            ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: PriorityConstants.getPriorityColor(
                                _selectedPriority,
                              ),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            PriorityConstants.getPriorityLabel(
                              _selectedPriority,
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: PriorityConstants.getPriorityColor(
                                _selectedPriority,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                ],
                SelectDate(
                  controller: _dateController,
                  onTap: isViewOnly ? () {} : () => _selectDateTime(context),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      isViewOnly
                          ? _scheduleTask
                              ? 'Task Notification Scheduled'
                              : 'Task Notification Not Scheduled'
                          : 'Schedule Notification',
                      style: TextStyle(
                        color:
                            isViewOnly
                                ? _scheduleTask
                                    ? AppTheme.green
                                    : AppTheme.red
                                : AppTheme.purple,
                      ),
                    ),
                    if (!isViewOnly) ...[
                      10.horizontalSpace,
                      Switch.adaptive(
                        activeTrackColor: AppTheme.purple,
                        inactiveTrackColor: AppTheme.latte,
                        inactiveThumbColor: AppTheme.pink,
                        value: _scheduleTask,
                        onChanged: (value) {
                          setState(() => _scheduleTask = value);
                        },
                      ),
                    ],
                  ],
                ),
                if (_scheduleTask && !isViewOnly) ...[
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Remind 5 minutes early',
                        style: TextStyle(color: AppTheme.purple),
                      ),
                      Checkbox(
                        value: _remind5MinEarly,
                        activeColor: AppTheme.purple,
                        onChanged: (value) {
                          setState(() {
                            _remind5MinEarly = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
                if (!isViewOnly) 20.verticalSpace,
                if (!isViewOnly)
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        save();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: AppTheme.purple,
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                        horizontal: 30.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      _currentPageType == PageType.addTask
                          ? 'Create New Task'
                          : 'Save Changes',
                      style: TextStyle(
                        fontFamily: 'Optician',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecurringSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.repeat_rounded, color: AppTheme.purple, size: 20.sp),
            8.horizontalSpace,
            Text(
              'Recurring Task',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.purple,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppTheme.purple.withValues(alpha: 0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<RecurringType>(
              value: _recurringType,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: AppTheme.purple),
              items:
                  RecurringType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(
                        type.label,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _recurringType = value);
                }
              },
            ),
          ),
        ),
        if (_recurringType != RecurringType.none) ...[
          12.verticalSpace,
          Row(
            children: [
              Text(
                'Interval:',
                style: TextStyle(color: Colors.black87, fontSize: 14.sp),
              ),
              10.horizontalSpace,
              Container(
                width: 80.w,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  controller: _recurringIntervalController,
                  onChanged: (val) {
                    setState(() {
                      _recurringInterval = int.tryParse(val) ?? 1;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildCategorySelector(bool isViewOnly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.category_outlined, color: AppTheme.purple, size: 20.sp),
            8.horizontalSpace,
            Text(
              'Category',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.purple,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        if (isViewOnly)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: _selectedCategory.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: _selectedCategory.color),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _selectedCategory.icon,
                  size: 18.sp,
                  color: _selectedCategory.color,
                ),
                8.horizontalSpace,
                Text(
                  _selectedCategory.label,
                  style: TextStyle(
                    color: _selectedCategory.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  TaskCategory.values.map((category) {
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category.icon,
                              size: 16.sp,
                              color: isSelected ? Colors.white : category.color,
                            ),
                            6.horizontalSpace,
                            Text(category.label),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        selectedColor: category.color,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color:
                              isSelected
                                  ? Colors.transparent
                                  : Colors.grey.shade300,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildTagsInput(bool isViewOnly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.label_outline_rounded,
              color: AppTheme.purple,
              size: 20.sp,
            ),
            8.horizontalSpace,
            Text(
              'Tags',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.purple,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        if (!isViewOnly) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppTheme.purple.withValues(alpha: 0.5)),
            ),
            child: TextField(
              controller: _tagController,
              decoration: InputDecoration(
                hintText: 'Add a tag...',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.add_circle, color: AppTheme.purple),
                  onPressed: () => _addTag(_tagController.text.trim()),
                ),
              ),
              onSubmitted: (value) => _addTag(value.trim()),
            ),
          ),
          10.verticalSpace,
        ],
        if (_tags.isNotEmpty)
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children:
                _tags.map((tag) {
                  return InputChip(
                    label: Text(tag),
                    deleteIcon:
                        isViewOnly ? null : Icon(Icons.close, size: 16.sp),
                    onDeleted: isViewOnly ? null : () => _removeTag(tag),
                    backgroundColor: AppTheme.purple.withValues(alpha: 0.1),
                    labelStyle: TextStyle(color: AppTheme.purple),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide(
                        color: AppTheme.purple.withValues(alpha: 0.3),
                      ),
                    ),
                  );
                }).toList(),
          )
        else if (isViewOnly)
          Text(
            'No tags',
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          ),
      ],
    );
  }
}
