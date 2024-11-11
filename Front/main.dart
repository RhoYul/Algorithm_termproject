import 'package:flutter/material.dart';
import 'package:term_project/screen/home_tab.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:term_project/components/bottom_navigation.dart'; // 하단 네비게이션 바 포함 파일

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigationScreen(), // 하단 네비게이션 화면 표시
    );
  }
}
