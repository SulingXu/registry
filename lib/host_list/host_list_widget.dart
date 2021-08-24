import 'package:flutter/material.dart';
import 'package:registry/host_list/host.dart';
import 'package:registry/host_list/add_new_host_widget.dart';
import 'package:registry/host_list/host_list_provider.dart';
import 'package:registry/guest_list/guest.dart';
import 'package:registry/guest_list/guest_info_input_widget.dart';

// Host list view
class HostListWidget extends StatefulWidget {
  const HostListWidget(
      {Key? key,
      required this.hostListProvider,
      required this.addNewGuest,
      required this.checkDuplicatedGuest})
      : super(key: key);

  // Dependency: host list provider
  final HostListProvider hostListProvider;
  final Function(Guest) addNewGuest;
  final bool Function(String, String) checkDuplicatedGuest;

  @override
  _HostListWidgetState createState() => _HostListWidgetState();
}

class _HostListWidgetState extends State<HostListWidget> {
  bool _checkDuplicatedHost(String newHostName) {
    int i = 0;
    Host existingHost;
    while (i < widget.hostListProvider.provideHosts().length) {
      existingHost = widget.hostListProvider.provideHosts()[i];
      if (newHostName.toLowerCase() == existingHost.name.toLowerCase()) {
        return true;
      }
      i++;
    }
    return false;
  }

  void _completion(String newHostName) {
    setState(() {
      widget.hostListProvider.addHost(Host(newHostName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Host List View")),
      body: ListView.builder(
        itemCount: widget.hostListProvider.provideHosts().length,
        itemBuilder: (context, index) {
          // Get a specific host
          final host = widget.hostListProvider.provideHosts()[index];
          // Return a list tile widget
          return Column(children: [
            ListTile(
                title: Text(host.name),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute<void>(
                          builder: (context) => new GuestInfoInputWidget(
                                chosenHostName: host.name,
                                addNewGuest: widget.addNewGuest,
                                checkDuplicatedGuest:
                                    widget.checkDuplicatedGuest,
                              )));
                }),
            Divider(),
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AddNewHostWidget(
                  checkDuplicatedHost: _checkDuplicatedHost,
                  completion: _completion,
                );
              });
        },
        tooltip: "Add Host",
        child: const Icon(Icons.add),
      ),
    );
  }
}
