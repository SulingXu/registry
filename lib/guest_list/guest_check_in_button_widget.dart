import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest_list_provider.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/host_list/host_list_provider.dart';
import 'package:registry/guest_list/guest_list_widget.dart';
import '../styles.dart';

class GuestCheckInButtonWidget extends StatefulWidget {
  GuestCheckInButtonWidget({Key? key, required this.formKey, required this.guestListProvider, required this.hostListProvider, required this.guest, required this.chosenHostName, required this.guestLastNameController, required this.guestFirstNameController}) : super(key: key);
  GlobalKey<FormState> formKey;
  GuestListProvider guestListProvider;
  HostListProvider hostListProvider;
  Guest guest;
  String chosenHostName;
  TextEditingController guestLastNameController;
  TextEditingController guestFirstNameController;

  @override
  _GuestCheckInButtonWidgetState createState() => _GuestCheckInButtonWidgetState();
}

class _GuestCheckInButtonWidgetState extends State<GuestCheckInButtonWidget> {
  final String _checkInTxt = 'Check in';
  final String _uncheckOutAlertDialogTxt = "The guest has already existed and hasn't checked out.\n\n""Please Reenter or Go to the Guest Records Page directly.";
  final String _warningTitle = 'Warning';
  final String _goToGuestRecordsTxt = 'Go to Guest Records';
  final String _reenterTxt = 'Reenter';

  Widget jumpButton (BuildContext context) {
    return TextButton(
      child: Text(_goToGuestRecordsTxt),
      onPressed: () {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute<void>(builder: (context) => GuestListWidget(hostListProvider: widget.hostListProvider, guestListProvider: widget.guestListProvider))
        );
      },
    );
  }

  Widget reenterButton (BuildContext context) {
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
      if (_isUnCheckOutGuest()) {
        showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text(_warningTitle)),
              content: Styles.text(
                  _uncheckOutAlertDialogTxt, Styles.SmallTextWithRedColor),
              actions: [
                reenterButton(context),
                jumpButton(context)
              ],
            );
          },
        );
      } else {
        widget.guest.checkInTime = DateTime.now();
        widget.guest.chosenHostName = widget.chosenHostName;
        widget.guest.lastName = widget.guestLastNameController.text;
        widget.guest.firstName = widget.guestFirstNameController.text;
        widget.guestListProvider.addGuest(widget.guest);
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute<void>(builder: (context) =>
                GuestListWidget(hostListProvider: widget.hostListProvider, guestListProvider: widget.guestListProvider))
        );
      }
    }
  }

  bool _isUnCheckOutGuest() {
    widget.guest.lastName = widget.guestLastNameController.text;
    widget.guest.firstName = widget.guestFirstNameController.text;
    var i = 0;
    Guest existedGuest;
    while(i < widget.guestListProvider.provideGuests().length) {
      if(!widget.guestListProvider.provideGuests()[i].hasCheckedOut) {//haven't checked out
        existedGuest = widget.guestListProvider.provideGuests()[i];
        if ((widget.guest.lastName.toLowerCase() == existedGuest.lastName.toLowerCase()) &&
            (widget.guest.firstName.toLowerCase() == existedGuest.firstName.toLowerCase())) {
          return true;
        }
      }
      i++;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Center(
        child:ElevatedButton(
        style: Styles.buttonStyle,
        onPressed: _onPressed,
        child: Text(_checkInTxt)
        ),
      )
    );
  }
}
