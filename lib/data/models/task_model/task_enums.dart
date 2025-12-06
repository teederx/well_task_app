import 'package:flutter/material.dart';

enum TaskCategory {
  work,
  personal,
  health,
  shopping,
  study,
  finance,
  social,
  travel,
  other;

  String get label {
    switch (this) {
      case TaskCategory.work:
        return 'Work';
      case TaskCategory.personal:
        return 'Personal';
      case TaskCategory.health:
        return 'Health';
      case TaskCategory.shopping:
        return 'Shopping';
      case TaskCategory.study:
        return 'Study';
      case TaskCategory.finance:
        return 'Finance';
      case TaskCategory.social:
        return 'Social';
      case TaskCategory.travel:
        return 'Travel';
      case TaskCategory.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case TaskCategory.work:
        return Icons.work_rounded;
      case TaskCategory.personal:
        return Icons.person_rounded;
      case TaskCategory.health:
        return Icons.favorite_rounded;
      case TaskCategory.shopping:
        return Icons.shopping_cart_rounded;
      case TaskCategory.study:
        return Icons.school_rounded;
      case TaskCategory.finance:
        return Icons.attach_money_rounded;
      case TaskCategory.social:
        return Icons.people_rounded;
      case TaskCategory.travel:
        return Icons.flight_rounded;
      case TaskCategory.other:
        return Icons.category_rounded;
    }
  }

  Color get color {
    switch (this) {
      case TaskCategory.work:
        return Colors.blue;
      case TaskCategory.personal:
        return Colors.purple;
      case TaskCategory.health:
        return Colors.red;
      case TaskCategory.shopping:
        return Colors.orange;
      case TaskCategory.study:
        return Colors.indigo;
      case TaskCategory.finance:
        return Colors.green;
      case TaskCategory.social:
        return Colors.pink;
      case TaskCategory.travel:
        return Colors.teal;
      case TaskCategory.other:
        return Colors.grey;
    }
  }
}

enum RecurringType {
  none,
  daily,
  weekly,
  monthly;

  String get label {
    switch (this) {
      case RecurringType.none:
        return 'Does not repeat';
      case RecurringType.daily:
        return 'Every day';
      case RecurringType.weekly:
        return 'Every week';
      case RecurringType.monthly:
        return 'Every month';
    }
  }
}
