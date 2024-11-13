import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:term_project/cons/colors.dart';
import 'package:term_project/components/calendar.dart';
import 'package:term_project/components/schedule_bottom_sheet.dart';
import 'package:term_project/components/today_banner.dart';
import 'package:term_project/cons/schedule_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    // 선택된 날짜의 일정 필터링
    final filteredSchedules = scheduleProvider.schedules.where((schedule) {
      final scheduleDate = schedule['selectedDate'] as DateTime;
      return scheduleDate.year == selectedDate.year &&
          scheduleDate.month == selectedDate.month &&
          scheduleDate.day == selectedDate.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: PRIMARY_COLOR,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            isDismissible: true,
            builder: (_) => ScheduleBottomSheet(selectedDate: selectedDate),
            isScrollControlled: true,
          );
          if (result != null) {
            scheduleProvider.addSchedule({...result, 'isCompleted': false});
          }
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            TodayBanner(
              selectedDate: selectedDate,
              count: filteredSchedules.length,
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: filteredSchedules.isEmpty
                  ? Center(
                child: Text(
                  '오늘은 일정이 없습니다.',
                  style: TextStyle(color: DARK_GREY_COLOR, fontSize: 16.0),
                ),
              )
                  : ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  final schedule = filteredSchedules[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(
                        schedule['content'],
                        style: TextStyle(
                          color: DARK_GREY_COLOR,
                          decoration: schedule['isCompleted']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        '종료 날짜: ${_formatDate(schedule['endDate'])}',
                        style: TextStyle(
                          color: DARK_GREY_COLOR,
                        ),
                      ),
                      leading: Checkbox(
                        value: schedule['isCompleted'],
                        onChanged: (value) {
                          scheduleProvider.toggleComplete(
                              scheduleProvider.schedules.indexOf(schedule));
                        },
                        activeColor: PRIMARY_COLOR,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: PRIMARY_COLOR),
                            onPressed: () => _editSchedule(
                                context, scheduleProvider, schedule),
                          ),
                          IconButton(
                            icon:
                            Icon(Icons.delete, color: DARK_GREY_COLOR),
                            onPressed: () => _deleteSchedule(
                                context, scheduleProvider, schedule),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 날짜 선택 시 업데이트
  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }

  // 일정 수정
  void _editSchedule(BuildContext context, ScheduleProvider provider,
      Map<String, dynamic> schedule) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isDismissible: true,
      builder: (_) => ScheduleBottomSheet(
        selectedDate: schedule['selectedDate'],
        initialEndDate: schedule['endDate'],
        initialContent: schedule['content'],
      ),
      isScrollControlled: true,
    );

    if (result != null) {
      provider.updateSchedule(
        provider.schedules.indexOf(schedule),
        {...result, 'isCompleted': schedule['isCompleted']},
      );
    }
  }

  // 일정 삭제
  void _deleteSchedule(BuildContext context, ScheduleProvider provider,
      Map<String, dynamic> schedule) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('삭제 확인'),
        content: Text('정말로 이 일정을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              '취소',
              style: TextStyle(color: Colors.black), // 취소 버튼 색상: 검정색
            ),
          ),
          TextButton(
            onPressed: () {
              provider.removeSchedule(provider.schedules.indexOf(schedule)); // 일정 삭제
              Navigator.of(ctx).pop(); // 다이얼로그 닫기
            },
            child: Text(
              '삭제',
              style: TextStyle(color: PRIMARY_COLOR), // 삭제 버튼 색상: 민트색
            ),
          ),
        ],
      ),
    );
  }

  // 날짜 포맷 함수
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
