import '../exceptions/app_exception.dart';

enum NotePriority {
  normal('normal'),
  important('important'),
  veryImportant('very important');

  const NotePriority(this.type);
  final String type;

  factory NotePriority.fromString(String str) {
    switch (str) {
      case 'normal':
        return NotePriority.normal;
      case 'important':
        return NotePriority.important;
      case 'very important':
        return NotePriority.veryImportant;
      default:
        throw AppException(message: 'UnImplemented NotePriority Error');
    }
  }
}
