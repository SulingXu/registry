import 'host.dart';

// Provide a list of hosts and APIs to manipulate the host list.
class HostListProvider {

  // internal list of hosts, can be changed by api.
  List<Host> _hosts = [
    Host("Suling Xu"),
    Host("Nan Wang")
  ];

  // host list provider api: provide a list of hosts
  List<Host> provideHosts() {
    return _hosts;
  }

  // API to add a new host
  void addHost(Host host) {
    _hosts.add(host);
  }

  // API to delete a host
  void deleteHost(Host host) {
    _hosts.remove(host);
  }
}