import '../exceptions/app_exception.dart';

enum TransactionType {
  translation('translation'),
  embassy('embassy'),
  visa('visa'),
  legal('legal services'),
  other('other'),
  ;

  const TransactionType(this.type);
  final String type;

  Map<String, dynamic> toMap() {
    return {
      'transactionType': type,
    };
  }

  factory TransactionType.fromString(String str) {
    switch (str) {
      case 'translation':
        return TransactionType.translation;
      case 'embassy':
        return TransactionType.embassy;
      case 'visa':
        return TransactionType.visa;
      case 'legal services':
        return TransactionType.legal;
      case 'other':
        return TransactionType.other;
      default:
        throw AppException(message: 'UnImplemented TransactionType Error');
    }
  }

  @override
  String toString() => 'TransactionTypes(type: $type)';
}
