import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/guest_list/guest_list_provider.dart';
import 'package:registry/guest_list/date_selection_widget.dart';
import 'package:registry/guest_list/guest_item_widget.dart';
import 'package:registry/Utilities/guestProcessor.dart';

class GuestHistoryListWidget extends StatefulWidget {
  const GuestHistoryListWidget({Key? key, required this.guestListProvider,}) : super(key: key);
  final GuestListProvider guestListProvider;
  @override
  _GuestHistoryListWidgetState createState() => _GuestHistoryListWidgetState();
}

class _GuestHistoryListWidgetState extends State<GuestHistoryListWidget> {
  DateTime _selectedDate = DateTime.now().subtract(Duration(days:1));

  @override
  Widget build(BuildContext context) {
    List<Guest> _selectedGuests =
    List.from(GuestProcessor.filterGuestWithDate(widget.guestListProvider, _selectedDate));

    return Scaffold(
      appBar: AppBar(
          title: const Text('Guest History Records')),
      body: Column(children: [
        DateSelectionWidget(
            dateChanged: (DateTime) =>
                setState(() => _selectedDate = DateTime)),
        Expanded(
            child: ListView.builder(
                itemCount: _selectedGuests.length,
                itemBuilder: (context, index) {
                  // Get a specific list
                  final guest = _selectedGuests[index];
                  // Return a list tile widget
                  return GuestItemWidget(
                    guest: guest,
                  );
                }))
      ]),
    );
  }
}