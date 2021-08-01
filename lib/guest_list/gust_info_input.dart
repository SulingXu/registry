import 'package:flutter/material.dart';
import 'guest_info_input_widget.dart';

class GuestInfoInput extends StatefulWidget {
  const GuestInfoInput({Key? key, required this.chosenHostName}) : super(key: key);
  final String chosenHostName;
  @override
  _GuestInfoInputState createState() => _GuestInfoInputState();
}

class _GuestInfoInputState extends State<GuestInfoInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Information"),
      ),
      body: GuestInfoInputWidget(chosenHostName: widget.chosenHostName),
    );
  }
}

