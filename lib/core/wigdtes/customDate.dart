import 'package:intl/intl.dart';

class StylesDate{
  static String formatLastMessageTime(String lastMessageTime) {
    DateTime lastMessageDateTime = DateTime.parse(lastMessageTime);
    DateTime now = DateTime.now();
    if (now.difference(lastMessageDateTime).inDays == 0) {
      return DateFormat.jm().format(lastMessageDateTime);
    } else {
      return DateFormat('MMM dd, yyyy').format(lastMessageDateTime);
    }
  }

  static String getLastActiveTime(String lastActivated) {
    final DateTime lastActiveDate = DateTime.parse(lastActivated);
    final DateTime now = DateTime.now();
    final DateFormat timeFormat = DateFormat.jm();
    final DateFormat dateFormat = DateFormat('MMM d, h:mm a');
    if (lastActiveDate.year == now.year &&
        lastActiveDate.month == now.month &&
        lastActiveDate.day == now.day  ) {
      return 'Today at ${timeFormat.format(lastActiveDate)}';
    } else {
      return dateFormat.format(lastActiveDate);
    }
  }

}