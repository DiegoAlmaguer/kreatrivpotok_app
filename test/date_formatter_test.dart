import 'package:flutter_test/flutter_test.dart';
import 'package:kreativ_potok_app/core/utils/date_formatter.dart';

void main() {
  test('DateFormatter.date returns formatted date', () {
    final value = DateFormatter.date(DateTime(2026, 2, 19));
    expect(value, '19.02.2026');
  });

  test('DateFormatter.date returns fallback for invalid', () {
    expect(DateFormatter.date('bad-input'), '—');
  });
}
