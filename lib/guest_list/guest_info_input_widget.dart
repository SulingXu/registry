import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:registry/guest_list/guest_check_in_button_widget.dart';
import 'package:registry/guest_list/guest_status_widget.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/guest_list/guest_list_provider.dart';
import 'package:registry/host_list/host_list_provider.dart';
import 'package:registry/guest_list/guest_status.dart';
import '../styles.dart';

class GuestInfoInputWidget extends StatefulWidget {
  const GuestInfoInputWidget({Key? key, required this.chosenHostName, required this.guestListProvider, required this.hostListProvider}) : super(key: key);
  final String chosenHostName;
  final GuestListProvider guestListProvider;
  final HostListProvider hostListProvider;

  @override
  _GuestInfoInputWidgetState createState() => _GuestInfoInputWidgetState();
}

class _GuestInfoInputWidgetState extends State<GuestInfoInputWidget> {
  final _formKey = GlobalKey<FormState>();
  final _guestLastNameController = TextEditingController();
  final _guestFirstNameController = TextEditingController();
  final String _guestInfoTitle = 'Guest Information';
  final String _firstNameTextPrefix = 'First Name:';
  final String _lastNameTextPrefix = 'Last Name:';
  final String _firstNameInputHintText = 'Enter your first name' + ' (Only letters are allowed)';
  final String _lastNameInputHintText = 'Enter your last name' + ' (Only letters are allowed)';
  final String _emptyInputAlertTxt = 'Please enter some text';
  final String _onlySpaceInputAlertTxt = 'Please enter a valid name';
  Guest _guest = Guest('', '', null, GuestStatus.play, null, null, 0, false);

  Widget textFormField(TextEditingController controller, String hintText, String emptyInputAlert, String onlySpaceInputAlert) {
    return TextFormField(
      controller: controller,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
      ],
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyInputAlert;
        } else if (value.replaceAll(RegExp(' +'), ' ') == ' ') {
          return onlySpaceInputAlert;
        }
        return null;
      },
    );
  }
  Widget nameInputColumn(String prefix, TextEditingController controller, String hintText){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Styles.text(prefix, Styles.middleTextWithDefaultColor),
        Container(
          child: textFormField(controller, hintText, _emptyInputAlertTxt, _onlySpaceInputAlertTxt),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_guestInfoTitle),
      ),
      body: Form(
        key: _formKey,
        child: Column(
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
            GuestCheckInButtonWidget(hostListProvider: widget.hostListProvider,
                formKey: _formKey,
                guestListProvider: widget.guestListProvider,
                guest: _guest,
                chosenHostName: widget.chosenHostName,
                guestLastNameController: _guestLastNameController,
                guestFirstNameController: _guestFirstNameController,
            ),
          ],
        )
      )
    );
  }
}
