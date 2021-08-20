import 'package:flutter/material.dart';
import 'package:registry/guest_list/guest_list_provider.dart';
import 'host_list/host_list_widget.dart';
import 'host_list/host_list_provider.dart';
import 'package:registry/guest_list/guest_list_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Host list provider
  final _hostListProvider = HostListProvider();
  // Guest list provider
  final _guestListProvider = GuestListProvider();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuestListWidget(hostListProvider: _hostListProvider, guestListProvider: _guestListProvider),
    );
  }
}
