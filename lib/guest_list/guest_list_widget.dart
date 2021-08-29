import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest_item_widget.dart';
import 'package:registry/guest_list/guest_list_provider.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/guest_list/guest_history_list_widget.dart';
import 'package:registry/host_list/host_list_provider.dart';
import 'package:registry/host_list/host_list_widget.dart';
import 'package:registry/Utilities/guestProcessor.dart';
import 'package:registry/styles.dart';

class GuestListWidget extends StatefulWidget {
  const GuestListWidget(
      {Key? key,
      required this.guestListProvider,
      required this.hostListProvider})
      : super(key: key);
  final GuestListProvider guestListProvider;
  final HostListProvider hostListProvider;

  @override
  _GuestListWidgetState createState() => _GuestListWidgetState();
}

class _GuestListWidgetState extends State<GuestListWidget> {
  String _historyTxt = 'History';
  DateTime _selectedDate = DateTime.now();

  bool _isUnCheckOutGuest(String guestLastName, String guestFirstName) {
    int i = 0;
    Guest existedGuest;
    while (i < widget.guestListProvider.provideGuests().length) {
      if (!widget.guestListProvider.provideGuests()[i].hasCheckedOut) {
        //haven't checked out
        existedGuest = widget.guestListProvider.provideGuests()[i];
        if ((guestLastName.toLowerCase() ==
                existedGuest.lastName.toLowerCase()) &&
            (guestFirstName.toLowerCase() ==
                existedGuest.firstName.toLowerCase())) {
          return true;
        }
      }
      i++;
    }
    return false;
  }

  bool _checkDuplicatedGuest(String guestLastName, String guestFirstName) {
    if (_isUnCheckOutGuest(guestLastName, guestFirstName)) {
      return true;
    } else {
      return false;
    }
  }

  void _addNewGuest(Guest newGuest) {
    setState(() {
      widget.guestListProvider.addGuest(newGuest);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Guest> _selectedGuests = List.from(GuestProcessor.filterGuestWithDate(
        widget.guestListProvider, _selectedDate));

    return Scaffold(
      appBar: AppBar(
          title: const Text("Guest Today's Records"),
          automaticallyImplyLeading: false),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Styles.text('${_selectedDate.toLocal()}'.split(' ')[0],
                    Styles.middleTextWithDefaultColor),
                const SizedBox(width: 50),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute<void>(
                              builder: (context) => new GuestHistoryListWidget(
                                  guestListProvider:
                                      widget.guestListProvider)));
                    },
                    child: Text(_historyTxt))
              ],
            )),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute<void>(
                  builder: (context) => HostListWidget(
                      hostListProvider: widget.hostListProvider,
                      addNewGuest: _addNewGuest,
                      checkDuplicatedGuest: _checkDuplicatedGuest)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
