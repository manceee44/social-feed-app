import 'package:intl/intl.dart';

abstract final class DateFormatter {
  static String formatPostDateTime(String date, String time) {
    if (date.isEmpty) return '';

    try {
      final parts = date.split('/');
      if (parts.length != 3) return date;

      final month = int.parse(parts[0]);
      final day = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      DateTime dateTime = DateTime(year, month, day);

      if (time.isNotEmpty) {
        final timeParts = time.split(':');
        if (timeParts.length >= 2) {
          dateTime = DateTime(
            year,
            month,
            day,
            int.parse(timeParts[0]),
            int.parse(timeParts[1]),
            timeParts.length > 2 ? int.parse(timeParts[2]) : 0,
          );
        }
      }

      return DateFormat('MMM d yyyy \'at\' h:mm a').format(dateTime);
    } catch (_) {
      return date;
    }
  }
}
