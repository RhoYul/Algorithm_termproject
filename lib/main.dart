import 'package:flutter/material.dart';
import 'background_alarm.dart';
import 'weekday_manager.dart';
import 'event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeAlarms();
  registerBackgroundAlarms();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ReminderScreen(),
    );
  }
}

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final WeekdayManager weekdayManager = WeekdayManager(globalEvents);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reminder App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final selectedTime = DateTime.now();
                const windowSize = Duration(minutes: 10);

                final eventsInWindow = globalEvents.where((event) {
                  final timeDifference =
                      event.time.difference(selectedTime).inMinutes;
                  return timeDifference >= 0 &&
                      timeDifference <= windowSize.inMinutes;
                }).toList();

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("10분 내 일정"),
                    content: Text(eventsInWindow.isEmpty
                        ? "해당 시간 내에 일정이 없습니다."
                        : eventsInWindow
                            .map((e) => "${e.name} at ${e.time.toLocal()}")
                            .join("\n")),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("닫기"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("10분 내 이벤트 확인"),
            ),
            ElevatedButton(
              onPressed: () {
                int selectedWeekday = DateTime.now().weekday;
                final eventsForToday =
                    weekdayManager.getEventsForDay(selectedWeekday);

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("오늘의 이벤트"),
                    content: Text(eventsForToday.isEmpty
                        ? "오늘의 일정이 없습니다."
                        : eventsForToday
                            .map((e) => "${e.name} at ${e.time.toLocal()}")
                            .join("\n")),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("닫기"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("오늘의 이벤트 보기"),
            ),
          ],
        ),
      ),
    );
  }
}
