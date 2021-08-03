import 'guest.dart';

// Provide a list of guests and APIs to manipulate the guest list.
class GuestListProvider {
  // internal list of guests, can be changed by api.
  List<Guest> _guests = [];

  // guest list provider api: provide a list of guests
  List<Guest> provideGuests() {
    return _guests;
  }

  // API to add a new guest
  void addGuest(Guest guest) {
    _guests.add(guest);
  }
}