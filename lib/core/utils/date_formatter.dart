import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static final DateFormat _date = DateFormat('dd.MM.yyyy', 'ru_RU');
  static final DateFormat _dateTime = DateFormat('dd.MM.yyyy HH:mm', 'ru_RU');

  static String date(dynamic value, {String fallback = '—'}) {
    final dt = _toDateTime(value);
    if (dt == null) return fallback;
    return _date.format(dt.toLocal());
  }

  static String dateTime(dynamic value, {String fallback = '—'}) {
    final dt = _toDateTime(value);
    if (dt == null) return fallback;
    return _dateTime.format(dt.toLocal());
  }

  static String relative(dynamic value, {String fallback = '—'}) {
    final dt = _toDateTime(value)?.toLocal();
    if (dt == null) return fallback;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(dt.year, dt.month, dt.day);
    final daysDiff = today.difference(target).inDays;

    if (daysDiff == 0) return 'Сегодня';
    if (daysDiff == 1) return 'Вчера';
    if (daysDiff > 1 && daysDiff <= 30) {
      return '$daysDiff ${_daysAgoWord(daysDiff)} назад';
    }

    return date(dt, fallback: fallback);
  }

  static String dateTimeWithRelative(dynamic value, {String fallback = '—'}) {
    final dt = _toDateTime(value);
    if (dt == null) return fallback;
    final relativeLabel = relative(dt, fallback: fallback);
    final dateTimeLabel = dateTime(dt, fallback: fallback);
    return '$dateTimeLabel · $relativeLabel';
  }

  static String _daysAgoWord(int days) {
    final mod10 = days % 10;
    final mod100 = days % 100;

    if (mod10 == 1 && mod100 != 11) return 'день';
    if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
      return 'дня';
    }
    return 'дней';
  }

  static DateTime? _toDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;

    if (value is int) {
      try {
        return DateTime.fromMillisecondsSinceEpoch(value);
      } catch (_) {
        return null;
      }
    }

    final raw = value.toString().trim();
    if (raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }
}
