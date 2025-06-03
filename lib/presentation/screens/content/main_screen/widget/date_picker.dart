import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../providers/tasks_providers/selected_date/selected_date_provider.dart';
import 'animated_date_container.dart';

class DatePickerScreen extends ConsumerStatefulWidget {
  const DatePickerScreen({super.key});

  @override
  ConsumerState<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends ConsumerState<DatePickerScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  void _scrollToSelectedDate() {
    final selectedDate = ref.read(selectedDateProvider);
    final now = DateTime.now();
    final difference = selectedDate.difference(now).inDays;

    // Cap index to [0, 29] range
    final index = difference.clamp(0, 29);
    final offset = index * 60.w; // Adjust based on item width + margin

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didUpdateWidget(covariant DatePickerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scrollToSelectedDate();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);

    final List<DateTime> dates = List.generate(
      30,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    final formattedSelectedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          bool isSelected =
              DateFormat('yyyy-MM-dd').format(date) == formattedSelectedDate;

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.elasticOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: AnimatedDateContainer(
              key: ValueKey('${date.toIso8601String()}-$isSelected'),
              date: date,
              isSelected: isSelected,
              onTap: () {
                ref.read(selectedDateProvider.notifier).setDate(date);
                _scrollToSelectedDate(); // scroll to date on tap
              },
            ),
          );
        },
      ),
    );
  }
}
