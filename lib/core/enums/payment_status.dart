import '../exceptions/app_exception.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../localization/translation_keys.dart' as translations;
import '../extensions/string_extension.dart';

enum PaymentStatus {
  paid(code: 1, description: 'done'),
  partiallyPaid(code: 2, description: 'partly done'),
  notPaid(code: 3, description: 'not done');

  const PaymentStatus({required this.code, required this.description});
  final int code;
  final String description;

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'description': description,
    };
  }

  factory PaymentStatus.fromMap(Map<String, dynamic> map) {
    if (map['code'] == 1 && map['description'] == 'done') {
      return PaymentStatus.paid;
    } else if ((map['code'] == 2 && map['description'] == 'partly done')) {
      return PaymentStatus.partiallyPaid;
    } else {
      return PaymentStatus.notPaid;
    }
  }

  factory PaymentStatus.fromString(String str) {
    switch (str) {
      case 'done':
        return PaymentStatus.paid;
      case 'not done':
        return PaymentStatus.notPaid;
      case 'partly done':
        return PaymentStatus.partiallyPaid;
      default:
        throw AppException(message: 'UnImplemented PaymentStatus Error');
    }
  }

  static String getPaymentTranslatedText(String text) {
    switch (text) {
      case 'done':
        return translations.done.tr.capitalizeFirst;
      case 'partly done':
        return translations.partlyPaid.tr.capitalizeFirstOfEach;
      case 'not done':
        return translations.notDone.tr.capitalizeFirstOfEach;
      default:
        return translations.unknown.tr.capitalizeFirst;
    }
  }

  @override
  String toString() =>
      'PaymentStatus = (code: $code , description: $description)';
}
