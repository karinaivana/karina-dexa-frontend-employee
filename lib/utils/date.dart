import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

const String INDONESIA_FORMAT = 'id_ID';

String showDayAndDate(DateTime dateTime) {
  dateTime = dateTime.toLocal();

  initializeDateFormatting(INDONESIA_FORMAT);

  DateFormat formatter = DateFormat('EEEE, d MMM yyyy', INDONESIA_FORMAT);

  return formatter.format(dateTime);
}

String showDateOnly(DateTime? dateTime) {
  if (dateTime == null) return "";

  dateTime = dateTime.toLocal();

  initializeDateFormatting(INDONESIA_FORMAT);

  DateFormat formatter = DateFormat('d MMM yyyy', INDONESIA_FORMAT);

  return formatter.format(dateTime);
}

String showTimeOnly(DateTime? dateTime) {
  if (dateTime == null) return "";

  dateTime = dateTime.toLocal();

  initializeDateFormatting(INDONESIA_FORMAT);

  DateFormat formatter = DateFormat('HH:mm', INDONESIA_FORMAT);

  return formatter.format(dateTime);
}

String? getDateOnly(DateTime? dateTime) {
  if (dateTime == null) return null;

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  return dateFormat.format(dateTime);
}
