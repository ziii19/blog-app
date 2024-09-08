import 'package:intl/intl.dart';

String formatDatebydMMMYYYY(DateTime dateTime) {
  return DateFormat('dd MMM, yyyy').format(dateTime);
}
