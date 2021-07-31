import 'package:flutter/material.dart';
import 'add_new_host_widget.dart';
import 'host_list_provider.dart';
import '../guest_list/gust_info_input.dart';

// Host list view
class HostListWidget extends StatefulWidget {
  const HostListWidget({Key? key, required this.hostListProvider}) : super(key: key);

  // Dependency: host list provider
  final HostListProvider hostListProvider;

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
                  new MaterialPageRoute(builder: (context) => new GuestInfoInput(chosenHostName: host.name)));
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          showDialog(
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
        child: Icon(Icons.add),
      ),
    );
  }
}
