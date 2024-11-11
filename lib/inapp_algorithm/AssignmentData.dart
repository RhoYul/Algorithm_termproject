import 'CalenderData.dart';

class AssignmentData {
  String subjectName;
  String assignmentName;
  double currentRatio;
  double latePenalty;
  int isAlter; // 0 = none, 1 = midterm, 2 = final
  DateTime deadline;
  DateTime recDeadline;
  double expectedPeriod;
  double importance;
  double priority;

  AssignmentData({
    required this.subjectName,
    required this.assignmentName,
    required this.currentRatio,
    required this.latePenalty,
    required this.isAlter,
    required this.deadline,
    required this.expectedPeriod,
    this.importance = 0.0,
    this.priority = 0.0,
  }) : recDeadline = deadline;

  void calculateImportance(double subjectRatio, double alterVal) {
    double currentAssignmentRatio = currentRatio * subjectRatio * 10;
    double penalty = 1.0 - latePenalty;

    if (isAlter == 1 || isAlter == 2) {
      currentAssignmentRatio = 0.0;
      penalty = alterVal * 10;
    }

    importance = currentAssignmentRatio + penalty;
  }

  void calculateRecDeadline(List<CalenderData> schedules) {
    DateTime calculatedRecDeadline = deadline;

    for (var schedule in schedules) {
      DateTime scheduleDate = schedule.getScheduleDate();

      // If the schedule and deadline overlap, set recDeadline to one day in advance.
      if (calculatedRecDeadline.isAtSameMomentAs(scheduleDate)) {
        calculatedRecDeadline = calculatedRecDeadline.subtract(Duration(days: 1));
      }
      // If the schedule is behind (deadline - expectedPeriod), set recDeadline to that schedule date.
      else if (deadline.difference(scheduleDate).inHours < expectedPeriod * 24) {
        calculatedRecDeadline = scheduleDate;
      }
    }

    recDeadline = calculatedRecDeadline;
  }
}