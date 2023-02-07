import '../../models/noter_details.dart';
import '../../models/transaction.dart';

abstract class TransactionsRepository {
  Future<List<Transaction>> getAllData();
  Future<void> addData(Transaction data);
  Future<void> updateData(Transaction data);
  Future<void> deleteData(String id);

  Future<List<Transaction>> getYearlyTransactions(int? year);
  Future<List<Transaction>> getMonthlyTransactions(int month, int year);
  Future<List<Transaction>> getCurrentWeekTransactions();
  Future<List<Transaction>> getDirectTransactions();
  Future<List<Transaction>> getMonthlyDirectTransactions(int month, int year);

  Future<List<Transaction>> getAgencyTransactions({required String name});
  Future<List<Transaction>> getAgencyMonthlyTransactions(
      {required String name, required int month, required int year});

  Future<List<Transaction>> getMonthlyProviderTransactions({
    required String name,
    required int month,
    required int year,
  });

  Future<List<Transaction>> getNoterTransactions({required String name});
  Future<List<Transaction>> getNoterMonthlyTransactions(
      {required String name, required int month, required int year});

  Future<void> markAsPaid(String id, NoterDetails? noterDetials);
  Future<void> markRefAsPaid(String id);
  Future<void> toggleIsPinned(Transaction transaction);
  Future<void> markAllAsPaid(List<Transaction> transactionsList);
}
