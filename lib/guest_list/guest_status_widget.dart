import 'package:flutter/material.dart';
import 'guest_status.dart';
import 'guest.dart';

class GuestStatusWidget extends StatefulWidget {
  const GuestStatusWidget({Key? key, required this.oneGuest}) : super(key: key);
  final Guest oneGuest;
  @override
  _GuestStatusWidgetState createState() => _GuestStatusWidgetState();
}

class _GuestStatusWidgetState extends State<GuestStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<GuestStatus>(
              value: GuestStatus.play,
              groupValue: widget.oneGuest.status,
              onChanged: (GuestStatus? value) {
                setState(() {
                  widget.oneGuest.status = value;
                });
              },
            ),
            Text(
              'Play',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 50),

            Radio<GuestStatus>(
              value: GuestStatus.watch,
              groupValue: widget.oneGuest.status,
              onChanged: (GuestStatus? value) {
                setState(() {
                  widget.oneGuest.status = value;
                });
              },
            ),
            Text(
              'Watch',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ]
      ),
    );
  }
}