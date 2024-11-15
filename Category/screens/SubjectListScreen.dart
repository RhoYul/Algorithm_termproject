import 'package:flutter/material.dart';
import 'AssignmentAddScreen.dart';
import 'SubjectAddScreen.dart';
import 'package:untitled/models/Subject.dart';
import 'package:untitled/models/Assignment.dart';

class SubjectListScreen extends StatefulWidget {
  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  List<Subject> subjects = []; // 초기 상태는 빈 리스트

  void _navigateToAssignmentAddScreen(int subjectIndex) async {
    final newAssignment = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AssignmentAddScreen()),
    );

    if (newAssignment != null && newAssignment is Assignment) {
      setState(() {
        subjects[subjectIndex].assignments.add(newAssignment);
      });
    }
  }

  void _navigateToEditAssignmentScreen(
      int subjectIndex, int assignmentIndex) async {
    final updatedAssignment = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssignmentAddScreen(
          assignment: subjects[subjectIndex].assignments[assignmentIndex],
        ),
      ),
    );

    if (updatedAssignment != null && updatedAssignment is Assignment) {
      setState(() {
        subjects[subjectIndex].assignments[assignmentIndex] = updatedAssignment;
      });
    }
  }

  void _navigateToAddSubjectScreen() async {
    final newSubject = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubjectAddScreen()),
    );

    if (newSubject != null && newSubject is Subject) {
      setState(() {
        subjects.add(newSubject);
      });
    }
  }

  void _confirmDeleteAssignment(int subjectIndex, int assignmentIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("과제 삭제"),
          content: Text("이 과제를 정말 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 경고창 닫기
              },
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  subjects[subjectIndex].assignments.removeAt(assignmentIndex);
                });
                Navigator.of(context).pop(); // 경고창 닫기
              },
              child: Text("삭제"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("과목 목록")),
      body: subjects.isEmpty
          ? Center(
        child: Text(
          "추가된 과목이 없습니다.\n아래 버튼을 눌러 과목을 추가하세요.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, subjectIndex) {
          final subject = subjects[subjectIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 과목 카드
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.subject),
                  title: Text(subject.name),
                  subtitle: Text("전공 여부: ${subject.isMajor ? '전공' : '비전공'}"),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () =>
                        _navigateToAssignmentAddScreen(subjectIndex),
                  ),
                ),
              ),
              // 과제 리스트
              ...subject.assignments.asMap().entries.map((entry) {
                final assignmentIndex = entry.key;
                final assignment = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ListTile(
                    leading: Checkbox(
                      value: assignment.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          assignment.isCompleted = value ?? false;
                        });
                      },
                    ),
                    title: Text("과제 이름: ${assignment.name}"),
                    subtitle: Text(
                      "마감일: ${assignment.deadline.toLocal().toString().replaceFirst(' ', ' | ')}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _navigateToEditAssignmentScreen(
                              subjectIndex, assignmentIndex),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDeleteAssignment(
                              subjectIndex, assignmentIndex),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              Divider(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddSubjectScreen,
        child: Icon(Icons.add),
        tooltip: "과목 추가",
      ),
    );
  }
}
