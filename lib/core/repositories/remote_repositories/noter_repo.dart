import 'package:mongo_dart/mongo_dart.dart';

import '../../../models/noter.dart';
import '../../../services/mongo_db.dart';
import '../../abstracts/data_repository.dart';
import '../../exceptions/app_exception.dart';

class NoterRepository implements DataRepository<Noter> {
  NoterRepository() : _db = MongoDbAPI.db;
  final Db? _db;
  @override
  Future<void> addData(data) async {
    try {
      await _db!.collection(notersCollectionName).insertOne(data.toMap());
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<void> deleteData(String id) async {
    try {
      await _db!.collection(notersCollectionName).deleteOne({'id': id});
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<List<Noter>> getAllData() async {
    final response =
        await _db!.collection(notersCollectionName).find().toList();
    final noters = response.map((e) => Noter.fromMap(e)).toList();
    return noters;
  }

  Future addMonthlyProfit({
    required Noter noter,
    required int profit,
    required String month,
    required String year,
  }) async {
    try {
      await _db!.collection(notersCollectionName).updateOne(
        {'id': noter.id},
        {
          '\$set': {
            'monthly profits.$month-$year': profit,
          },
        },
      );
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<void> updateData(data) async {
    try {
      await _db!
          .collection(notersCollectionName)
          .updateOne({'id': data.id}, modify.set('id', data.id));
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }
}
