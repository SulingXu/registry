import 'package:flutter/material.dart';
import 'guest.dart';

class GuestListWidget extends StatefulWidget {
  const GuestListWidget({Key? key, required this.chosenHostName, required this.oneGuest}) : super(key: key);
  final String chosenHostName;
  final Guest oneGuest;
  @override
  _GuestListWidgetState createState() => _GuestListWidgetState();
}

class _GuestListWidgetState extends State<GuestListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
