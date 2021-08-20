import 'package:flutter/material.dart';
import '../styles.dart';
import 'guest_status.dart';
import 'guest.dart';

class GuestStatusWidget extends StatefulWidget {
  const GuestStatusWidget({Key? key, required this.guest}) : super(key: key);
  final Guest guest;

  @override
  _GuestStatusWidgetState createState() => _GuestStatusWidgetState();
}

class _GuestStatusWidgetState extends State<GuestStatusWidget> {
  final _playtxt = 'play';
  final _watchtxt = 'watch';

  Widget radioButton (GuestStatus val) {
    return Radio<GuestStatus>(
      value: val,
      groupValue: widget.guest.status,
      onChanged: (GuestStatus? value) {
        setState(() {
          widget.guest.status = value ?? val;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          radioButton(GuestStatus.play),
          Styles.text(_playtxt, Styles.middleTextWithDefaultColor),
          const SizedBox(width: 50),
          radioButton(GuestStatus.watch),
          Styles.text(_watchtxt, Styles.middleTextWithDefaultColor),
        ]
      ),
    );
  }
}