import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleProvider with ChangeNotifier {
  // 일정 데이터 리스트
  List<Map<String, dynamic>> _schedules = [];

  // 일정 데이터를 외부에서 접근할 수 있도록 하는 getter
  List<Map<String, dynamic>> get schedules => _schedules;

  // 일정 추가 메서드
  void addSchedule(Map<String, dynamic> schedule) {
    // 추가되는 일정의 마감 기한이 DateTime 타입인지 확인
    if (schedule['deadline'] is! DateTime) {
      throw ArgumentError('deadline must be a DateTime object.');
    }
    _schedules.add(schedule); // 일정 리스트에 추가
    saveSchedulesToStorage(); // 로컬 저장소에 저장
    notifyListeners(); // UI 갱신을 위해 리스너에게 알림
  }

  // 일정의 완료 상태를 토글하는 메서드
  void toggleComplete(int index) {
    _schedules[index]['isCompleted'] =
        !_schedules[index]['isCompleted']; // 완료 상태 반전
    saveSchedulesToStorage(); // 변경 사항 저장
    notifyListeners(); // UI 갱신을 위해 리스너에게 알림
  }

  // 기존 일정을 업데이트하는 메서드
  void updateSchedule(int index, Map<String, dynamic> updatedSchedule) {
    _schedules[index] = updatedSchedule; // 특정 인덱스의 일정 데이터 업데이트
    saveSchedulesToStorage(); // 변경 사항 저장
    notifyListeners(); // UI 갱신을 위해 리스너에게 알림
  }

  // 특정 인덱스의 일정을 삭제하는 메서드
  void removeSchedule(int index) {
    _schedules.removeAt(index); // 일정 삭제
    saveSchedulesToStorage(); // 변경 사항 저장
    notifyListeners(); // UI 갱신을 위해 리스너에게 알림
  }

  // 로컬 저장소에 일정 데이터를 JSON 형식으로 저장하는 메서드 (앱을 실행하는 기기(android)의 로컬 저장소에 저장)
  void saveSchedulesToStorage() async {
    final prefs =
        await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 가져오기
    final schedulesJson = jsonEncode(
      _schedules.map((schedule) {
        final scheduleCopy = Map<String, dynamic>.from(schedule);

        // 마감 기한이 DateTime 타입이면 ISO 8601 형식의 문자열로 변환
        if (scheduleCopy['deadline'] is DateTime) {
          scheduleCopy['deadline'] =
              (scheduleCopy['deadline'] as DateTime).toIso8601String();
        }
        return scheduleCopy;
      }).toList(),
    );
    await prefs.setString(
        'schedules', schedulesJson); // JSON 데이터를 'schedules' 키로 저장
  }

  // 로컬 저장소에서 일정 데이터를 불러와서 _schedules에 로드하는 메서드
  Future<void> loadSchedulesFromStorage() async {
    final prefs =
        await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 가져오기
    final schedulesJson =
        prefs.getString('schedules'); // 'schedules' 키로 저장된 JSON 데이터 가져오기
    if (schedulesJson != null) {
      _schedules = List<Map<String, dynamic>>.from(
        jsonDecode(schedulesJson).map((schedule) {
          final scheduleCopy = Map<String, dynamic>.from(schedule);

          // 마감 기한이 문자열이면 DateTime 타입으로 변환
          if (scheduleCopy['deadline'] is String) {
            scheduleCopy['deadline'] = DateTime.parse(scheduleCopy['deadline']);
          }
          return scheduleCopy;
        }),
      );
    }
    notifyListeners(); // UI 갱신을 위해 리스너에게 알림
  }

  /// 주간 일정 가져오기: 특정 주간 내의 일정만 필터링하여 반환
  List<Map<String, dynamic>> getWeeklySchedules(
      DateTime startOfWeek, DateTime endOfWeek) {
    return _schedules.where((schedule) {
      final deadline = schedule['deadline'];

      // 마감 기한이 문자열인 경우 DateTime으로 변환
      if (deadline is String) {
        schedule['deadline'] = DateTime.parse(deadline);
      }

      // 마감 기한이 DateTime 타입이 아닌 경우 false 반환하여 제외
      if (schedule['deadline'] is! DateTime) {
        return false;
      }

      final scheduleDate = schedule['deadline'] as DateTime;

      // 시작일과 종료일 사이에 있는 일정만 필터링
      return scheduleDate.isAtSameMomentAs(startOfWeek) ||
          scheduleDate.isAtSameMomentAs(endOfWeek) ||
          (scheduleDate.isAfter(startOfWeek) &&
              scheduleDate.isBefore(endOfWeek));
    }).toList();
  }
}
