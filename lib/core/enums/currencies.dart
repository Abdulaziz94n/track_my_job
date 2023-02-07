import '../exceptions/app_exception.dart';

enum Currency {
  usd,
  tl,
  eur;

  Map<String, dynamic> toMap() {
    return {'currency': name};
  }

  String get symbol {
    switch (name) {
      case 'usd':
        return '\$';
      case 'tl':
        return 'TL';
      case 'eur':
        return '€';
      default:
        return '?';
    }
  }

  factory Currency.fromString(String str) {
    switch (str) {
      case 'usd':
        return Currency.usd;
      case 'tl':
        return Currency.tl;
      case 'eur':
        return Currency.eur;
      default:
        throw AppException(message: 'UnImplemented Currencies Error');
    }
  }

  @override
  String toString() => 'Cureencies(cureency: $name)';
}
