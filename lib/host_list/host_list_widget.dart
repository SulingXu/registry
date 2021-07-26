import 'package:flutter/material.dart';
import 'host.dart';
import 'host_list_provider.dart';

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
          return ListTile(title: Text(host.name));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHost,
        tooltip: "Add Host",
        child: Icon(Icons.add),
      ),
    );
  }

  // Private methods
  void _addHost() {
    setState(() {
      widget.hostListProvider.addHost(Host("New Host"));
    });
  }
}

