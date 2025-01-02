import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  // Example: 2024-12-20T16:25:00-0300
  String toSwiftDateISO8601() {
    final date = DateFormat('yyyy-MM-ddTHH:mm:ss').format(this);
    return '${date}America/Sao_Paulo';
  }
}
