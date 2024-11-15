import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:term_project/components/bottom_navigation.dart';
import 'package:term_project/cons/schedule_provider.dart'; // ScheduleProvider 파일 가져오기
import 'package:term_project/cons/colors.dart';
import 'package:term_project/alarm/background_alarm.dart'; // 알림 초기화 및 백그라운드 작업

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 시스템 초기화
  print("Initializing alarms..."); // 로그 추가
  await initializeAlarms(); // 로컬 알림 초기화
  print("Alarms initialized."); // 로그 추가

  print("Registering background alarms..."); // 로그 추가
  registerBackgroundAlarms(); // 백그라운드 작업 등록
  print("Background alarms registered."); // 로그 추가

  runApp(
    ChangeNotifierProvider(
      create: (context) => ScheduleProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primaryColor: PRIMARY_COLOR,
        scaffoldBackgroundColor: LIGHT_GREY_COLOR,
        appBarTheme: AppBarTheme(
          backgroundColor: PRIMARY_COLOR,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: PRIMARY_COLOR,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: DARK_GREY_COLOR),
          bodyMedium: TextStyle(color: DARK_GREY_COLOR),
        ),
      ),
      home: BottomNavigationScreen(),
    );
  }
}
