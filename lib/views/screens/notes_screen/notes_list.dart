import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../core/extensions/string_extension.dart';
import '../../../models/note.dart';
import '../../../localization/translation_keys.dart' as translations;

import '../../shared/app_elevated_btn.dart';
import '../../shared/app_future_builder.dart';
import '../../shared/no_items.dart';

import '../../../controllers/notes_controller.dart';
import 'add_note_dialog.dart';
import 'note_list_tile.dart';

class NotesList extends StatelessWidget {
  const NotesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(
        id: 'notes',
        builder: (controller) {
          return AppFutureBuilder<List<Note>>(
            future: controller.getNotes(),
            futureSuccessWidget: (notes) {
              return notes.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: NoItemsWidget(
                              text: translations
                                  .noNotes.tr.capitalizeFirstOfEach),
                        ),
                        AppElevatedButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) => AddNoteDialog());
                            },
                            text: '+ ' +
                                translations.addNote.tr.capitalizeFirstOfEach),
                      ],
                    ))
                  : ListView.builder(
                      itemCount: notes.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final note = notes[index];
                        return NoteTile(
                          key: ValueKey(note.id),
                          note: note,
                        );
                      }));
            },
          );
        });
  }
}
