import 'package:intl/intl.dart';

const List<int> daysInMonth = <int>[
  31,
  -1,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31
];

extension DateTimeExtension on DateTime {
  int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      if (isLeapYear) return 29;
      return 28;
    }
    return daysInMonth[month - 1];
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  String getTime() {
    final formatter = DateFormat('HH:mm');
    final formatted = formatter.format(this);

    return formatted;
  }

  String getYearAndMonth() {
    final formatter = DateFormat('yyyy/MM');
    final formatted = formatter.format(this);
    return formatted;
  }

  String getMonthAndDate() {
    final formatter = DateFormat('MM/dd');
    final formatted = formatter.format(this);
    return formatted;
  }

  String getMonthAndDateTime() {
    final formatter = DateFormat('MM/dd HH:mm');
    final formatted = formatter.format(this);
    return formatted;
  }

  String getDateMonthDay() {
    final formatter = DateFormat('M/dd(E)');
    final formatted = formatter.format(this);
    return formatted;
  }

  String getDefaultDateFormat() {
    final formatter = DateFormat('yyyy/MM/dd');
    final formatted = formatter.format(this);
    return formatted;
  }

  String getFullDateTime() {
    final formatter = DateFormat('yyyy/MM/dd HH:mm');
    final formatted = formatter.format(this);
    return formatted;
  }

  String getDateWeekdayAndTime() {
    final formatter = DateFormat('MM/dd(E) HH:mm');
    final formatted = formatter.format(this);
    return formatted;
  }

  String getMonthDateAndWeekday() {
    final formatter = DateFormat('MM/dd E');
    final formatted = formatter.format(this);
    return formatted;
  }

  String formatISOTime() {
    //converts date into the following format:
    // or 2022-06-04T12:08:56.235-07:00
    final duration = timeZoneOffset;
    if (duration.isNegative) {
      return ("${DateFormat("yyyy-MM-ddTHH:mm:ss").format(this)}-${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    } else {
      return ("${DateFormat("yyyy-MM-ddTHH:mm:ss").format(this)}-${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    }
  }
}
