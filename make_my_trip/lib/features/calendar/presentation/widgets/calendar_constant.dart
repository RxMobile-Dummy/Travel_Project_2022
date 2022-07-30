import 'package:intl/intl.dart';

class Constant {
  static convertDate(DateTime date) {
    return "${date.day} ${DateFormat("MMMM").format(date as DateTime).substring(0, 3)}";
  }

  static convertSubDate(DateTime date) {
    return "'${date.year.toString().substring(2)}, ${DateFormat('EEEE').format(date as DateTime).substring(0, 3)}";
  }
}
