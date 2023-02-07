import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../core/constants/drop_downs_items.dart';
import '../../../controllers/notes_controller.dart';
import '../../../../core/enums/note_priority.dart';
import '../../../core/utils/app_dialogs.dart';
import '../../../localization/translation_keys.dart' as translations;

import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/extensions/string_extension.dart';

import '../../../models/note.dart';
import '../../../../core/utils/validator_mixin.dart';
import '../../shared/app_dropdown.dart';
import '../../shared/app_outlined_btn.dart';
import '../../shared/app_text.dart';
import '../../shared/app_textfield.dart';

class EditNoteDialog extends StatefulWidget {
  const EditNoteDialog({super.key, required this.passedNote});
  final Note passedNote;

  @override
  State<EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> with Validators {
  String? editedTitle;
  String? editedDescripton;
  NotePriority? editedPriority;
  final _formKey = GlobalKey<FormState>();
  NotesController notesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: AppText(
                text: translations.editAgency.tr.capitalizeFirst,
                style: context.appTextTheme.bodyLarge!),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField.withOnChanged(
                    initialValue: widget.passedNote.title,
                    validator: validateIsEmpty,
                    onChanged: (val) => editedTitle = val!,
                    label: translations.noteTitle.tr.capitalizeFirstOfEach),
                AppTextField.withOnChanged(
                    initialValue: widget.passedNote.description,
                    validator: validateIsEmpty,
                    onChanged: (val) => editedDescripton = val!,
                    label:
                        translations.noteDescription.tr.capitalizeFirstOfEach),
                AppDropDownField<NotePriority>(
                  initialValue: widget.passedNote.priority,
                  label: translations.priority.tr.capitalizeFirst,
                  items: DropDownItems.notePriorityDropDownItems(context),
                  onSelect: ((value) => editedPriority = value!),
                  validator: validateGenericIsEmpty,
                )
              ],
            ),
            actions: [
              AppOutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  text: translations.cancel.tr.capitalizeFirst),
              AppOutlinedButton(
                  text: translations.edit.tr.capitalizeFirst,
                  onPressed: () async {
                    Note note = Note(
                        title: editedTitle ?? widget.passedNote.title,
                        description: editedDescripton ??
                            widget.passedNote.description.trimAndLower,
                        createdAt: widget.passedNote.createdAt,
                        id: widget.passedNote.id,
                        priority: editedPriority ?? widget.passedNote.priority);
                    if (_formKey.currentState!.validate()) {
                      AppDialogs.showAndDismissAsyncDialog(
                          context: context,
                          future: notesController.editNote(newNote: note),
                          confirmedDialg: true,
                          errorMessage:
                              translations.errorEditNote.tr.capitalizeFirst,
                          successMessage: translations
                              .successEditNote.tr.capitalizeFirstOfEach);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
