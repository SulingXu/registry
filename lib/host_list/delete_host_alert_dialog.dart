import 'package:flutter/material.dart';
import 'package:registry/styles.dart';

class DeleteHostAlertDialog extends StatefulWidget {
  const DeleteHostAlertDialog({Key? key, required this.hostName, required this.deleteHost}) : super(key: key);
  final String hostName;
  final void Function() deleteHost;
  @override
  _DeleteHostAlertDialogState createState() => _DeleteHostAlertDialogState();
}

class _DeleteHostAlertDialogState extends State<DeleteHostAlertDialog> {
  final String _titleTxt = 'Delete A Host';
  final String _questionTxt = 'Are you sure to delete the host ';
  final String _cancelButtonTxt = 'No';
  final String _continueButtonTxt ='Yes';

  Widget cancelButton (BuildContext context) {
    return TextButton(
      child: Text(_cancelButtonTxt),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget continueButton (BuildContext context) {
    return TextButton(
      child: Text(_continueButtonTxt),
      onPressed:  () {
        widget.deleteHost();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Styles.text(_titleTxt, Styles.middleTextWithDefaultColor)),
      insetPadding: EdgeInsets.symmetric(horizontal: 100, vertical: 250),
      content: Center(child: Styles.paddingWithText(_questionTxt + widget.hostName + '?')),
      actions: [
        cancelButton(context),
        continueButton(context),
      ],
    );
  }
}
