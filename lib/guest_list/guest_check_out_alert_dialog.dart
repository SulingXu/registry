import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/styles.dart';
import 'package:registry/guest_list/guest_fee_paying.dart';
import 'package:registry/guest_list/guest_status.dart';

class GuestCheckOutAlertDialog extends StatefulWidget {
  GuestCheckOutAlertDialog({Key? key, required this.guest, required this.checkOutTimeUpdate}) : super(key: key);
  Guest guest;
  VoidCallback checkOutTimeUpdate;
  @override
  _GuestCheckOutAlertDialogState createState() => _GuestCheckOutAlertDialogState();
}

class _GuestCheckOutAlertDialogState extends State<GuestCheckOutAlertDialog> {
  final String _alertDialogTitle = 'CheckOut Information';
  final String _cancelButtonTxt = 'Cancel';
  final String _continueButtonTxt ='Continue';
  final String _questionTxt = 'Are you sure to check out?';
  final String _wrongTimewarning = 'Wrong registry time';
  final double _playingFeePerHour = 50.0;

  String _calTotalTime(DateTime? startTime, DateTime? endTime) {
    if(startTime == null || endTime == null ) {
      return _wrongTimewarning;
    }
    double totalTime = (endTime.hour + (endTime.minute / 60)) -
        (startTime.hour + (startTime.minute / 60));
    int hours = totalTime.floor();
    int minuts = ((totalTime - totalTime.floorToDouble()) * 60).round();
    return (hours == 0)
        ? '${minuts}min'
        : (minuts == 0) ? '${hours}hr' : '${hours}hr ${minuts}min';
  }

  double _calTotalMoney(String calTotalTime, double playingFeePerHour) {
    if (calTotalTime.contains("hr") && calTotalTime.contains("min")) {
      return (int.parse(calTotalTime.split('hr')[0]) + 1) * playingFeePerHour; // n hr m min
    } else if(calTotalTime.contains("hr")) {
      return int.parse(calTotalTime.split('hr')[0]) * playingFeePerHour;// = n hr
    } else if(calTotalTime.contains("min")) {
      if (int.parse(calTotalTime.split('min')[0]) !=0) {
        return playingFeePerHour;// 1 min < * < 1 hr
      } else { // 0 min
        return 0;
      }
    } else { //exception
      return 0;
    }
  }

  void _navigateToDifferentPages(BuildContext context, double fee) {
    if (fee != 0) {
      Navigator.push(
        context,
        new MaterialPageRoute<void>(builder: (context) => GuestFeePaying(guestFee: widget.guest.fee)),
      );
    } else {
      Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    }
  }

  Widget cancelButton (BuildContext context) {
    return TextButton(
      child: Text(_cancelButtonTxt),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget continueButton (BuildContext context, double fee) {
    return TextButton(
      child: Text(_continueButtonTxt),
      onPressed:  () {
        widget.checkOutTimeUpdate();
        _navigateToDifferentPages(context, fee);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String _guestName = widget.guest.firstName + ' ' + widget.guest.lastName;
    String _status = (widget.guest.status == GuestStatus.play) ? 'play' : 'watch';
    String _totalStayTime = _calTotalTime(widget.guest.checkInTime, widget.guest.checkOutTime);
    String _showNameTimeStatus = _guestName + ' spent ' + _totalStayTime + ' ' + _status + 'ing,';
    widget.guest.fee = _calTotalMoney(_totalStayTime, _playingFeePerHour);
    String _showMoney = (_status == 'play' && widget.guest.fee != 0) ? "need to pay " + widget.guest.fee.toString() + "SEK" : "don't need to pay";

    return AlertDialog(
      title: Text(_alertDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Styles.paddingWithText(_showNameTimeStatus),
          Styles.paddingWithText(_showMoney),
          Styles.paddingWithText(_questionTxt)
        ],
      ),
      actions: [
        cancelButton(context),
        continueButton(context, widget.guest.fee),
      ],
    );
  }
}
