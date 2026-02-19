import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static final DateFormat _date = DateFormat('dd.MM.yyyy', 'ru_RU');

  static String date(dynamic input) {
    final dt = _toDate(input);
    if (dt == null) return '—';
    return _date.format(dt.toLocal());
  }

  static DateTime? _toDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }
}
