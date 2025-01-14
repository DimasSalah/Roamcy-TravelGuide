class GFormat {
  String formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'p.m' : 'a.m';

    // Convert 24 hour format to 12 hour format
    final displayHour = hour > 12 ? hour - 12 : hour;
    // Handle midnight (0:00) case
    final finalHour = displayHour == 0 ? 12 : displayHour;

    // Pad minute with leading zero if needed
    final displayMinute = minute.toString().padLeft(2, '0');

    return '$finalHour:$displayMinute $period';
  }
}
