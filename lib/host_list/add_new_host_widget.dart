import 'package:flutter/material.dart';
import 'host.dart';
import 'host_list_provider.dart';

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
  final _hostNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    Widget savedHostButton = ElevatedButton(
      child: Text("Save"),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _addHost();
          Navigator.of(context).pop();
        }
      },
    );

    Widget formInAlertDialog = Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Add a Host',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Host Name: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              Container(
                width: 115.0,
                child: TextFormField(
                  controller:
                  _hostNameController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter the host name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ))
              ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: savedHostButton,
          )
        ],
      ),
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
          formInAlertDialog,
        ],
      ),
    );
  }

  // Private methods
  void _addHost() {
      widget.hostListProvider.addHost(
          Host(_hostNameController.text));
      widget.completion(); // call the completion handler / function to trigger list updates
  }
}
