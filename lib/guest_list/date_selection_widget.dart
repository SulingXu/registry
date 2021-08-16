import 'package:flutter/material.dart';
import 'package:registry/styles.dart';

class DateSelectionWidget extends StatefulWidget {
  const DateSelectionWidget({Key? key, required this.dateChanged}) : super(key: key);
  final Function(DateTime) dateChanged;

  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  DateTime _selectedDate = DateTime.now();
  //waits for the date selected by the user
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked !=  _selectedDate) {
      _selectedDate = picked;
      widget.dateChanged(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Styles.text('${ _selectedDate.toLocal()}'.split(' ')[0]),
            const SizedBox(width: 50),
            IconButton(
              icon: const Icon(
                Icons.calendar_today_outlined,
              ),
              iconSize: 28,
              onPressed: () {
                _selectDate(context);
              },
            ),
          ],
        )
    );
  }
}
