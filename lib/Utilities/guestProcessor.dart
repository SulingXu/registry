import 'package:registry/guest_list/guest.dart';
import 'package:registry/guest_list/guest_list_provider.dart';
import 'package:registry/Utilities/dateProcessor.dart';

abstract class GuestProcessor {
  static List<Guest> filterGuestWithDate(GuestListProvider guestListProvider, DateTime selectedDate) {
    int i = 0;
    List<Guest> _selectedGuests = [];
    while (i < guestListProvider.provideGuests().length) {
      if (guestListProvider.provideGuests()[i].checkInTime != null) {
        DateTime recordedDate =
        guestListProvider.provideGuests()[i].checkInTime!;
        if (DateProcessor.compareTwoDate(selectedDate, recordedDate)) {
          _selectedGuests.add(guestListProvider.provideGuests()[i]);
        }
      }
      i++;
    }
    return _selectedGuests;
  }

}