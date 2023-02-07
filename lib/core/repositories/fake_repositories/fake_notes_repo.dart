import '../../../models/note.dart';
import '../../abstracts/data_repository.dart';
import '../../constants/dummy_data.dart';
import '../../exceptions/app_exception.dart';

class FakeNotesRepository implements DataRepository<Note> {
  FakeNotesRepository();
  @override
  Future<void> addData(Note data) async {
    try {
      DummyData.notesList.add(data);
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<void> deleteData(String id) async {
    try {
      DummyData.notesList.removeWhere((element) => element.id == id);
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }

  @override
  Future<List<Note>> getAllData() async {
    try {
      return DummyData.notesList;
    } catch (e) {
      throw AppException(message: 'Could not get notes');
    }
  }

  @override
  Future<void> updateData(Note data) async {
    try {
      final index = DummyData.notesList.indexWhere((element) {
        return element.id == data.id;
      });
      DummyData.notesList[index] = data;
    } catch (e) {
      throw AppException(
          message: 'Custom App Exception Fired with Error Message of $e');
    }
  }
}
