import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String formatDate(String inputDate) {
  initializeDateFormatting();
  // Parse the input string
  final parsedDate = DateFormat('dd-MM-yyyy').parse(inputDate);

  // Format the date as desired: 'dd MMMM yyyy'
  final formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(parsedDate);

  return formattedDate;
}
