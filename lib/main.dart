import 'package:flutter/material.dart';
import 'host_list/host_list_widget.dart';
import 'host_list/host_list_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Host list provider
  final _hostListProvider = HostListProvider();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HostListWidget(hostListProvider: _hostListProvider),
    );
  }
}
