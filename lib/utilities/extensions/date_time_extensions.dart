// date time extension that takes a date time and converts it to MM/DD/YYYY
extension DateTimeExtensions on DateTime {
  String toFormatted() {
    return "$month/$day/$year";
  }
}
