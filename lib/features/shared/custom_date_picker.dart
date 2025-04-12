import 'package:em/core/utils/date.extension.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const CustomDatePicker({
    super.key,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  ValueNotifier<int?> selectedChip = ValueNotifier(null);
  DateTime? _selectedDate;
  late DateTime _focusedMonth;
  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _focusedMonth = _selectedDate ?? DateTime.now();
    _selectChip(widget.initialDate);
  }

  // Helper functions for date calculations
  DateTime _getFirstDayOfMonth(DateTime date) =>
      DateTime(date.year, date.month, 1);
  int _getDaysInMonth(DateTime date) =>
      DateTime(date.year, date.month + 1, 0).day;
  int _getDayOfWeek(DateTime date) => date.weekday % 7; // Adjust Sunday to 0

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth > 480 ? 480 : double.maxFinite,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Buttons on header
              _buildButtonOnHeader(),

              // Month navigation and header
              _buildMonthHeader(),

              // Week names header
              _buildWeekNames(),

              // Calendar grid
              _buildCalendarGrid(),

              // Bottom divider
              const SizedBox(height: 20),
              const Divider(),

              // Action buttons
              _buildActionButtons(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildButtonOnHeader() {
    return ValueListenableBuilder(
      valueListenable: selectedChip,
      builder: (_, selected, __) {
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildButton(
                    onTap: () {
                      selectedChip.value = 0;
                      setState(() {
                        _selectedDate = null;
                      });
                    },
                    title: 'No Date',
                    backgroundColor: selected == 0
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primary.withAlpha(30),
                    textColor: selected == 0
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildButton(
                    onTap: () {
                      selectedChip.value = 1;
                      setState(() {
                        _selectedDate = DateTime.now();
                      });
                    },
                    title: 'Today',
                    backgroundColor: selected == 1
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primary.withAlpha(30),
                    textColor: selected == 1
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildButton(
                    onTap: () {
                      selectedChip.value = 2;
                      setState(() {
                        _selectedDate = DateTime.now().nextMondayDate();
                      });
                    },
                    title: 'Next Monday',
                    backgroundColor: selected == 2
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primary.withAlpha(30),
                    textColor: selected == 2
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildButton(
                    onTap: () {
                      selectedChip.value = 3;
                      setState(() {
                        _selectedDate = DateTime.now().nextTuesdayDate();
                      });
                    },
                    title: 'Next Tuesday',
                    backgroundColor: selected == 3
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primary.withAlpha(30),
                    textColor: selected == 3
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton({
    required VoidCallback onTap,
    required String title,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: backgroundColor ??
              Theme.of(context).colorScheme.primary.withAlpha(30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Icon(
            Icons.arrow_left_rounded,
            color: _focusedMonth.month > widget.firstDate.month
                ? Colors.grey[700]
                : Colors.grey,
            size: 45,
          ),
          onTap: () {
            if (_focusedMonth.month > widget.firstDate.month) {
              setState(() {
                _focusedMonth =
                    DateTime(_focusedMonth.year, _focusedMonth.month - 1);
              });
            }
          },
        ),
        SizedBox(width: 5),
        Text(
          '${_focusedMonth.year} ${monthNames[_focusedMonth.month - 1]}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 5),
        InkWell(
          child: Icon(
            Icons.arrow_right_rounded,
            color: _focusedMonth.month < widget.lastDate.month
                ? Colors.grey[700]
                : Colors.grey,
            size: 45,
          ),
          onTap: () {
            if (_focusedMonth.month < widget.lastDate.month) {
              setState(() {
                _focusedMonth =
                    DateTime(_focusedMonth.year, _focusedMonth.month + 1);
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildWeekNames() {
    List<Widget> dayWidgets = [];
    for (int i = 0; i < 7; i++) {
      dayWidgets.add(
        Container(
          padding: EdgeInsets.all(8),
          decoration: null,
          child: Text(
            i.getWeekName(),
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      children: dayWidgets,
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = _getFirstDayOfMonth(_focusedMonth);
    final daysInMonth = _getDaysInMonth(_focusedMonth);
    final firstDayOfWeek = _getDayOfWeek(firstDayOfMonth);

    List<Widget> dayWidgets = [];
    for (int i = 0; i < firstDayOfWeek; i++) {
      dayWidgets.add(Container()); // Empty placeholders for days before the 1st
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final currentDate =
          DateTime(_focusedMonth.year, _focusedMonth.month, day);
      final isSelected = _selectedDate != null &&
          _selectedDate!.year == currentDate.year &&
          _selectedDate!.month == currentDate.month &&
          _selectedDate!.day == currentDate.day;
      dayWidgets.add(
        GestureDetector(
          onTap: () {
            if (_canSelectDate(currentDate)) {
              setState(() {
                _selectedDate = currentDate;
                _selectChip(currentDate);
              });
            }
          },
          child: Container(
            margin: EdgeInsets.all(4),
            alignment: Alignment.center,
            decoration: isSelected
                ? BoxDecoration(shape: BoxShape.circle, color: Colors.blue)
                : null,
            child: Text(
              '$day',
              style: TextStyle(
                fontSize: 16,
                color: !_canSelectDate(currentDate)
                    ? Colors.grey
                    : isSelected
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      children: dayWidgets,
    );
  }

  bool _canSelectDate(DateTime currentDate) {
    return (currentDate.isEquivalent(widget.firstDate) ||
            currentDate.isAfter(widget.firstDate)) &&
        (currentDate.isBefore(widget.lastDate) ||
            currentDate.isEquivalent(widget.lastDate));
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_month,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width: 10),
            Text(
              _selectedDate == null ? 'No Date' : _selectedDate!.toDMMMY(),
            ),
          ],
        ),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withAlpha(30),
          ),
          onPressed: () {
            Navigator.of(context).pop(null); // Return without date
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
          ),
          onPressed: () {
            Navigator.of(context).pop(_selectedDate); // Return selected date
          },
          child: Text(
            'Save',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  void _selectChip(DateTime? date) {
    if (date == null) {
      selectedChip.value = 0;
    } else if (date.isEquivalent(DateTime.now())) {
      selectedChip.value = 1;
    } else if (date.isEquivalent(DateTime.now().nextMondayDate())) {
      selectedChip.value = 2;
    } else if (date.isEquivalent(DateTime.now().nextTuesdayDate())) {
      selectedChip.value = 3;
    } else {
      selectedChip.value = null;
    }
  }
}
