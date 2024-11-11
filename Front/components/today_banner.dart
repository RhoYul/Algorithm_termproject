import 'package:flutter/material.dart';
import 'package:term_project/cons/colors.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int count;

  const TodayBanner({
    required this.selectedDate,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: LIGHT_GREY_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: DARK_GREY_COLOR,
            ),
          ),
          Text(
            '$count개의 일정',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: PRIMARY_COLOR,
            ),
          ),
        ],
      ),
    );
  }
}
