import 'Assignment.dart';

class Subject {
  String name;
  bool isMajor;
  int creditHours;
  int preferenceLevel;
  double attendanceRatio;
  double midtermRatio;
  double finalRatio;
  double assignmentRatio;
  List<Assignment> assignments;

  Subject({
    required this.name,
    required this.isMajor,
    required this.creditHours,
    required this.preferenceLevel,
    required this.attendanceRatio,
    required this.midtermRatio,
    required this.finalRatio,
    required this.assignmentRatio,
    this.assignments = const [],
  });

  bool get isValidRatio =>
      (attendanceRatio + midtermRatio + finalRatio + assignmentRatio) == 1.0;
}
