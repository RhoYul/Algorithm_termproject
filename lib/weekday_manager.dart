// weekday_manager.dart
import 'event.dart';

class WeekdayManager {
  final List<Event> events;

  WeekdayManager(this.events);

  // 특정 요일의 이벤트를 가져오는 메서드
  List<Event> getEventsForDay(int weekday) {
    return events.where((event) => event.time.weekday == weekday).toList();
  }
}
