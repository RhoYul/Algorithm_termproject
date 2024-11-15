class Assignment {
  String name; // 과제 이름 -> (AssignmentData.dart: int numOfAssignment)
  double currentRatio; // 현재 과제 비율
  double latePenalty; // 늦은 제출 허용 여부 (0.0 = 허용하지 않음)
  int isAlter; // 대체 과제 여부 (0: 일반 과제, 1: 중간 대체, 2: 기말 대체)
  DateTime deadline; // 과제 마감일
  double expectedPeriod; // 과제 완료 예상 시간
  bool isCompleted; // 과제 완료 여부

  Assignment({
    required this.name,
    required this.currentRatio,
    required this.latePenalty,
    required this.isAlter,
    required this.deadline,
    required this.expectedPeriod,
    this.isCompleted = false, // 기본값 false
  });
}
