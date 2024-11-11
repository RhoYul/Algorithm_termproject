import 'package:flutter/material.dart';
import 'calendar.dart'; // CalendarWidget을 import

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // TabController 초기화 (탭 수는 3: Home, Search, Profile)
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Example'),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(), // 스와이프 비활성화
        children: [
          Column(
            children: [
              Expanded(
                child: CalendarWidget(), // 홈 화면에서 캘린더 표시
              ),
            ],
          ), // 첫 번째 탭: Home
          Center(child: Text('Search Screen')), // 두 번째 탭
          Center(child: Text('Profile Screen')), // 세 번째 탭
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _tabController.animateTo(index); // 탭 전환
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Todos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
