import 'package:mongo_dart/mongo_dart.dart';

import '../../../models/note.dart';
import '../../../services/mongo_db.dart';
import '../../abstracts/data_repository.dart';
import '../../exceptions/app_exception.dart';

class NotesRepository implements DataRepository<Note> {
  NotesRepository() : _db = MongoDbAPI.db;
  final Db? _db;
  @override
  Future<void> addData(Note data) async {
    try {
      await _db!.collection(notesCollectionName).insertOne(data.toMap());
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<void> deleteData(String id) async {
    try {
      await _db!.collection(notesCollectionName).deleteOne({'id': id});
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<List<Note>> getAllData() async {
    try {
      final response =
          await _db!.collection(notesCollectionName).find().toList();
      final List<Note> notesList =
          response.map((e) => Note.fromMap(e)).toList();
      return notesList;
    } catch (e) {
      throw AppException(message: 'Could not get notes');
    }
  }

  @override
  Future<void> updateData(Note data) async {
    try {
      await _db!
          .collection(notesCollectionName)
          .replaceOne({'id': data.id}, data.toMap());
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }
}
