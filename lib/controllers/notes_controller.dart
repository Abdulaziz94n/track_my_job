import 'package:get/get.dart';

import '../core/abstracts/data_repository.dart';
import '../models/note.dart';
import '../core/utils/utils.dart';

class NotesController extends GetxController {
  NotesController(this._notesRepo);
  final DataRepository<Note> _notesRepo;

  Future<List<Note>> getNotes() async {
    try {
      final notes = await _notesRepo.getAllData();
      notes.sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
      return notes;
    } catch (e) {
      throw e;
    }
  }

  Future addNote(Note note) async {
    try {
      await _notesRepo.addData(note);
      update(['notes']);
    } catch (e) {
      Utils.showGetxErrorSnackBar(errorMessage: e.toString());
    }
  }

  Future editNote({required Note newNote}) async {
    try {
      await _notesRepo.updateData(newNote);
      update(['notes']);
    } catch (e) {
      Utils.showGetxSnackBar(contentText: 'Error Editing Note');
    }
  }

  Future deleteNote(String id) async {
    try {
      await _notesRepo.deleteData(id);
      update(['notes']);
    } catch (e) {
      Utils.showGetxErrorSnackBar(errorMessage: e.toString());
    }
  }

  bool checkIfEdited(Note oldNote, Note newNote) {
    if (oldNote == newNote) {
      Utils.showGetxErrorSnackBar(errorTitle: 'No Changes Made');
      return false;
    } else {
      return true;
    }
  }
}
