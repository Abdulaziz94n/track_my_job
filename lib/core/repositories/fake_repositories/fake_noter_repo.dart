import '../../../models/noter.dart';
import '../../../models/transaction.dart';
import '../../abstracts/data_repository.dart';
import '../../constants/dummy_data.dart';
import '../../exceptions/app_exception.dart';

class FakeNoterRepository implements DataRepository<Noter> {
  FakeNoterRepository();
  @override
  Future<void> addData(data) async {
    try {
      DummyData.notersList.add(data);
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<void> deleteData(String id) async {
    try {
      DummyData.notersList.removeWhere((element) => element.id == id);
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<void> updateData(data) async {
    try {
      final index = DummyData.notersList.indexWhere((element) {
        return element.id == data.id;
      });
      DummyData.notersList[index] = data;
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<List<Noter>> getAllData() async {
    return DummyData.notersList;
  }

  Future<List<Transaction>> getNoterTransactions({required String name}) async {
    try {
      return DummyData.transactionsList.where((transaction) {
        if (transaction.noterDetails != null &&
            transaction.noterDetails!.id == name) return true;
        return false;
      }).toList();
    } catch (e) {
      throw AppException(message: 'Could not get noter transactions $e');
    }
  }

  Future addMonthlyProfit({
    required Noter noter,
    required int profit,
    required String month,
    required String year,
  }) async {
    try {
      final index =
          DummyData.notersList.indexWhere((element) => element.id == noter.id);
      DummyData.notersList[index].monthlyProfits!['$month-$year'] = profit;
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }
}
