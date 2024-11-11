import 'package:flutter/material.dart';
import 'package:term_project/screen/home_tab.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized(); //플러터 프레임워크가 준비될때까지 대기

  await initializeDateFormatting(); //intl 초기화(다국어화)

  runApp(
      MaterialApp(
        home: HomeScreen(),
      )
  );
}