import 'package:get/get.dart' hide GetStringUtils;
import '../exceptions/app_exception.dart';
import '../../localization/translation_keys.dart' as translations;
import '../extensions/string_extension.dart';

enum CustomerType {
  direct,
  referenced;

  Map<String, dynamic> toMap() {
    return {'customerType': name};
  }

  factory CustomerType.fromString(String str) {
    switch (str) {
      case 'referenced':
        return CustomerType.referenced;
      case 'direct':
        return CustomerType.direct;
      default:
        throw AppException(message: 'UnImplemented CustomerType Error');
    }
  }

  static String getCustomerTypeTranslatedText(CustomerType customerType) {
    switch (customerType.name) {
      case 'direct':
        return translations.direct.tr.capitalizeFirst;
      case 'referenced':
        return translations.referenced.tr.capitalizeFirstOfEach;

      default:
        return translations.unknown.tr.capitalizeFirst;
    }
  }

  @override
  String toString() => 'CustomerType = ($name)';
}
