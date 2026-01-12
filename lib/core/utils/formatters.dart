import 'package:intl/intl.dart';
import 'package:gloss_bloom/core/constants/app_constants.dart';

class CurrencyFormatter {
  static final NumberFormat _formatter = NumberFormat.currency(
    locale: 'fr_FR',
    symbol: AppConstants.currencySymbol,
    decimalDigits: 0,
  );

  static String format(double amount) {
    return _formatter.format(amount);
  }
}

class DateFormatter {
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');
  static final DateFormat _timeFormat = DateFormat('HH:mm');

  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  static String formatDateTime(DateTime dateTime) {
    return _dateTimeFormat.format(dateTime);
  }

  static String formatTime(DateTime time) {
    return _timeFormat.format(time);
  }
}

class TextFormatter {
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}