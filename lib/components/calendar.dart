import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:term_project/cons/colors.dart';
import 'package:term_project/cons/schedule_provider.dart';

class MainCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime, DateTime) onDaySelected;

  MainCalendar({required this.selectedDate, required this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    // Generate markers for days with schedules
    final markers = <DateTime, List>{};
    for (var schedule in scheduleProvider.schedules) {
      if (schedule['selectedDate'] != null) {
        final date = schedule['selectedDate'] as DateTime;
        markers[date] = (markers[date] ?? [])..add(schedule);
      } else {
        print(
            "Warning: schedule with null selectedDate encountered: $schedule");
      }
    }

    DateTime today = DateTime.now();

    return TableCalendar(
      focusedDay: selectedDate,
      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      selectedDayPredicate: (day) =>
          isSameDay(selectedDate, day) && !isSameDay(day, today),
      onDaySelected: onDaySelected,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: PRIMARY_COLOR,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        selectedDecoration: BoxDecoration(
          color: LIGHT_PRIMARY_COLOR,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          color: DARK_GREY_COLOR,
        ),
        defaultDecoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        weekendDecoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        markersMaxCount: 1,
        markerDecoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      eventLoader: (day) => markers[day] ?? [],
    );
  }
}
