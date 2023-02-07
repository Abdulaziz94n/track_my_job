import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../core/extensions/string_extension.dart';
import '../../../localization/translation_keys.dart' as translations;
import '../../shared/app_back_button.dart';
import '../../shared/app_scaffold.dart';

import '../../shared/app_text_button.dart';
import '../../shared/screen_title_text.dart';
import 'add_note_dialog.dart';
import 'notes_list.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: false,
      title:
          ScreenTitleText(text: translations.myNotes.tr.capitalizeFirstOfEach),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: const NotesList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBackButton(),
              AppTextButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => AddNoteDialog());
                  },
                  text: '+ ' + translations.addNote.tr.capitalizeFirstOfEach),
            ],
          ),
        ],
      ),
    );
  }
}
