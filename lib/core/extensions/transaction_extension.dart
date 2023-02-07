import '../enums/noter_payment.dart';
import '../enums/payment_status.dart';
import '../../models/transaction.dart';

extension TransactionEx on Transaction {
  bool get isPaid => this.paymentStatus == PaymentStatus.paid;
  bool get isRefsPaid => _isRefsPaidFn();
  bool get isProvidersPaid => _isProvidersPaidFn();
  bool get isNoterPaid => _isNoterPaidFn();
  bool get isNotPaid => this.paymentStatus == PaymentStatus.notPaid;
  bool get isPartlyPaid => this.paymentStatus == PaymentStatus.partiallyPaid;

  bool _isProvidersPaidFn() {
    if (this.extraServices != null) {
      for (var service in this.extraServices!) {
        final status = service.paymentStatus == PaymentStatus.paid;
        if (status == false) return false;
      }
      return true;
    } else {
      return true;
    }
  }

  bool _isRefsPaidFn() {
    if (this.referenceDetails != null) {
      final status = this.referenceDetails!.toRefPayment == PaymentStatus.paid;
      return status;
    } else {
      return true;
    }
  }

  bool _isNoterPaidFn() {
    final noterDetails = this.noterDetails;
    if (noterDetails != null) {
      final status = noterDetails.noterPayment == NoterPayment.done;
      return status;
    } else {
      return true;
    }
  }
}
