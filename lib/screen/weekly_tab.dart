import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:term_project/cons/colors.dart';
import 'package:term_project/cons/schedule_provider.dart';

class WeeklyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    // 오늘을 기준으로 한 주 범위 계산
    DateTime today = DateTime.now();
    DateTime startOfWeek =
        today.subtract(Duration(days: today.weekday - 1)); // 주 시작 (월요일)
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6)); // 주 끝 (일요일)

    // 현재 주의 일정 필터링
    final weeklySchedules = scheduleProvider.getWeeklySchedules(
      startOfWeek,
      endOfWeek,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly', style: TextStyle(color: Colors.white)),
        backgroundColor: PRIMARY_COLOR,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '이번 주 일정 (${_formatDate(startOfWeek)} ~ ${_formatDate(endOfWeek)})',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: DARK_GREY_COLOR,
                ),
              ),
            ),
            Expanded(
              child: weeklySchedules.isEmpty
                  ? Center(
                      child: Text(
                        '이번 주 일정이 없습니다.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: DARK_GREY_COLOR,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: weeklySchedules.length,
                      itemBuilder: (context, index) {
                        final schedule = weeklySchedules[index];

                        // deadline 또는 selectedDate 유효성 검사
                        final deadline = schedule['deadline'];
                        if (deadline == null || deadline is! DateTime) {
                          return SizedBox(); // 잘못된 일정은 건너뜀
                        }

                        return Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          elevation: 2.0,
                          child: ListTile(
                            title: Text(
                              schedule['content'] ?? '내용 없음',
                              style: TextStyle(
                                color: DARK_GREY_COLOR,
                                decoration: schedule['isCompleted'] ?? false
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Text(
                              _formatDate(deadline), // 마감 기한 표시
                              style: TextStyle(
                                color: DARK_GREY_COLOR,
                              ),
                            ),
                            trailing: Checkbox(
                              value: schedule['isCompleted'] ?? false,
                              onChanged: (value) {
                                scheduleProvider.toggleComplete(
                                  scheduleProvider.schedules.indexOf(schedule),
                                );
                              },
                              activeColor: PRIMARY_COLOR,
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

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
