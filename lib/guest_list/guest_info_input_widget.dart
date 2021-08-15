import 'package:flutter/material.dart';
import 'guest_status_widget.dart';
import 'guest.dart';
import 'guest_list_widget.dart';
import 'guest_list_provider.dart';
import '../styles.dart';

class GuestInfoInputWidget extends StatefulWidget {
  const GuestInfoInputWidget({Key? key, required this.chosenHostName, required this.guestListProvider}) : super(key: key);
  final String chosenHostName;
  final GuestListProvider guestListProvider;

  @override
  _GuestInfoInputWidgetState createState() => _GuestInfoInputWidgetState();
}

class _GuestInfoInputWidgetState extends State<GuestInfoInputWidget> {
  final _guestLastNameController = TextEditingController();
  final _guestFirstNameController = TextEditingController();
  final String _firstNameTextPrefix = 'First Name:';
  final String _lastNameTextPrefix = 'Last Name:';
  final String _checkInTxt = 'Check in';
  final String _firstNameInputHintText = 'Enter your first name';
  final String _lastNameInputHintText = 'Enter your last name';
  final String _alertDialogTxt = 'The information cannot be left empty! Please input or choose all of them.';
  Guest _guest = Guest();

  Widget textFormField(TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
  Widget nameInputColumn(String prefix, TextEditingController controller, String hintText){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Styles.text(prefix),
        Container(
          child: textFormField(controller, hintText),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Information"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: nameInputColumn(_firstNameTextPrefix, _guestFirstNameController, _firstNameInputHintText),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: nameInputColumn(_lastNameTextPrefix, _guestLastNameController, _lastNameInputHintText),
          ),
          GuestStatusWidget(guest: _guest),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: ElevatedButton(
              style: Styles.buttonStyle,
              onPressed: _onPressed,
              child: Text(_checkInTxt),
            )
          ),
        ],
      )
    );
  }
  void _onPressed() {
    if (_guestFirstNameController.text != '' && _guestLastNameController.text != '' && _guest.status != null) {
      _guest.checkInTime = DateTime.now();
      _guest.chosenHostName = widget.chosenHostName;
      _guest.lastName = _guestLastNameController.text;
      _guest.firstName = _guestFirstNameController.text;
      widget.guestListProvider.addGuest(_guest);
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute<void>(builder: (context) => GuestListWidget(guestListProvider: widget.guestListProvider))
      );
      // Navigator.pushReplacementNamed(context, '/guestList');
    } else {
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(_alertDialogTxt),
          );
        },
      );
    }
  }
}
