import 'package:flutter/material.dart';
import 'package:term_project/settings_category/category_management_screen.dart'; // 카테고리 관리 화면 추가
import 'package:term_project/settings_category/alarms_screen.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Manage Categories'),
            subtitle: Text('Add and manage Subject and General categories'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryManagementScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Alarms'),
            subtitle: Text('Manage and view your alarms'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlarmsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
