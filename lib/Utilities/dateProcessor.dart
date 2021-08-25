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

  static String getHrMin(DateTime? time) {
    if (time == null) {
      return '---';
    } else {
      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    }
  }

  static String getMonDayHrMin(DateTime? time) {
    if (time == null) {
      return '---';
    } else {
      return "${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    }
  }

  static String calTotalTime(DateTime? startTime, DateTime? endTime, String wrongTimewarning) {
    if(startTime == null || endTime == null ) {
      return wrongTimewarning;
    }
    double totalTime = (endTime.day * 24 + endTime.hour + (endTime.minute / 60)) -
        (startTime.day * 24 + startTime.hour + (startTime.minute / 60));
    int hours = totalTime.floor();
    int minuts = ((totalTime - totalTime.floorToDouble()) * 60).round();
    return (hours == 0)
        ? '${minuts}min'
        : (minuts == 0) ? '${hours}hr' : '${hours}hr ${minuts}min';
  }
}