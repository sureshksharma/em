import 'package:em/core/utils/date.extension.dart';
import 'package:flutter/material.dart';

import '../../features/shared/custom_date_picker.dart';

class DateHelper {
  static String getDate(DateTime? date) {
    if (date?.toDMMMY() == DateTime.now().toDMMMY()) {
      return 'Today';
    } else if (date?.toDMMMY() == DateTime.now().nextMonday()) {
      return 'Next Monday';
    } else if (date?.toDMMMY() == DateTime.now().nextTuesday()) {
      return 'Next Tuesday';
    } else if (date?.toDMMMY() == DateTime.now().afterAWeek()) {
      return 'After 1 week';
    } else {
      return date?.toDMMMY() ?? '';
    }
  }

  static Future<DateTime?> selectDate(BuildContext context,
      {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    return showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return CustomDatePicker(
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2022, 1, 1),
          lastDate: lastDate ?? DateTime(2025, 5, 31),
        );
      },
    );
  }
}
