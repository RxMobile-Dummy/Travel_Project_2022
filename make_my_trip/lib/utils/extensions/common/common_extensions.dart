import 'package:intl/intl.dart';

extension FormatCurrency on int {
  String formatCurrency({bool addYen = true}) {
    return '${addYen ? "¥" : ""}${NumberFormat('#,###', 'ja_JP').format(this)}';
  }
}

extension IsAtSameDate on DateTime {
  bool isAtSameDate(DateTime date) =>
      year == date.year && month == date.month && day == date.day;
}

extension ToShortDateFormat on DateTime {
  String toShortDateFormat() => DateFormat.MMMd('ja_JP').format(this);
}

extension ToYMdDateFormat on DateTime {
  String toYMdDateFormat() => DateFormat.yMMMd('ja_JP').format(this);
}

extension EmailValidator on String {
  bool isEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension ToProgramTimeFormat on DateTime {
  String toProgramTimeFormat() => DateFormat('HH:mm').format(this);
}

extension ToTimeSlotTimeFormat on DateTime {
  String toTimeSlotTimeFormat() => DateFormat('HH時mm分').format(this);
}

extension ToProgramDateFormat on DateTime {
  String toProgramDateFormat() => DateFormat('MM/dd').format(this);
}

extension ToGetWeekDayFormat on DateTime {
  String toGetWeekDayFormat() => DateFormat('E').format(this);
}

extension NumericValidation on String {
  bool isNumericOnly() {
    return RegExp(r'\d').hasMatch(this);
  }
}

extension PriceApi on String {
  String changePriceApi() {
    return this.replaceAll("₹", "").replaceAll("+", "").trim();
  }

  List changePriceToList() {
    return this.split("-");
  }
}
