import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:term_project/cons/colors.dart';

class MainCalander extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime, DateTime) onDaySelected;

  MainCalander({
    required this.selectedDate,
    required this.onDaySelected,
  });

  @override
  _MainCalanderState createState() => _MainCalanderState();
}

class _MainCalanderState extends State<MainCalander> {
  late final ValueNotifier<DateTime> _focusedDay;
  late final ValueNotifier<DateTime?> _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = ValueNotifier(widget.selectedDate);
    _selectedDay = ValueNotifier(widget.selectedDate);
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return TableCalendar(
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay.value,
      selectedDayPredicate: (day) => isSameDay(_selectedDay.value, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay.value = selectedDay;
          _focusedDay.value = focusedDay;
          widget.onDaySelected(selectedDay, focusedDay);
        });
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: DARK_GREY_COLOR,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: PRIMARY_COLOR,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: LIGHT_PRIMARY_COLOR,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w600,
        ),
        defaultTextStyle: TextStyle(
          color: DARK_GREY_COLOR,
          fontWeight: FontWeight.w600,
        ),
        outsideDaysVisible: false,
      ),
      calendarBuilders: CalendarBuilders(
        // 일반 날짜
        defaultBuilder: (context, day, focusedDay) {
          return Center(
            child: Text(
              '${day.day}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: DARK_GREY_COLOR,
              ),
            ),
          );
        },
        // 오늘 날짜
        todayBuilder: (context, day, focusedDay) {
          return Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300), // 부드러운 전환 시간
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PRIMARY_COLOR, // 오늘 날짜: 항상 진한 색
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
        // 선택된 날짜
        selectedBuilder: (context, day, focusedDay) {
          final isToday = day.year == today.year &&
              day.month == today.month &&
              day.day == today.day;

          if (isToday) {
            // 선택된 날짜가 오늘인 경우, 항상 오늘의 스타일 유지
            return Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300), // 부드러운 전환 시간
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: PRIMARY_COLOR, // 진한 색
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          } else {
            // 선택된 날짜가 오늘이 아닌 경우, 선택된 스타일 사용
            return Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300), // 부드러운 전환 시간
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LIGHT_PRIMARY_COLOR, // 연한 색
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: DARK_GREY_COLOR,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
