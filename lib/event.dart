// events.dart - manage events
class Event {
  final String name;
  final DateTime time;

  Event(this.name, this.time);
}

// central event lists
final List<Event> globalEvents = [
  Event("중요 회의", DateTime.now().add(const Duration(minutes: 5))),
  Event("수업", DateTime.now().add(const Duration(minutes: 7))),
  Event("운동", DateTime.now().add(const Duration(minutes: 15))),
];
