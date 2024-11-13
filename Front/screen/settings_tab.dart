import 'package:flutter/material.dart';
import 'package:term_project/settings_subject/subject_management.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.book),
            title: Text("과목 관리"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubjectManagementScreen()),
              );
            },
          ),
          // Other settings options can go here
        ],
      ),
    );
  }
}
