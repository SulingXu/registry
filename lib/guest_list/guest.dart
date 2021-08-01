//guest model
import 'package:registry/guest_list/guest_status.dart';
import 'GuestStatus.dart';

class Guest {
  String firstName;
  String lastName;
  GuestStatus? status;
  DateTime checkInTime;
  DateTime checkOutTime;
  final double fee;

  Guest({this.firstName = "", this.lastName = "", this.status = null,
    DateTime? checkInTime, DateTime? checkOutTime, this.fee = 0}): this.checkInTime = checkInTime ?? DateTime.now(), this.checkOutTime = checkOutTime ?? DateTime.now();

}