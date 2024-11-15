import 'package:flutter/material.dart';
import '../models/Subject.dart';

class SubjectAddScreen extends StatefulWidget {
  @override
  _SubjectAddScreenState createState() => _SubjectAddScreenState();
}

class _SubjectAddScreenState extends State<SubjectAddScreen> {
  final _formKey = GlobalKey<FormState>();

  String subjectName = "";
  bool isMajor = false;
  int creditHours = 1;
  int preferenceLevel = 1; // 선호도 (1~5)
  double attendanceRatio = 0.0;
  double midtermRatio = 0.0;
  double finalRatio = 0.0;
  double assignmentRatio = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("과목 추가")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 과목 이름 입력
              TextFormField(
                decoration: InputDecoration(labelText: "과목 이름"),
                onChanged: (value) => setState(() => subjectName = value),
                validator: (value) =>
                value == null || value.isEmpty ? "과목 이름을 입력하세요." : null,
              ),
              // 전공 여부 스위치
              SwitchListTile(
                title: Text("전공 여부"),
                value: isMajor,
                onChanged: (value) => setState(() => isMajor = value),
              ),
              // 학점 선택
              DropdownButtonFormField<int>(
                value: creditHours,
                items: [1, 2, 3]
                    .map((value) =>
                    DropdownMenuItem(value: value, child: Text("$value 학점")))
                    .toList(),
                onChanged: (value) => setState(() => creditHours = value!),
                decoration: InputDecoration(labelText: "학점"),
              ),
              const SizedBox(height: 16.0),
              // 선호도 제목
              Text(
                "선호도",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8.0),
              // 선호도 별점 선택
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < preferenceLevel
                          ? Icons.star
                          : Icons.star_border, // 채워진 별과 빈 별 구분
                      color: Colors.amber,
                      size: 32.0,
                    ),
                    onPressed: () {
                      setState(() {
                        preferenceLevel = index + 1; // 선택한 별에 따라 선호도 변경
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 16.0),
              Text(
                "성적 비율 입력 (합이 1.0이어야 함)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // 출석 비율 입력
              TextFormField(
                decoration: InputDecoration(labelText: "출석 비율"),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(
                        () => attendanceRatio = double.tryParse(value) ?? 0.0),
                validator: (value) {
                  double? ratio = double.tryParse(value ?? '');
                  if (ratio == null || ratio < 0.0 || ratio > 1.0) {
                    return "0.0에서 1.0 사이의 값을 입력하세요.";
                  }
                  return null;
                },
              ),
              // 중간고사 비율 입력
              TextFormField(
                decoration: InputDecoration(labelText: "중간고사 비율"),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => midtermRatio = double.tryParse(value) ?? 0.0),
              ),
              // 기말고사 비율 입력
              TextFormField(
                decoration: InputDecoration(labelText: "기말고사 비율"),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => finalRatio = double.tryParse(value) ?? 0.0),
              ),
              // 과제 비율 입력
              TextFormField(
                decoration: InputDecoration(labelText: "과제 비율"),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => assignmentRatio = double.tryParse(value) ?? 0.0),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // 성적 비율 검증
                    if ((attendanceRatio +
                        midtermRatio +
                        finalRatio +
                        assignmentRatio) !=
                        1.0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("성적 비율의 합이 1.0이 되어야 합니다."),
                        ),
                      );
                      return;
                    }
                    // 새 과목 객체 생성
                    final newSubject = Subject(
                      name: subjectName,
                      isMajor: isMajor,
                      creditHours: creditHours,
                      preferenceLevel: preferenceLevel,
                      attendanceRatio: attendanceRatio,
                      midtermRatio: midtermRatio,
                      finalRatio: finalRatio,
                      assignmentRatio: assignmentRatio,
                      assignments: [],
                    );
                    Navigator.pop(context, newSubject); // 과목 데이터 반환
                  }
                },
                child: Text("과목 추가"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
