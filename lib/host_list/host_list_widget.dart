import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest_list_provider.dart';
import 'add_new_host_widget.dart';
import 'host_list_provider.dart';
import '../guest_list/guest_info_input_widget.dart';

// Host list view
class HostListWidget extends StatefulWidget {
  const HostListWidget({Key? key, required this.hostListProvider, required this.guestListProvider}) : super(key: key);

  // Dependency: host list provider
  final HostListProvider hostListProvider;
  final GuestListProvider guestListProvider;

  @override
  _HostListWidgetState createState() => _HostListWidgetState();
}

class _HostListWidgetState extends State<HostListWidget> {
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
          return ListTile(
            title: Text(host.name),
            onTap:(){
              Navigator.push(context,
                  new MaterialPageRoute<void>(builder: (context) => new GuestInfoInputWidget(chosenHostName: host.name, guestListProvider: widget.guestListProvider)));
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AddNewHostWidget(
                  hostListProvider: widget.hostListProvider,
                  context: context,
                  completion: () {
                    setState(() {});
                    },
              );
            });
          },
        tooltip: "Add Host",
        child: const Icon(Icons.add),
      ),
    );
  }
}

