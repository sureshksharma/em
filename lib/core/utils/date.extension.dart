import 'package:intl/intl.dart';

extension IntExtension on int {
  String getWeekName() {
    DateTime date = DateTime.now()
        .subtract(Duration(days: DateTime.now().weekday % 7))
        .add(Duration(days: this));
    return DateFormat.E().format(date);
  }
}

extension DateExtension on DateTime {
  bool isEquivalent(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }

  String toDMMMY() {
    return DateFormat('d MMM yyyy').format(this);
  }

  String toDMMMYWithComma() {
    return DateFormat('d MMM, yyyy').format(this);
  }

  DateTime nextMondayDate() {
    int daysUntilMonday = DateTime.monday - weekday;
    if (daysUntilMonday <= 0) {
      daysUntilMonday += 7;
    }

    DateTime nextMonday = add(Duration(days: daysUntilMonday));
    return nextMonday;
  }

  String nextMonday() {
    int daysUntilMonday = DateTime.monday - weekday;
    if (daysUntilMonday <= 0) {
      daysUntilMonday += 7;
    }

    DateTime nextMonday = add(Duration(days: daysUntilMonday));
    return DateFormat('d MMM yyyy').format(nextMonday);
  }

  DateTime nextTuesdayDate() {
    int daysUntilTuesday = DateTime.tuesday - weekday;
    if (daysUntilTuesday <= 0) {
      daysUntilTuesday += 7;
    }

    DateTime nextTuesday = add(Duration(days: daysUntilTuesday));
    return nextTuesday;
  }

  String nextTuesday() {
    int daysUntilTuesday = DateTime.tuesday - weekday;
    if (daysUntilTuesday <= 0) {
      daysUntilTuesday += 7;
    }

    DateTime nextTuesday = add(Duration(days: daysUntilTuesday));
    return DateFormat('d MMM yyyy').format(nextTuesday);
  }

  String afterAWeek() {
    return DateFormat('d MMM yyyy').format(add(Duration(days: 7)));
  }
}
