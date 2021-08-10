import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest_check_out.dart';
import 'package:registry/guest_list/guest_status.dart';
import 'package:registry/guest_list/guest_info_input_widget.dart';
import 'package:registry/guest_list/guest.dart';

class GuestItemWidget extends StatefulWidget {
  GuestItemWidget({Key? key, required this.guest}) : super(key: key);
  Guest guest;
  @override
  _GuestItemWidgetState createState() => _GuestItemWidgetState();
}

class _GuestItemWidgetState extends State<GuestItemWidget> {
  final String _guestNameTxt = 'Guest Name:';
  final String _hostNameTxt = 'Host Name:';
  final String _statusTxt = 'Status:';

  Widget nameShowRow(String txtString, String showString){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        text(txtString),
        const SizedBox(width: 10),
        text(showString),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String _guestName = widget.guest.firstName + ' ' + widget.guest.lastName;
    String _status = (widget.guest.status==GuestStatus.play)? 'play':'watch';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: nameShowRow(_guestNameTxt, _guestName),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: nameShowRow(_hostNameTxt, widget.guest.chosenHostName ?? ' '),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              nameShowRow(_statusTxt, _status),
              const SizedBox(width: 50),
              GuestCheckOut(guest: widget.guest),//checkOutButton
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Align(
            alignment: Alignment.center,
            child: text("From " + _getFormattedTime(widget.guest.checkInTime) + " to " + _getFormattedTime(widget.guest.checkOutTime),)
          ),
        ),
        Divider(),
      ],
    );
  }

  String _getFormattedTime(DateTime? time){
    if (time == null){
      return '---';
    }else{
      return "${time.hour.toString().padLeft(2,'0')}:${time.minute.toString().padLeft(2,'0')}:${time.second.toString().padLeft(2,'0')}";
    }
  }
}
