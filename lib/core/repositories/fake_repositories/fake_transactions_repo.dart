import 'package:flutter/material.dart';

import '../../../models/noter_details.dart';
import '../../../models/transaction.dart';
import '../../abstracts/transactions_repository.dart';
import '../../constants/dummy_data.dart';
import '../../enums/customer_type.dart';
import '../../enums/noter_payment.dart';
import '../../enums/payment_status.dart';
import '../../exceptions/app_exception.dart';

class FakeTransactionsRepository implements TransactionsRepository {
  FakeTransactionsRepository();
  @override
  Future<void> deleteData(String id) async {
    try {
      DummyData.transactionsList
          .removeWhere((transaction) => transaction.id == id);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> updateData(data) async {
    try {
      final index = DummyData.transactionsList
          .indexWhere((element) => element.id == data.id);
      DummyData.transactionsList[index] = data;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> addData(Transaction data) async {
    try {
      DummyData.transactionsList.add(data);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<List<Transaction>> getAllData() async {
    try {
      return DummyData.transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getYearlyTransactions(int? year) async {
    try {
      return DummyData.transactionsList
          .where((transaction) => transaction.dateTime.year == year)
          .toList();
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getMonthlyTransactions(int month, int year) async {
    try {
      return DummyData.transactionsList
          .where((transaction) =>
              transaction.dateTime.year == year &&
              transaction.dateTime.month == month)
          .toList();
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getCurrentWeekTransactions() async {
    final weekDay = DateTime.now().weekday;
    final firstWeekDay = DateUtils.dateOnly(
        DateTime.now().subtract(Duration(days: weekDay - 1)));
    final firstWeekDayUTC = firstWeekDay;
    final lastWeekDayStart =
        DateUtils.dateOnly(DateTime.now().add(Duration(days: 7 - weekDay)));
    final lastWeekDayUTC =
        lastWeekDayStart.add(Duration(hours: 23, minutes: 59));

    try {
      final List<Transaction> transactionsList =
          DummyData.transactionsList.where((transaction) {
        if (transaction.dateTime.isAfter(firstWeekDayUTC) &&
            transaction.dateTime.isBefore(lastWeekDayUTC)) {
          return true;
        } else {
          return false;
        }
      }).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getDirectTransactions() async {
    try {
      List<Transaction> directTransactions = DummyData.transactionsList
          .where(
              (transaction) => transaction.customerType == CustomerType.direct)
          .toList();
      return directTransactions;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getMonthlyDirectTransactions(
      int month, int year) async {
    try {
      List<Transaction> monthlyDirectTransactions = DummyData.transactionsList
          .where(
            (transaction) =>
                transaction.customerType == CustomerType.direct &&
                transaction.dateTime.month == month &&
                transaction.dateTime.year == year,
          )
          .toList();
      return monthlyDirectTransactions;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<void> markAsPaid(String id, NoterDetails? noterDetials) async {
    try {
      final index = DummyData.transactionsList
          .indexWhere((transaction) => transaction.id == id);
      Transaction transaction = DummyData.transactionsList[index];
      if (transaction.paymentStatus != PaymentStatus.paid) {
        transaction = transaction.copyWith(paymentStatus: PaymentStatus.paid);
      }
      if (transaction.noterDetails != null &&
          transaction.noterDetails!.noterPayment != NoterPayment.done) {
        transaction = transaction.copyWith(
            noterDetails: transaction.noterDetails!
                .copyWith(noterPayment: NoterPayment.done));
      }
      DummyData.transactionsList[index] = transaction;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<List<Transaction>> getAgencyMonthlyTransactions(
      {required String name, required int month, required int year}) async {
    final agencyMonthlyTransactions = DummyData.transactionsList
        .where((transaction) =>
            transaction.referenceDetails != null &&
            transaction.dateTime.month == month &&
            transaction.dateTime.year == year &&
            transaction.referenceDetails!.reference!.name == name)
        .toList();
    return agencyMonthlyTransactions;
  }

  @override
  Future<List<Transaction>> getAgencyTransactions(
      {required String name}) async {
    final agencyMonthlyTransactions = DummyData.transactionsList
        .where((transaction) =>
            transaction.referenceDetails != null &&
            transaction.referenceDetails!.reference!.name == name)
        .toList();
    return agencyMonthlyTransactions;
  }

  @override
  Future<List<Transaction>> getMonthlyProviderTransactions(
      {required String name, required int month, required int year}) async {
    final serviceProviderMonthlyTransactions =
        DummyData.transactionsList.where((transaction) {
      if (transaction.extraServices != null &&
          transaction.dateTime.month == month &&
          transaction.dateTime.year == year) {
        for (var service in transaction.extraServices!) {
          if (service.serviceProviderName == name) return true;
        }
      }
      return false;
    }).toList();
    return serviceProviderMonthlyTransactions;
  }

  @override
  Future<List<Transaction>> getNoterMonthlyTransactions(
      {required String name, required int month, required int year}) async {
    final noterMonthlyTransactions = DummyData.transactionsList
        .where((transaction) =>
            transaction.noterDetails != null &&
            transaction.dateTime.month == month &&
            transaction.dateTime.year == year &&
            transaction.noterDetails!.id == name)
        .toList();
    return noterMonthlyTransactions;
  }

  @override
  Future<List<Transaction>> getNoterTransactions({required String name}) async {
    final noterTransactions = DummyData.transactionsList
        .where((transaction) =>
            transaction.noterDetails != null &&
            transaction.noterDetails!.id == name)
        .toList();
    return noterTransactions;
  }

  @override
  Future<void> toggleIsPinned(Transaction transaction) async {
    final index = DummyData.transactionsList
        .indexWhere((element) => element.id == transaction.id);
    if (index != -1) {}
    DummyData.transactionsList[index] =
        transaction.copyWith(isPinned: !transaction.isPinned);
  }

  Future<void> markRefAsPaid(String id) async {
    try {
      final index = DummyData.transactionsList
          .indexWhere((transaction) => transaction.id == id);
      DummyData.transactionsList[index] = DummyData.transactionsList[index]
          .copyWith(
              referenceDetails: DummyData
                  .transactionsList[index].referenceDetails
                  ?.copyWith(toRefPayment: PaymentStatus.paid));
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> markAllAsPaid(List<Transaction> transactionsList) async {
    for (var transaction in transactionsList) {
      final index = DummyData.transactionsList.indexWhere((element) =>
          element.id == transaction.id &&
          transaction.paymentStatus != PaymentStatus.paid);
      if (index != -1) {
        DummyData.transactionsList[index] =
            transaction.copyWith(paymentStatus: PaymentStatus.paid);
      }
    }
  }
}
