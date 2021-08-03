import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest_list_provider.dart';
import 'guest_list_provider.dart';

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
      appBar: AppBar(title: Text("Guest List View")),
      body: ListView.builder(
        itemCount: widget.guestListProvider.provideGuests().length,
        itemBuilder: (context, index) {
          // Get a specific list
          final guest = widget.guestListProvider.provideGuests()[index];
          // Return a list tile widget
          return ListTile(
            title: Text(guest.chosenHostName ?? ''),
          );
        },
      )
    );
  }
}
