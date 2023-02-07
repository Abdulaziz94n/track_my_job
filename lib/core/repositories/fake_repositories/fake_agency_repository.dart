import '../../../models/agency.dart';
import '../../abstracts/data_repository.dart';
import '../../constants/dummy_data.dart';
import '../../exceptions/app_exception.dart';

class FakeAgencyRepository implements DataRepository<Agency> {
  FakeAgencyRepository();

  @override
  Future<void> addData(Agency data) async {
    try {
      DummyData.agenciesList.add(data);
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<void> deleteData(String id) async {
    try {
      DummyData.agenciesList.removeWhere((element) => element.id == id);
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<List<Agency>> getAllData() async {
    try {
      return DummyData.agenciesList;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> updateData(Agency data) async {
    try {
      final index = DummyData.agenciesList.indexWhere((element) {
        return element.id == data.id;
      });
      DummyData.agenciesList[index] = data;
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }
}
