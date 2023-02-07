import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../../models/noter_details.dart';
import '../../../models/transaction.dart';
import '../../../services/mongo_db.dart';
import '../../abstracts/transactions_repository.dart';
import '../../constants/mongodb_keys_constants.dart';
import '../../enums/customer_type.dart';
import '../../enums/noter_payment.dart';
import '../../enums/payment_status.dart';
import '../../exceptions/app_exception.dart';
import '../../extensions/date_time_extension.dart';

class RemoteTransactionsRepository implements TransactionsRepository {
  RemoteTransactionsRepository() : _db = MongoDbAPI.db;
  final Db? _db;
  @override
  Future<void> deleteData(String id) async {
    try {
      await _db!
          .collection(transactionsCollectionName)
          .deleteOne(where.eq('id', id));
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> updateData(Transaction data) async {
    try {
      await _db!
          .collection(transactionsCollectionName)
          .replaceOne(where.eq('id', data.id), data.toMap());
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> addData(Transaction data) async {
    try {
      await _db!.collection(transactionsCollectionName).insertOne(data.toMap());
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<List<Transaction>> getAllData() async {
    try {
      final response =
          await _db!.collection(transactionsCollectionName).find().toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getYearlyTransactions(int? year) async {
    try {
      year == null ? year = DateTime.now().toUtc().year : year = year;
      final currentYear = DateTime(year).toUtc();
      final nextYear = DateTime(year + 1).toUtc();
      final response = await _db!
          .collection(transactionsCollectionName)
          .find(where.gte('date time', currentYear).lt('date time', nextYear))
          .toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getMonthlyTransactions(int month, int year) async {
    try {
      final response = await _db!
          .collection(transactionsCollectionName)
          .find(where
              .gte("date time", DateTime(year).monthStart(month).toUtc())
              .lte('date time', DateTime(year).monthEnd(month).toUtc()))
          .toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getCurrentWeekTransactions() async {
    final weekDay = DateTime.now().weekday;
    final firstWeekDay =
        DateUtils.dateOnly(DateTime.now().subtract(Duration(days: weekDay - 1)))
            .toUtc();
    final firstWeekDayUTC = firstWeekDay.toUtc();
    final lastWeekDayStart = DateUtils.dateOnly(
        DateTime.now().add(Duration(days: 7 - weekDay)).toUtc());
    final lastWeekDayUTC =
        lastWeekDayStart.add(Duration(hours: 23, minutes: 59)).toUtc();
    try {
      final response = await _db!
          .collection(transactionsCollectionName)
          .find(where
              .gte("date time", firstWeekDayUTC)
              .lte('date time', lastWeekDayUTC))
          .toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getDirectTransactions() async {
    try {
      final response = await _db!
          .collection(transactionsCollectionName)
          .find(where.eq('customer type', CustomerType.direct.name))
          .toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getMonthlyDirectTransactions(
      int month, int year) async {
    try {
      final response = await _db!
          .collection(transactionsCollectionName)
          .find(where
              .eq('customer type', CustomerType.direct.name)
              .gte('date time', DateTime(year).monthStart(month).toUtc())
              .lte('date time', DateTime(year).monthEnd(month).toUtc()))
          .toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getAgencyTransactions(
      {required String name}) async {
    try {
      final response = await _db!
          .collection(transactionsCollectionName)
          .find(where.eq('reference details.reference.name', name))
          .toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getAgencyMonthlyTransactions(
      {required String name, required int month, required int year}) async {
    try {
      final response = await _db!
          .collection(transactionsCollectionName)
          .find(where
              .eq('reference details.reference.name', name)
              .gte('date time', DateTime(year).monthStart(month).toUtc())
              .lte('date time', DateTime(year).monthEnd(month).toUtc()))
          .toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getMonthlyProviderTransactions({
    required String name,
    required int month,
    required int year,
  }) async {
    try {
      final response = await _db!
          .collection(transactionsCollectionName)
          .find(where
              .eq('extra services.serviceProviderName', name)
              .gte('date time', DateTime(year).monthStart(month).toUtc())
              .lte('date time', DateTime(year).monthEnd(month).toUtc()))
          .toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }

  Future<List<Transaction>> getNoterTransactions({required String name}) async {
    try {
      final response = await _db!
          .collection(transactionsCollectionName)
          .find(where.eq('noter details.id', name))
          .toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get noter transactions $e');
    }
  }

  Future<List<Transaction>> getNoterMonthlyTransactions(
      {required String name, required int month, required int year}) async {
    try {
      final response = await _db!
          .collection(transactionsCollectionName)
          .find(where
              .eq('noter details.id', name)
              .gte('date time', DateTime(year).monthStart(month).toUtc())
              .lte('date time', DateTime(year).monthEnd(month).toUtc()))
          .toList();
      final List<Transaction> transactionsList =
          response.map((e) => Transaction.fromMap(e)).toList();
      return transactionsList;
    } catch (e) {
      throw AppException(message: 'Could not get noter transactions $e');
    }
  }

  Future<void> markAsPaid(String id, NoterDetails? noterDetials) async {
    try {
      await _db!.collection(transactionsCollectionName).updateOne(
          where.eq('id', id),
          modify.set(MongoDbConstants.paymentStatusKey,
              PaymentStatus.paid.description));
      if (noterDetials != null &&
          noterDetials.noterPayment != NoterPayment.done)
        await _db!.collection(transactionsCollectionName).updateOne(
              where.eq('id', id),
              modify.set('noter details.noterPayment', true),
            );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  Future<void> markRefAsPaid(String id) async {
    try {
      await _db!.collection(transactionsCollectionName).updateOne(
            where.eq('id', id),
            modify.set('reference details.toRefPayment',
                PaymentStatus.paid.description),
          );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> toggleIsPinned(Transaction transaction) async {
    try {
      await _db!.collection(transactionsCollectionName).updateOne(
            where.eq('id', transaction.id),
            modify.set('isPinned', !transaction.isPinned),
          );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> markAllAsPaid(List<Transaction> transactionsList) async {
    try {
      for (var transaction in transactionsList) {
        if (transaction.paymentStatus != PaymentStatus.paid) {
          await _db!.collection(transactionsCollectionName).updateOne(
              where.eq('id', transaction.id),
              modify.set('payment status', PaymentStatus.paid.description));
        }
      }
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
