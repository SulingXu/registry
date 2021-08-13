import 'package:flutter/material.dart';
import '../styles.dart';
import 'guest_fee_paying.dart';
import 'guest.dart';

class GuestCheckOut extends StatefulWidget {
  GuestCheckOut({Key? key, required this.guest}) : super(key: key);
  Guest guest;
  @override
  _GuestCheckOutState createState() => _GuestCheckOutState();
}

class _GuestCheckOutState extends State<GuestCheckOut> {
  final String _cancelButtonTxt = 'Cancel';
  final String _continueButtonTxt ='Continue';
  final String _checkOutButtonTxt = 'Check out';

  Widget cancelButton (BuildContext context) {
    return TextButton(
      child: Text(_cancelButtonTxt),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
  }
  Widget continueButton () {
    return TextButton(
      child: Text(_continueButtonTxt),
      onPressed:  () {
        Navigator.push(
            context,
            new MaterialPageRoute<void>(builder: (context) => new GuestFeePaying())
        );
      },
    );
  }
  Widget checkOutButton () {
    return ElevatedButton(
      style: Styles.buttonStyle,
      onPressed: () {
          widget.guest.checkOutTime = DateTime.now();//get current time when the checkOutButton is pressed
        },
      child: Styles.text(_checkOutButtonTxt),
    );
  }

  @override
  Widget build(BuildContext context) {
    return checkOutButton();
  }
}
