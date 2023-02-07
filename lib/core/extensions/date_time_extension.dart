import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get yMdFromDateOnly =>
      toString().replaceAll(RegExp(r'\s00:00:00.000'), '');

  String get dMyFromDateSlashSeperated => DateFormat('dd/MM/yyyy').format(this);
  String get dMyFromDateDotSeperated => DateFormat('dd.MM.yyyy').format(this);

  String get yMdFromUTC => toString().substring(0, 10);

  String get mmYYYYString => DateFormat('MM-yyyy').format(this);

  DateTime get lastMillisecondOfMonth => month < 12
      ? DateTime(year, month + 1, 1, 00, 00, 00, -1)
      : DateTime(year + 1, 1, 1, 00, 00, 00, -1);

  DateTime monthEnd(int passedMonth) {
    return passedMonth < 12
        ? DateTime(year, passedMonth + 1, 1, 00, 00, 00, -1)
        : DateTime(year + 1, 1, 1, 00, 00, 00, -1);
  }

  DateTime monthStart(int passedMonth) {
    return DateTime(year, passedMonth, 1);
  }

  List<String> get getCurrentWeekDays {
    final List<String> currentWeekDays = [];
    final now = DateTime.now();
    final currentDay = now.weekday;
    for (int i = currentDay; i >= 1; i--) {
      final preDayDate = now.subtract(Duration(days: i - 1));
      final preDay = DateFormat('yyyy-MM-dd').format(preDayDate);
      currentWeekDays.add(preDay);
    }
    for (int i = currentDay + 1; i <= 7; i++) {
      final nextDayDate = now.add(Duration(days: i - currentDay));
      final nextDay = DateFormat('yyyy-MM-dd').format(nextDayDate);
      currentWeekDays.add(nextDay);
    }
    return currentWeekDays;
  }

  DateTime get firstMillisecondOfMonth => DateTime(year, month, 1);
}
