import 'package:flutter/material.dart';
import '../styles.dart';
import 'package:flutter/services.dart';
import 'package:registry/host_list/host.dart';
import 'package:registry/host_list/host_list_provider.dart';

class AddNewHostWidget extends StatefulWidget {
  const AddNewHostWidget(
      {Key? key, required this.hostListProvider, required this.context, required this.completion})
      : super(key: key);
  final HostListProvider hostListProvider;
  final BuildContext context;
  final VoidCallback completion;

  @override
  _AddNewHostWidgetState createState() => _AddNewHostWidgetState();
}

class _AddNewHostWidgetState extends State<AddNewHostWidget> {
  final _formKey = GlobalKey<FormState>();
  final _hostFirstNameController = TextEditingController();
  final _hostLastNameController = TextEditingController();
  String? _hostNameTxt = null;
  final String _onlyLettersAllowedAlert = '(Only letters are allowed for names)';
  final String _saveHostButtonTxt = 'Save';
  final String _hostFirstNamePrefix = 'First Name: ';
  final String _hostLastNamePrefix = 'Last Name: ';
  final String _addHostTitle = 'Add a Host';
  final String _hostFirstNameInputHintTxt = "Enter host' first name";
  final String _hostLastNameInputHintTxt = "Enter host' last name";
  final String _emptyInputAlertTxt = 'Please enter some text';
  final String _onlySpaceInputAlertTxt = 'Please enter a valid name';
  final double _widthOfContainer = 180.0;
  bool _isVisible = false;

  void dispose() {
    // Clean up the controller when the widget is disposed.
    _hostFirstNameController.dispose();
    _hostLastNameController.dispose();
    super.dispose();
  }

  bool _hasIdenticalHostName(String newHostName) {
    var i = 0;
    Host existingHost;
    while(i < widget.hostListProvider.provideHosts().length) {
      existingHost = widget.hostListProvider.provideHosts()[i];
      if (newHostName.toLowerCase() == existingHost.name.toLowerCase()) {
        return true;
      }
      i++;
    }
    return false;
  }

  void _addHost(String newHostName) {
    widget.hostListProvider.addHost(Host(_hostNameTxt!));
    widget.completion(); // call the completion handler / function to trigger list updates
  }

  Widget textFormField(TextEditingController nameInputController, String nameInputHint, String emptyInputAlert, String onlySpaceInputAlert) {
    return TextFormField(
      controller: nameInputController,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
      ],
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: nameInputHint,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            _isVisible = false;
          });
          return emptyInputAlert;
        } else if (value == ' ') {
          return onlySpaceInputAlert;
        }
        return null;
      },
    );
  }

  Widget paddingInRowWithNameController(String namePrefix, double widthOfContainer, TextEditingController nameInputController, String nameInputHint, String emptyInputAlert, String onlySpaceInputAlert) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Styles.text(namePrefix, Styles.smallTextWithDefaultColor),
            Container(
              width: widthOfContainer,
              child: textFormField(nameInputController, nameInputHint, emptyInputAlert, onlySpaceInputAlert),
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget savedHostButton = ElevatedButton(
      child: Text(_saveHostButtonTxt),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _hostNameTxt = _hostFirstNameController.text + ' ' + _hostLastNameController.text;
            if(_hasIdenticalHostName(_hostNameTxt!)) {
              setState(() {
                _isVisible = true;
                _hostFirstNameController.text = '';
                _hostLastNameController.text = '';
              });
            }
            else {
              _isVisible = false;
              _addHost(_hostNameTxt!);
              Navigator.of(context).pop();
            }
        }
      },
    );

    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Styles.paddingWithText(_addHostTitle),
                Styles.text(_onlyLettersAllowedAlert, Styles.extralSmallTextWithYellowColor),
                paddingInRowWithNameController(_hostLastNamePrefix, _widthOfContainer, _hostLastNameController, _hostLastNameInputHintTxt, _emptyInputAlertTxt, _onlySpaceInputAlertTxt),
                paddingInRowWithNameController(_hostFirstNamePrefix, _widthOfContainer, _hostFirstNameController, _hostFirstNameInputHintTxt, _emptyInputAlertTxt, _onlySpaceInputAlertTxt),
                Visibility (
                  visible: _isVisible,
                  child: Styles.text("The host name has already existed!\n"
                      "please reenter or choose one!",
                      Styles.extralSmallTextWithRedColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: savedHostButton,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
