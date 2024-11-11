import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late final ValueNotifier<DateTime> _focusedDay;
  late final ValueNotifier<DateTime?> _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = ValueNotifier(DateTime.now());
    _selectedDay = ValueNotifier(null);
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay.value,
      selectedDayPredicate: (day) => isSameDay(_selectedDay.value, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay.value = selectedDay;
          _focusedDay.value = focusedDay;
        });
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: const TextStyle(color: Colors.red), // 주말 텍스트 색상 변경 (빨간색)
        defaultTextStyle: const TextStyle(color: Colors.black), // 기본 텍스트 색상
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }
}