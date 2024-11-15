import 'package:flutter/material.dart';
import 'screens/SubjectListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '과목 관리 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SubjectListScreen(), // 과목 목록 화면으로 이동
    );
  }
}
