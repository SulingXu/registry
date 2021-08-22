abstract class DateProcessor {
  static bool compareTwoDate(DateTime? d1, DateTime? d2) {
    if (d1 != null && d2 != null) {
      if ((d1.year == d2.year) && (d1.month == d2.month) &&
          (d1.day == d2.day)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}