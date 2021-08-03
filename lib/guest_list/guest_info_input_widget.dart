import 'package:flutter/material.dart';
import 'guest_status_widget.dart';
import 'guest.dart';
import 'guest_list_widget.dart';
import 'guest_list_provider.dart';

final TextStyle textStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
Widget text(String txtString){
  return Text(
      txtString,
      style: textStyle
  );
}

class GuestInfoInputWidget extends StatefulWidget {
  const GuestInfoInputWidget({Key? key, required this.chosenHostName}) : super(key: key);
  final String chosenHostName;

  @override
  _GuestInfoInputWidgetState createState() => _GuestInfoInputWidgetState();
}

class _GuestInfoInputWidgetState extends State<GuestInfoInputWidget> {
  final _guestLastNameController = TextEditingController();
  final _guestFirstNameController = TextEditingController();
  final GuestListProvider _guestListProvider = GuestListProvider();
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 18), padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15));
  final String _firstNameTxt = 'First Name:';
  final String _lastNameTxt = 'Last Name:';
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
  Widget nameInputColumn(String txtString, TextEditingController controller, String hintText){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(txtString),
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
            child: nameInputColumn(_firstNameTxt, _guestFirstNameController, _firstNameInputHintText),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: nameInputColumn(_lastNameTxt, _guestLastNameController, _lastNameInputHintText),
          ),
          GuestStatusWidget(guest: _guest),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: ElevatedButton(
              style: buttonStyle,
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
      _guest.firstName = _guestLastNameController.text;
      _guestListProvider.addGuest(_guest);
      Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new GuestListWidget(guestListProvider: _guestListProvider))
      );
    } else {
      showDialog(
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
