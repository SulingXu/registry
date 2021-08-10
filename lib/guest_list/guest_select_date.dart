import 'package:flutter/material.dart';
import 'guest_info_input_widget.dart';

class GuestSelectDate extends StatefulWidget {
  const GuestSelectDate({Key? key, required this.completion}) : super(key: key);
  final VoidCallback completion;
  @override
  _GuestSelectDateState createState() => _GuestSelectDateState();
}

class _GuestSelectDateState extends State<GuestSelectDate> {
  DateTime _selectedDate = DateTime.now();

  //waits for the date selected by the user
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text("${_selectedDate.toLocal()}".split(' ')[0]),
            const SizedBox(width: 50),
            IconButton(
              icon: Icon(
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
