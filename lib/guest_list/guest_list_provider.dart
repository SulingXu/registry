import 'package:registry/guest_list/guest.dart';
import 'package:registry/guest_list/guest_status.dart';

// Provide a list of guests and APIs to manipulate the guest list.
class GuestListProvider {
  // internal list of guests, can be changed by api.
  List<Guest> _guests = [
    Guest('Guest', 'A', 'Suling Xu', GuestStatus.play, DateTime.parse('2021-08-19 20:05:05'), null, 0, false),
    Guest('Guest', 'B', 'Nan Wang', GuestStatus.watch, DateTime.parse('2021-08-19 22:05:00'), null, 0, false),
    Guest('Guest', 'C', 'Suling Xu', GuestStatus.play, DateTime.parse('2021-08-20 12:00:00'), DateTime.parse('2021-08-20 14:00:00'), 120, true),
    Guest('Guest', 'D', 'Nan Wang', GuestStatus.watch, DateTime.parse('2021-08-20 17:10:00'), null, 0, false),
    Guest('Guest', 'E', 'Nan Wang', GuestStatus.play, DateTime.parse('2021-08-20 17:30:00'), null, 0, false)
  ];

  // guest list provider api: provide a list of guests
  List<Guest> provideGuests() {
    return _guests;
  }

  // API to add a new guest
  void addGuest(Guest guest) {
    _guests.add(guest);
  }
}