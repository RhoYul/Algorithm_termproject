import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:term_project/components/bottom_navigation.dart';
import 'package:term_project/cons/schedule_provider.dart'; // ScheduleProvider 파일 가져오기
import 'package:term_project/cons/colors.dart';

void main() {
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
