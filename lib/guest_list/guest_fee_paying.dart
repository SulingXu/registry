import 'package:flutter/material.dart';
import 'package:registry/styles.dart';

class GuestFeePaying extends StatefulWidget {
  const GuestFeePaying({Key? key, required this.guestFee}) : super(key: key);
  final double guestFee;
  @override
  _GuestFeePayingState createState() => _GuestFeePayingState();
}

class _GuestFeePayingState extends State<GuestFeePaying> {
  final String _paymentDoneTxt = 'done';
  @override
  Widget build(BuildContext context) {
    final String _feeInformation = 'pay ${widget.guestFee} SEK.';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Styles.text(_feeInformation),
        const SizedBox(height: 20),
        new Image.asset(
          'assets/images/qr-code.png',
          width: 500.0,
          height: 500.0,
          fit: BoxFit.cover,
        ),
        ElevatedButton(
          style: Styles.buttonStyle,
          onPressed: () {
            Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
          },
          child: Styles.text(_paymentDoneTxt),
        ),
      ]
    );
  }
}
