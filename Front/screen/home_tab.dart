import 'package:flutter/material.dart';
import 'package:term_project/cons/colors.dart';
import 'package:term_project/components/calendar.dart';
import 'package:term_project/components/today_schedule.dart';
import 'package:term_project/components/today_banner.dart';
import 'package:term_project/components/schedule_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  List<Map<String, dynamic>> schedules = []; // 전체 일정 리스트

  @override
  Widget build(BuildContext context) {
    // 선택한 날짜에 해당하는 일정만 필터링
    final filteredSchedules = schedules.where((schedule) {
      final scheduleDate = schedule['selectedDate'] as DateTime;
      return scheduleDate.year == selectedDate.year &&
          scheduleDate.month == selectedDate.month &&
          scheduleDate.day == selectedDate.day;
    }).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () async {
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            isDismissible: true,
            builder: (_) => ScheduleBottomSheet(selectedDate: selectedDate),
            isScrollControlled: true,
          );
          if (result != null) {
            setState(() {
              schedules.add(result); // 저장된 일정 추가
            });
          }
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalander(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            TodayBanner(selectedDate: selectedDate, count: filteredSchedules.length),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  final schedule = filteredSchedules[index];
                  return ScheduleCard(
                    endDate: schedule['endDate'], // 종료 날짜 전달
                    content: schedule['content'], // 일정 내용 전달
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
