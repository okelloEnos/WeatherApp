import 'package:intl/intl.dart';

class DateTimeUtils{

  static String formatTimestamp({required int timestamp}) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ';
  }

  static String formattedDate(DateTime dateTime) {
    var formatter = DateFormat('MMMM dd, yyyy - h:mm a');
    return formatter.format(dateTime.toLocal());
  }

  static String formattedDateHeader(DateTime dateTime) {
    var formatter = DateFormat('EEEE, MMMM dd, yyyy');
    return formatter.format(dateTime.toLocal());
  }
}