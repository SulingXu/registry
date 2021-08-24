import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest_check_out_alert_dialog.dart';
import 'package:registry/guest_list/guest_status.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/styles.dart';
import 'package:registry/Utilities/dateProcessor.dart';

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
  final String _checkOutButtonTxt = 'Check out';
  final String _checkedOutButtonTxt = 'Checked out';

  Widget checkOutButton() {
    return ElevatedButton(
      style: widget.guest.hasCheckedOut
          ? Styles.CheckedOutbuttonColor
          : Styles.unCheckedOutbuttonColor,
      onPressed: widget.guest.hasCheckedOut ? null : Function,
      child: Styles.text(
          widget.guest.hasCheckedOut
              ? _checkedOutButtonTxt
              : _checkOutButtonTxt,
          Styles.middleTextWithDefaultColor),
    );
  }

  void Function() {
    widget.guest.checkOutTime =
        DateTime.now(); //get current time when the checkOutButton is pressed
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return GuestCheckOutAlertDialog(
              guest: widget.guest,
              checkOutTimeUpdate: () =>
                  setState(() => widget.guest.hasCheckedOut = true));
        });
  }

  String _getHrMin(DateTime? time) {
    if (time == null) {
      return '---';
    } else {
      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    }
  }

  String _getMonDayHrMin(DateTime? time) {
    if (time == null) {
      return '---';
    } else {
      return "${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    String _guestName = widget.guest.firstName + ' ' + widget.guest.lastName;
    String _status =
        (widget.guest.status == GuestStatus.play) ? 'play' : 'watch';

    return Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Styles.paddingWithTextRow(_guestNameTextPrefix, _guestName),
            Styles.paddingWithTextRow(
                _hostNameTextPrefix, widget.guest.chosenHostName ?? ' '),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Styles.textRowWith(_statusTextPrefix, _status),
                  const SizedBox(width: 50),
                  checkOutButton(), //checkOutButton
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Align(
                  alignment: Alignment.center,
                  child: Styles.text(
                      "From  " +
                          _getHrMin(widget.guest.checkInTime) +
                          "  to  " +
                          (DateProcessor.compareTwoDate(
                                  widget.guest.checkInTime,
                                  widget.guest.checkOutTime)
                              ? _getHrMin(widget.guest.checkOutTime)
                              : _getMonDayHrMin(widget.guest.checkOutTime)),
                      Styles.middleTextWithDefaultColor)),
            ),
          ],
        ));
  }
}
