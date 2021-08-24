import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/styles.dart';

class GuestCheckInButtonWidget extends StatefulWidget {
  GuestCheckInButtonWidget(
      {Key? key,
      required this.formKey,
      required this.guest,
      required this.chosenHostName,
      required this.guestLastNameController,
      required this.guestFirstNameController,
      required this.addNewGuest,
      required this.checkDuplicatedGuest})
      : super(key: key);
  GlobalKey<FormState> formKey;
  Guest guest;
  String chosenHostName;
  TextEditingController guestLastNameController;
  TextEditingController guestFirstNameController;
  final Function(Guest) addNewGuest;
  final bool Function(String, String) checkDuplicatedGuest;

  @override
  _GuestCheckInButtonWidgetState createState() =>
      _GuestCheckInButtonWidgetState();
}

class _GuestCheckInButtonWidgetState extends State<GuestCheckInButtonWidget> {
  final String _checkInTxt = 'Check in';
  final String _uncheckOutAlertDialogTxt =
      "The guest has already existed and hasn't checked out.\n\n"
      "Please Reenter or Go to the Guest Records Page directly.";
  final String _warningTitle = 'Warning';
  final String _goToGuestRecordsTxt = 'Go to Guest Records';
  final String _reenterTxt = 'Reenter';

  Widget jumpButton(BuildContext context) {
    return TextButton(
      child: Text(_goToGuestRecordsTxt),
      onPressed: () {
        Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
      },
    );
  }

  Widget reEnterButton(BuildContext context) {
    return TextButton(
      child: Text(_reenterTxt),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          widget.guestFirstNameController.text = '';
          widget.guestLastNameController.text = '';
        });
      },
    );
  }

  void _onPressed() {
    if (widget.formKey.currentState!.validate()) {
      widget.guest.lastName = widget.guestLastNameController.text;
      widget.guest.firstName = widget.guestFirstNameController.text;

      if (widget.checkDuplicatedGuest(
          widget.guest.lastName, widget.guest.firstName)) {
        showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text(_warningTitle)),
              content: Styles.text(
                  _uncheckOutAlertDialogTxt, Styles.SmallTextWithRedColor),
              actions: [reEnterButton(context), jumpButton(context)],
            );
          },
        );
      } else {
        widget.guest.checkInTime = DateTime.now();
        widget.guest.chosenHostName = widget.chosenHostName;
        widget.guest.lastName = widget.guestLastNameController.text;
        widget.guest.firstName = widget.guestFirstNameController.text;
        widget.addNewGuest(widget.guest);// call the addNewGuest handler / function to trigger guest list updates
        Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
          child: ElevatedButton(
              style: Styles.buttonStyle,
              onPressed: _onPressed,
              child: Text(_checkInTxt)),
        ));
  }
}
