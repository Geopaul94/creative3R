import 'package:intl/intl.dart';

String formatNewstime(String isoDateString) {
  try {
    // Step 1: Parse the ISO 8601 date string into a DateTime object
    DateTime utcDate = DateTime.parse(isoDateString);

    // Step 2: Convert the UTC date to the local time zone
    DateTime localDate = utcDate.toLocal();

    // Step 3: Format the date using DateFormat
    String formattedDate = DateFormat('dd MMM yyyy hh:mm a').format(localDate);

    return formattedDate;
  } catch (e) {
    // Handle invalid date strings gracefully
    return 'Invalid Date';
  }
}