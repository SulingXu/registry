import 'package:flutter/material.dart';
import 'guest_status_widget.dart';
import 'guest.dart';
import 'guest_list_widget.dart';

class GuestInfoInputWidget extends StatefulWidget {
  const GuestInfoInputWidget({Key? key, required this.chosenHostName}) : super(key: key);
  final String chosenHostName;
  @override
  _GuestInfoInputWidgetState createState() => _GuestInfoInputWidgetState();
}

class _GuestInfoInputWidgetState extends State<GuestInfoInputWidget> {
  final _guestLastNameController = TextEditingController();
  final _guestFirstNameController = TextEditingController();
  Guest oneGuest = Guest();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 18), padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'First Name:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Container(
                  child: TextFormField(
                    controller: _guestFirstNameController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Enter your first name',
                    ),
                  )
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last Name:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Container(
                  child: TextFormField(
                    controller: _guestLastNameController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Enter your last name',
                    ),
                    // validator:(String? value) => value!.isEmpty? 'Last name cannot be empty' :null,
                  )
              ),
            ],
          ),
        ),
        GuestStatusWidget(oneGuest: oneGuest),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: ElevatedButton(
              style: style,
              onPressed: () {
                if (_guestFirstNameController.text != '' && _guestLastNameController.text != '' && oneGuest.status != null) {
                  oneGuest.checkInTime = DateTime.now();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new GuestListWidget(chosenHostName: widget.chosenHostName, oneGuest: oneGuest))
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
              },
              child: const Text('Check in'),
            )
        ),
      ],
    );;
  }
}
