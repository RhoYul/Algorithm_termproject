import 'package:flutter/material.dart';
import 'package:term_project/settings_category/SubjectListScreen.dart';
import 'package:term_project/settings_category/GeneralScheduleScreen.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('카테고리 관리'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryManagementScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CategoryManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카테고리 관리'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('과목 관리'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubjectListScreen()),
              );
            },
          ),
          ListTile(
            title: Text('일반 일정 관리'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GeneralScheduleScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
