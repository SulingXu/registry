import 'package:flutter/material.dart';
import 'guest_info_input_widget.dart';

class DateSelectionWidget extends StatefulWidget {
  DateSelectionWidget({Key? key, required this.completion}) : super(key: key);
  final VoidCallback completion;
  DateTime selectedDate = DateTime.now();
  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {

  //waits for the date selected by the user
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked !=  widget.selectedDate)
      setState(() {
        widget.selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text('${ widget.selectedDate.toLocal()}'.split(' ')[0]),
            const SizedBox(width: 50),
            IconButton(
              icon: const Icon(
                Icons.calendar_today_outlined,
              ),
              iconSize: 28,
              onPressed: () {
                _selectDate(context);
                widget.completion();
              },
            ),
          ],
        )
    );
  }
}
