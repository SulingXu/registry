import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/styles.dart';
import 'package:registry/guest_list/guest_fee_paying.dart';
import 'package:registry/guest_list/guest_status.dart';
import 'package:registry/host_list/host_list_provider.dart';
import 'package:registry/guest_list/guest_list_provider.dart';

class GuestCheckOutAlertDialog extends StatefulWidget {
  GuestCheckOutAlertDialog({Key? key, required this.guest, required this.checkOutTimeUpdate, required this.guestListProvider, required this.hostListProvider}) : super(key: key);
  Guest guest;
  final GuestListProvider guestListProvider;
  final HostListProvider hostListProvider;
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
  final double _playingFeePerMinute = 1.0;

  String _calTotalTime(DateTime? startTime, DateTime? endTime) {
    if(startTime == null || endTime == null ) {
      return _wrongTimewarning;
    }
    double totalTime = (endTime.day * 24 + endTime.hour + (endTime.minute / 60)) -
        (startTime.day * 24 + startTime.hour + (startTime.minute / 60));
    int hours = totalTime.floor();
    int minuts = ((totalTime - totalTime.floorToDouble()) * 60).round();
    return (hours == 0)
        ? '${minuts}min'
        : (minuts == 0) ? '${hours}hr' : '${hours}hr ${minuts}min';
  }

  double _calTotalMoney(String calTotalTime, double playingFeePerMinute) {
    if (calTotalTime.contains("hr") && calTotalTime.contains("min")) {
      return (int.parse(calTotalTime.split('hr')[0]) * 60 + int.parse(calTotalTime.split(' ')[1][0]))* playingFeePerMinute; // n hr m min
    } else if(calTotalTime.contains("hr")) {
      return int.parse(calTotalTime.split('hr')[0]) * playingFeePerMinute * 60;// = n hr
    } else if(calTotalTime.contains("min")) {
      if (int.parse(calTotalTime.split('min')[0]) !=0) {
        return int.parse(calTotalTime.split('min')[0]) * playingFeePerMinute ;// 1 min < nmin < 1 hr
      } else { // 0 min
        return 0;
      }
    } else { //exception
      return 0;
    }
  }

  void _navigateToDifferentPages(BuildContext context, double fee, HostListProvider hostListProvider, GuestListProvider guestListProvider) {
    if (fee != 0) {
      Navigator.push(
        context,
        new MaterialPageRoute<void>(builder: (context) => GuestFeePaying(guestFee: fee, hostListProvider: hostListProvider, guestListProvider: guestListProvider)),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  Widget cancelButton (BuildContext context) {
    return TextButton(
      child: Text(_cancelButtonTxt),
      onPressed:  () {
        widget.guest.checkOutTime = null;
        Navigator.of(context).pop();
      },
    );
  }

  Widget continueButton (BuildContext context, double fee, HostListProvider hostListProvider, GuestListProvider guestListProvider) {
    return TextButton(
      child: Text(_continueButtonTxt),
      onPressed:  () {
        widget.checkOutTimeUpdate();
        _navigateToDifferentPages(context, fee, hostListProvider, guestListProvider);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String _guestName = widget.guest.firstName + ' ' + widget.guest.lastName;
    String _status = (widget.guest.status == GuestStatus.play) ? 'play' : 'watch';
    String _totalStayTime = _calTotalTime(widget.guest.checkInTime, widget.guest.checkOutTime);
    String _showNameTimeStatus = _guestName + ' spent ' + _totalStayTime + ' ' + _status + 'ing,';
    widget.guest.fee = (_status == 'play') ? _calTotalMoney(_totalStayTime, _playingFeePerMinute) : 0;
    String _showMoney = (_status == 'play' && widget.guest.fee != 0) ? "need to pay " + widget.guest.fee.toString() + " SEK" : "don't need to pay";

    return AlertDialog(
      title: Center(child:Text(_alertDialogTitle)),
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
        continueButton(context, widget.guest.fee, widget.hostListProvider, widget.guestListProvider),
      ],
    );
  }
}
