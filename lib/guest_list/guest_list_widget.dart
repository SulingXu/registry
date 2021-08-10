import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest_item_widget.dart';
import 'package:registry/guest_list/guest_list_provider.dart';
import 'package:registry/main.dart';
import 'package:registry/guest_list/guest_select_date.dart';

class GuestListWidget extends StatefulWidget {
  const GuestListWidget({Key? key, required this.guestListProvider}) : super(key: key);
  final GuestListProvider guestListProvider;
  @override
  _GuestListWidgetState createState() => _GuestListWidgetState();
}

class _GuestListWidgetState extends State<GuestListWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Guest Records")),
      body: Column (
        children: [
          DateSelectionWidget(completion: () {
            setState(() {});
          }),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.guestListProvider.provideGuests().length,
              itemBuilder: (context, index) {
                // Get a specific list
                final guest = widget.guestListProvider.provideGuests()[index];
                // Return a list tile widget
                return GuestItemWidget(guest: guest);
                }
            )
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            new MaterialPageRoute<void>(builder: (context) => new MyApp(guestListProvider: widget.guestListProvider)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
