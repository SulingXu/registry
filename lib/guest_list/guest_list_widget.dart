import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest_item_widget.dart';
import 'package:registry/guest_list/guest_list_provider.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/guest_list/date_selection_widget.dart';

class GuestListWidget extends StatefulWidget {
  const GuestListWidget({Key? key, required this.guestListProvider}) : super(key: key);
  final GuestListProvider guestListProvider;
  @override
  _GuestListWidgetState createState() => _GuestListWidgetState();
}

class _GuestListWidgetState extends State<GuestListWidget> {
  DateTime _selectedDate = DateTime.now();

  List<Guest> _filterGuestWithDate(DateTime selectedDate) {
    var i = 0;
    List<Guest> _selectedGuests = [];
    DateTime currentDate = DateTime.now();
    if(_compareTwoDate(selectedDate, currentDate)) {
      return widget.guestListProvider.provideGuests();
    }
    while(i < widget.guestListProvider.provideGuests().length) {
      if(widget.guestListProvider.provideGuests()[i].checkInTime != null) {
        DateTime recordedDate = widget.guestListProvider.provideGuests()[i].checkInTime!;
        if(_compareTwoDate(selectedDate, recordedDate)) {
          _selectedGuests.add(widget.guestListProvider.provideGuests()[i]);
        }
      }
      i++;
    }
    return _selectedGuests;
  }

  bool _compareTwoDate(DateTime d1, DateTime d2) {
    if((d1.year == d2.year) && (d1.month == d2.month) && (d1.day == d2.day)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Guest> _selectedGuests = List.from(_filterGuestWithDate(_selectedDate));

    return Scaffold(
      appBar: AppBar(title: const Text('Guest Records'), automaticallyImplyLeading: false),
      body: Column(
          children: [
            DateSelectionWidget(dateChanged: (DateTime) =>
                setState(() => _selectedDate = DateTime)),
            Divider(),
            Expanded(
                child: ListView.builder(
                    itemCount: _selectedGuests.length,
                    itemBuilder: (context, index) {
                      // Get a specific list
                      final guest = _selectedGuests[index];
                      // Return a list tile widget
                      return GuestItemWidget(guest: guest);
                    }
                )
            )
          ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

