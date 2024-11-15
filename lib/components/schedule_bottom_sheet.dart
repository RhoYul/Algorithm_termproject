import 'package:flutter/material.dart';
import 'package:term_project/cons/colors.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime? initialDeadline;
  final String? initialContent;

  ScheduleBottomSheet({
    required this.selectedDate,
    this.initialDeadline,
    this.initialContent,
    Key? key,
  }) : super(key: key);

  @override
  _ScheduleBottomSheetState createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  late DateTime deadline;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    // 마감 기한 기본값 설정
    deadline = widget.initialDeadline ?? widget.selectedDate;
    contentController =
        TextEditingController(text: widget.initialContent ?? '');
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
                    '마감 기한:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: deadline,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000),
                      );
                      if (pickedDate != null) {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(deadline),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            deadline = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      }
                    },
                    child: Text(
                      '${deadline.year}-${_twoDigits(deadline.month)}-${_twoDigits(deadline.day)} '
                      '${_twoDigits(deadline.hour)}:${_twoDigits(deadline.minute)}',
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
                          'deadline': deadline,
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

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }
}
