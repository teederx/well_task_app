import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/models/task_model/task_model.dart';
import '../../../../utils/config/alarms_services.dart';
import '../../../../utils/config/formatted_date_time.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../providers/tasks_providers/get_a_task/task_provider.dart';
import '../../../providers/tasks_providers/task_list/task_list_provider.dart';
import '../main_screen/main_screen.dart';
import 'widget/add_task_field.dart';
import 'widget/select_date.dart';

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
  late DateTime dateTime;
  bool _isInitialized = false;
  late PageType _currentPageType;

  @override
  void initState() {
    _taskNameController = TextEditingController();
    _taskDescriptionController = TextEditingController();
    _dateController = TextEditingController();
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
    super.dispose();
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
          );
    } else if (_currentPageType == PageType.editTask) {
      _scheduleTaskOrNot(_scheduleTask);
      ref
          .read(taskListProvider.notifier)
          .editTask(
            id: id,
            title: _taskNameController.text,
            desc: _taskDescriptionController.text,
            dueDate: dateTime,
            alarmSet: _scheduleTask,
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
    } else {
      id = uuid.v4();
      notId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      dateTime = DateTime.now();
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
                        activeColor: AppTheme.purple,
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
}
