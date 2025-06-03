import 'package:intl/intl.dart';

String formatTime(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime).toLowerCase();
}

String formatShortDate(DateTime dateTime) {
  return DateFormat('MMM dd').format(dateTime);
}

String formatDateTime(DateTime dt) {
  final today = DateTime.now().day;

  final day = dt.day;
  final suffix = _getDaySuffix(day);
  final month = DateFormat('MMM').format(dt);
  final year = dt.year;
  final time = DateFormat('h:mma').format(dt).toLowerCase();

  if (day == today) {
    return 'Today at $time';
  } else if (day == today - 1) {
    return 'Yesterday at $time';
  } else if (day == today + 1) {
    return 'Tomorrow at $time';
  } else {
    return '$day$suffix of $month, $year at $time';
  }
}

String _getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
