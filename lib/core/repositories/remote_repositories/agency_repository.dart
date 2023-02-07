import 'package:mongo_dart/mongo_dart.dart';

import '../../../models/agency.dart';
import '../../../services/mongo_db.dart';
import '../../abstracts/data_repository.dart';
import '../../exceptions/app_exception.dart';

class AgencyRepository implements DataRepository<Agency> {
  AgencyRepository() : _db = MongoDbAPI.db;
  final Db? _db;

  @override
  Future<void> addData(Agency data) async {
    try {
      await _db!.collection(agenciesCollectionName).insertOne(data.toMap());
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<void> deleteData(String id) async {
    try {
      await _db!.collection(agenciesCollectionName).deleteOne({'id': id});
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<List<Agency>> getAllData() async {
    try {
      final response =
          await _db!.collection(agenciesCollectionName).find().toList();
      final List<Agency> agencies =
          response.map((e) => Agency.fromMap(e)).toList();
      return agencies;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> updateData(Agency data) async {
    try {
      await _db!
          .collection(agenciesCollectionName)
          .replaceOne({'id': data.id}, data.toMap());
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }
}
