// Money format
import 'package:intl/intl.dart';

final NumberFormat formatCurrency = NumberFormat.simpleCurrency(
  locale: "es_MX",
  name: "\$",
  decimalDigits: 2,
);
