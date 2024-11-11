import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:term_project/cons/colors.dart';

class MainCalander extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  MainCalander({
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onDaySelected: onDaySelected, // 날짜 선택 시 실행할 함수
      selectedDayPredicate: (date) =>
      date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day,
      focusedDay: DateTime.now(), // 현재 달력 위치
      firstDay: DateTime(1800, 1, 1), // 달력의 처음 날짜
      lastDay: DateTime(3000, 1, 1), // 달력의 마지막 날짜
      headerStyle: HeaderStyle(
        titleCentered: true, // 제목 중앙에 위치하기
        formatButtonVisible: false, // 달력 크기 선택 옵션 없애기
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: BoxDecoration( // 오늘 날짜 스타일
          shape: BoxShape.circle,
          color: LIGHT_GREY_COLOR,
        ),
        selectedDecoration: BoxDecoration( // 선택된 날짜 스타일
          shape: BoxShape.circle,
          border: Border.all(
            color: PRIMARY_COLOR,
            width: 1.0,
          ),
        ),
        defaultDecoration: BoxDecoration(), // 빈 스타일 적용
        weekendDecoration: BoxDecoration(), // 빈 스타일 적용
        defaultTextStyle: TextStyle( // 기본 글꼴
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
        weekendTextStyle: TextStyle( // 주말 글꼴
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
        selectedTextStyle: TextStyle( // 선택된 날짜 글꼴
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
      ),

    );
  }
}