import 'package:flutter/material.dart';
import 'package:term_project/cons/colors.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate; // 선택한 날짜를 전달받음

  const ScheduleBottomSheet({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final TextEditingController contentController = TextEditingController();
  DateTime? selectedEndDate; // 종료 날짜 저장

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 2 + bottomInset,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
          child: Column(
            children: [
              GestureDetector(
                onTap: pickEndDate,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedEndDate == null
                            ? '종료 날짜를 선택하세요'
                            : '${selectedEndDate!.year}-${selectedEndDate!.month}-${selectedEndDate!.day}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      Icon(Icons.calendar_today, color: PRIMARY_COLOR),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: TextFormField(
                  controller: contentController,
                  cursorColor: Colors.grey,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[300],
                    labelText: '내용',
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSavePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: Text('저장'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickEndDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );

    if (pickedDate != null) {
      setState(() {
        selectedEndDate = pickedDate;
      });
    }
  }

  void onSavePressed() {
    if (selectedEndDate == null || contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('종료 날짜와 내용을 입력하세요.')),
      );
      return;
    }

    Navigator.of(context).pop({
      'selectedDate': widget.selectedDate,
      'endDate': selectedEndDate,
      'content': contentController.text,
    });
  }
}