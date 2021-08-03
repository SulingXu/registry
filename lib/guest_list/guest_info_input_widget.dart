import 'package:flutter/material.dart';
import 'guest_status_widget.dart';
import 'guest.dart';
import 'guest_list_widget.dart';
import 'guest_list_provider.dart';

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
  final TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  final String firstNameTxt = 'First Name:';
  final String lastNameTxt = 'Last Name:';
  final String checkInTxt = 'Check in';
  final String firstNameInputHintText = 'Enter your first name';
  final String lastNameInputHintText = 'Enter your last name';
  Guest _guest = Guest();

  Widget text(String txtString){
    return Text(
      txtString,
      style: textStyle
    );
  }
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
            child: nameInputColumn(firstNameTxt, _guestFirstNameController, firstNameInputHintText),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: nameInputColumn(lastNameTxt, _guestLastNameController, lastNameInputHintText),
          ),
          GuestStatusWidget(guest: _guest),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: ElevatedButton(
              style: buttonStyle,
              onPressed: _onPressed,
              child: Text(checkInTxt),
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
      print(_guestListProvider.provideGuests()[0].lastName);
      Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new GuestListWidget(guestListProvider: _guestListProvider))
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("The information cannot be left empty! Please input or choose all of them."),
          );
        },
      );
    }
  }
}
