String kpDate(dynamic value) {
  if (value == null) return '—';

  DateTime? dt;
  if (value is DateTime) {
    dt = value;
  } else {
    final s = value.toString();
    dt = DateTime.tryParse(s);
  }
  if (dt == null) return value.toString();

  final local = dt.toLocal();
  final dd = local.day.toString().padLeft(2, '0');
  final mm = local.month.toString().padLeft(2, '0');
  final yyyy = local.year.toString();
  final hh = local.hour.toString().padLeft(2, '0');
  final mi = local.minute.toString().padLeft(2, '0');

  // Если время ровно 00:00 — не показываем часы
  if (hh == '00' && mi == '00') return '$dd.$mm.$yyyy';
  return '$dd.$mm.$yyyy, $hh:$mi';
}
