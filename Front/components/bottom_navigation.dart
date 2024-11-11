import 'package:flutter/material.dart';
import 'package:term_project/screen//home_tab.dart'; // Home 화면
import 'package:term_project/screen/todos_tab.dart'; // Todos 화면
import 'package:term_project/screen/profile_tab.dart'; // Profile 화면

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0; // 현재 선택된 탭의 인덱스
  final List<Widget> _screens = [
    HomeScreen(), // Home 화면
    TodosTab(), // Todos 화면
    ProfileTab(), // Profile 화면
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // 현재 선택된 화면 표시
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 선택된 탭 업데이트
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
