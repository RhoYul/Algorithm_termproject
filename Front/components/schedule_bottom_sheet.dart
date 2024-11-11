import 'package:flutter/material.dart';
import 'package:term_project/cons/colors.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime? initialEndDate;
  final String? initialContent;

  ScheduleBottomSheet({
    required this.selectedDate,
    this.initialEndDate,
    this.initialContent,
    Key? key,
  }) : super(key: key);

  @override
  _ScheduleBottomSheetState createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  late DateTime endDate;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    // 종료 날짜의 기본값을 선택된 날짜로 설정
    endDate = widget.initialEndDate ?? widget.selectedDate;
    contentController = TextEditingController(text: widget.initialContent ?? '');
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: '일정 내용',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: TEXT_FIELD_FILL_COLOR,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '종료 날짜:',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: endDate,
                        firstDate: widget.selectedDate, // 종료 날짜는 선택된 날짜 이후로만 가능
                        lastDate: DateTime(3000),
                      );
                      if (pickedDate != null && pickedDate != endDate) {
                        setState(() {
                          endDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      '${endDate.year}-${endDate.month}-${endDate.day}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (contentController.text.trim().isNotEmpty) {
                        Navigator.of(context).pop({
                          'selectedDate': widget.selectedDate,
                          'endDate': endDate,
                          'content': contentController.text.trim(),
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                    ),
                    child: Text('저장'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
