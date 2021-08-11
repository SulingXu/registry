import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest_check_out.dart';
import 'package:registry/guest_list/guest_status.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/styles.dart';

class GuestItemWidget extends StatefulWidget {
  GuestItemWidget({Key? key, required this.guest}) : super(key: key);
  Guest guest;
  @override
  _GuestItemWidgetState createState() => _GuestItemWidgetState();
}

class _GuestItemWidgetState extends State<GuestItemWidget> {
  final String _guestNameTextPrefix = 'Guest Name:';
  final String _hostNameTextPrefix = 'Host Name:';
  final String _statusTextPrefix = 'Status:';

  Widget textRowWith(String prefix, String showString) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Styles.text(prefix),
        const SizedBox(width: 10),
        Styles.text(showString),
      ],
    );
  }
  Widget paddingAroundText(String prefix, String showString) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: textRowWith(prefix, showString),
    );
  }
  @override
  Widget build(BuildContext context) {
    String _guestName = widget.guest.firstName + ' ' + widget.guest.lastName;
    String _status = (widget.guest.status == GuestStatus.play) ? 'play' : 'watch';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        paddingAroundText(_guestNameTextPrefix, _guestName),
        paddingAroundText(_hostNameTextPrefix, widget.guest.chosenHostName ?? ' '),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textRowWith(_statusTextPrefix, _status),
              const SizedBox(width: 50),
              GuestCheckOut(guest: widget.guest),//checkOutButton
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Align(
            alignment: Alignment.center,
            child: Styles.text("From " + _getFormattedTime(widget.guest.checkInTime) + " to " + _getFormattedTime(widget.guest.checkOutTime),)
          ),
        ),
        Divider(),
      ],
    );
  }

  String _getFormattedTime(DateTime? time) {
    if (time == null) {
      return '---';
    } else {
      return "${time.hour.toString().padLeft(2,'0')}:${time.minute.toString().padLeft(2,'0')}:${time.second.toString().padLeft(2,'0')}";
    }
  }
}
