import 'package:mongo_dart/mongo_dart.dart';

import '../../../models/service_provider.dart';
import '../../../services/mongo_db.dart';
import '../../abstracts/data_repository.dart';
import '../../exceptions/app_exception.dart';

class ServiceProviderRepository implements DataRepository<ServiceProvider> {
  ServiceProviderRepository() : _db = MongoDbAPI.db;
  final Db? _db;

  @override
  Future<void> addData(ServiceProvider data) async {
    try {
      await _db!
          .collection(serviceProvidersCollectionName)
          .insertOne(data.toMap());
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<void> deleteData(String id) async {
    try {
      await _db!
          .collection(serviceProvidersCollectionName)
          .deleteOne({'id': id});
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<List<ServiceProvider>> getAllData() async {
    try {
      final response =
          await _db!.collection(serviceProvidersCollectionName).find().toList();
      final List<ServiceProvider> serviceProviders =
          response.map((e) => ServiceProvider.fromMap(e)).toList();
      return serviceProviders;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> updateData(ServiceProvider data) async {
    try {
      await _db!
          .collection(serviceProvidersCollectionName)
          .replaceOne({'id': data.id}, data.toMap());
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }
}
