import '../exceptions/app_exception.dart';

enum NoterPayment {
  done('done'),
  notDone('not done');

  const NoterPayment(this.payment);
  final String payment;
  Map<String, dynamic> toMap() {
    return {'noter payment': this == done ? true : false};
  }

  factory NoterPayment.fromBool(bool status) {
    switch (status) {
      case true:
        return NoterPayment.done;
      case false:
        return NoterPayment.notDone;
      default:
        throw AppException(message: 'UnImplemented NoterPayment Error');
    }
  }

  @override
  String toString() => 'NoterPayment(Noter Payment: $name)';
}
