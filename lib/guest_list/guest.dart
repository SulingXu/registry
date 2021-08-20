//guest model
import 'package:registry/guest_list/guest_status.dart';

class Guest {
  String firstName;
  String lastName;
  String? chosenHostName;
  GuestStatus status;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  double fee;
  bool hasCheckedOut;

  Guest(this.firstName, this.lastName, this.chosenHostName, this.status,
    this.checkInTime, this.checkOutTime, this.fee, this.hasCheckedOut);
}