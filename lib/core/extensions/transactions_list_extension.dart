import '../enums/customer_type.dart';
import '../enums/payment_status.dart';
import '../enums/ref_payment_by.dart';
import '../../models/transaction.dart';
import 'string_extension.dart';

extension TransactionsListss on List<Transaction> {
  List<Transaction> applySearch(String? query) {
    if (query.nullOrEmpty) return this;
    final filteredList = this.where((transaction) {
      final refDetails = transaction.referenceDetails;
      final refMatch =
          refDetails != null && refDetails.reference!.name.contains(query!);
      final refNoteMatch = refDetails != null &&
          refDetails.note != null &&
          refDetails.note!.contains(query!);
      final noteMatch =
          transaction.note != null && transaction.note!.contains(query!);
      final customerMatch = transaction.customer!.contains(query!);

      return customerMatch || refMatch || noteMatch || refNoteMatch;
    }).toList();
    return filteredList;
  }

  List<Transaction> showOnly(bool isDirect) {
    final res;
    if (isDirect) {
      res = this
          .where(
              (transaction) => transaction.customerType == CustomerType.direct)
          .toList();
    } else {
      res = this
          .where((transaction) =>
              transaction.customerType == CustomerType.referenced)
          .toList();
    }
    return res;
  }

  sortTransactions() {
    this.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  int calcTotalAmount() {
    int total = 0;
    for (var transaction in this) {
      total += transaction.amount;
    }
    return total;
  }

  int calcPortions() {
    int total = 0;
    for (var transaction in this) {
      total +=
          transaction.referenceDetails!.referencePortion!.getNumsFromString;
    }
    return total;
  }

  int calcUnpaidPortions() {
    int total = 0;
    for (var transaction in this) {
      if (transaction.referenceDetails!.toRefPayment != PaymentStatus.paid) {
        total +=
            transaction.referenceDetails!.referencePortion!.getNumsFromString;
      }
    }
    return total;
  }

  int calcPortionsCount() {
    int totalCount = 0;
    for (var transaction in this) {
      if (transaction.referenceDetails!.referencePortion != '0') {
        totalCount++;
      }
    }
    return totalCount;
  }

  int calcPortionsTotal() {
    int total = 0;
    for (var transaction in this) {
      if (transaction.referenceDetails!.referencePortion != '0') {
        total +=
            transaction.referenceDetails!.referencePortion!.getNumsFromString;
      }
    }
    return total;
  }

  int calcPaidPortions() {
    int total = 0;
    for (var transaction in this) {
      if (transaction.referenceDetails!.toRefPayment == PaymentStatus.paid) {
        total +=
            transaction.referenceDetails!.referencePortion!.getNumsFromString;
      }
    }
    return total;
  }

  int calcPaidPortionsCount() {
    int totalCount = 0;
    for (var transaction in this) {
      if (transaction.referenceDetails!.toRefPayment == PaymentStatus.paid &&
          transaction.referenceDetails!.referencePortion != '0') {
        totalCount++;
      }
    }
    return totalCount;
  }

  int calcUnpaidPortionsCount() {
    int totalCount = 0;
    for (var transaction in this) {
      if (transaction.referenceDetails!.toRefPayment != PaymentStatus.paid) {
        totalCount++;
      }
    }
    return totalCount;
  }

  int calcUnpaidTransactionsCount() {
    int totalCount = 0;
    for (var transaction in this) {
      if (transaction.paymentStatus != PaymentStatus.paid) {
        totalCount++;
      }
    }
    return totalCount;
  }

  int calcUnpaidTransactionsTotal() {
    int total = 0;
    for (var transaction in this) {
      if (transaction.paymentStatus != PaymentStatus.paid) {
        total += transaction.amount;
      }
    }
    return total;
  }

  int calcAgencyTransactionsCount() {
    int total = 0;
    for (var transaction in this) {
      if (transaction.referenceDetails != null) {
        total += 1;
      }
    }
    return total;
  }

  int calcAgencyTransactionsTotal() {
    int total = 0;
    for (var transaction in this) {
      if (transaction.referenceDetails != null) {
        transaction.referenceDetails!.paymentBy == PaymentBy.reference
            ? total += transaction.amount
            : total += transaction
                .referenceDetails!.referencePortion!.getNumsFromString;
      }
    }
    return total;
  }

  int calcAgencyUnpaidTransactionsTotal() {
    int total = 0;
    for (var transaction in this) {
      if (transaction.paymentStatus != PaymentStatus.paid &&
          transaction.referenceDetails != null) {
        transaction.referenceDetails!.paymentBy == PaymentBy.reference
            ? total += transaction.amount
            : total += transaction
                .referenceDetails!.referencePortion!.getNumsFromString;
      }
    }
    return total;
  }

  int calcPaidTransactionsCount() {
    int totalCount = 0;
    for (var transaction in this) {
      if (transaction.paymentStatus == PaymentStatus.paid) {
        totalCount++;
      }
    }
    return totalCount;
  }

  int calcPaidTransactionsTotal() {
    int total = 0;
    for (var transaction in this) {
      if (transaction.paymentStatus == PaymentStatus.paid) {
        total += transaction.amount;
      }
    }
    return total;
  }

  int calcProviderTotalAmount(String providerName) {
    int total = 0;
    for (var transaction in this) {
      for (var service in transaction.extraServices!) {
        if (service.serviceProviderName == providerName) {
          total += service.sellPrice!.getNumsFromString;
        }
      }
    }
    return total;
  }

  int calcProviderPortions(String providerName) {
    int total = 0;
    for (var transaction in this) {
      for (var service in transaction.extraServices!) {
        if (service.serviceProviderName == providerName) {
          total += service.buyPrice!.getNumsFromString;
        }
      }
    }
    return total;
  }

  int calcProviderUnpaidPortions(String providerName) {
    int total = 0;
    for (var transaction in this) {
      for (var service in transaction.extraServices!) {
        if (service.serviceProviderName == providerName &&
            service.paymentStatus != PaymentStatus.paid) {
          total += service.buyPrice!.getNumsFromString;
        }
      }
    }
    return total;
  }

  int calcProviderUnpaidPortionsCount(String providerName) {
    int totalCount = 0;
    for (var transaction in this) {
      for (var service in transaction.extraServices!) {
        if (service.serviceProviderName == providerName &&
            service.paymentStatus != PaymentStatus.paid) {
          totalCount++;
        }
      }
    }
    return totalCount;
  }

  int calcNoterTotalAmount() {
    int total = 0;
    for (var transaction in this) {
      if (transaction.noterDetails != null) {
        total += transaction.noterDetails!.noterFee!;
      }
    }
    return total;
  }

  int calcTranslatorApproxGain() {
    int total = 0;
    for (var transaction in this) {
      if (transaction.noterDetails != null) {
        total +=
            ((transaction.noterDetails!.noterProfit! / 2) * (80 / 100)).round();
      }
    }
    return total;
  }
}
