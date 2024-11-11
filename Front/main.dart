import 'package:flutter/material.dart';
import 'components/TabView.dart'; // TabView.dart를 import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabView(), // TabView를 홈 화면으로 설정
    );
  }
}
