import '../../../models/service_provider.dart';
import '../../../models/transaction.dart';
import '../../abstracts/data_repository.dart';
import '../../constants/dummy_data.dart';
import '../../exceptions/app_exception.dart';

class FakeServiceProviderRepository implements DataRepository<ServiceProvider> {
  FakeServiceProviderRepository();

  @override
  Future<void> addData(ServiceProvider data) async {
    try {
      DummyData.serviceProvidersList.add(data);
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<void> deleteData(String id) async {
    try {
      DummyData.serviceProvidersList.removeWhere((element) => element.id == id);
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<List<ServiceProvider>> getAllData() async {
    try {
      return DummyData.serviceProvidersList;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> updateData(ServiceProvider data) async {
    try {
      final index = DummyData.serviceProvidersList.indexWhere((element) {
        return element.id == data.id;
      });
      DummyData.serviceProvidersList[index] = data;
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  Future<List<Transaction>> getMonthlyProviderTransactions({
    required String name,
    required int month,
    required int year,
  }) async {
    try {
      final List<Transaction> resultList = [];
      final List<Transaction> transactionsList = DummyData.transactionsList
          .where((element) => element.extraServices != null ? true : false)
          .toList();
      for (var transaction in transactionsList) {
        for (var service in transaction.extraServices!) {
          if (service.serviceProviderName == name &&
              transaction.dateTime.month == month &&
              transaction.dateTime.year == year) {
            resultList.add(transaction);
          }
        }
      }
      return resultList;
    } catch (e) {
      throw AppException(message: 'Could not get transactions $e');
    }
  }
}
