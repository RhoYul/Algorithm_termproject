// background_alarm.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'event.dart';

// flutterLocalNotificationsPlugin 정의 및 초기화 함수
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeAlarms() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// 알림 표시 함수
Future<void> showAlarm(String eventName) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: true,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    DateTime.now().millisecondsSinceEpoch.remainder(100000), // 고유 ID
    '이벤트 알림',
    '$eventName 이벤트가 10분 후에 시작합니다!',
    platformChannelSpecifics,
    payload: 'item x',
  );
}

// 백그라운드 작업을 처리하는 콜백 함수
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final now = DateTime.now();

    for (final event in globalEvents) {
      final timeBeforeEvent = event.time.difference(now);

      // 10분 이내의 이벤트에 대해 알림 생성
      if (timeBeforeEvent.inMinutes <= 10 && !timeBeforeEvent.isNegative) {
        await showAlarm(event.name);
      }
    }
    return Future.value(true);
  });
}

// 백그라운드 알림 작업 등록 함수
void registerBackgroundAlarms() {
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    "1",
    "backgroundTask",
    frequency: const Duration(minutes: 15),
  );
}
