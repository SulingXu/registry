//guest model
import 'package:registry/guest_list/guest_status.dart';
import 'guest_status.dart';

class Guest {
  String firstName;
  String lastName;
  String? chosenHostName;
  GuestStatus status;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  double fee;
  bool hasCheckedOut;

  Guest({this.firstName = "", this.lastName = "", this.chosenHostName = null, this.status = GuestStatus.play,
    this.checkInTime = null, this.checkOutTime = null, this.fee = 0, this.hasCheckedOut = false});
}