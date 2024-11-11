import 'package:flutter/material.dart';
import 'package:term_project/cons/colors.dart';

class ScheduleCard extends StatelessWidget {
  final DateTime? endDate; // 종료 날짜
  final String content;

  const ScheduleCard({
    this.endDate,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (endDate != null)
              Text(
                '종료 날짜: ${endDate!.year}-${endDate!.month}-${endDate!.day}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: PRIMARY_COLOR,
                  fontSize: 14.0,
                ),
              ),
            SizedBox(height: 8.0),
            Text(
              content,
              style: TextStyle(fontSize: 13.5),
            ),
          ],
        ),
      ),
    );
  }
}
