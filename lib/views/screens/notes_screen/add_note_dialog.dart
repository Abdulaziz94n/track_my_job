import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../core/utils/app_dialogs.dart';
import '../../../localization/translation_keys.dart' as translations;

import '../../../../core/constants/drop_downs_items.dart';
import '../../../controllers/notes_controller.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../models/note.dart';
import '../../../../core/utils/validator_mixin.dart';
import '../../shared/app_dropdown.dart';
import '../../shared/app_outlined_btn.dart';
import '../../shared/app_text.dart';
import '../../shared/app_textfield.dart';

import '../../../../core/enums/note_priority.dart';

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({super.key});

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> with Validators {
  String title = '';
  String description = '';
  NotePriority priority = NotePriority.normal;
  final _controller = Get.find<NotesController>();
  final _formKey = GlobalKey<FormState>();
  Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: AlertDialog(
            contentPadding:
                EdgeInsets.symmetric(vertical: Sizes.p8, horizontal: Sizes.p16),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: EdgeInsets.zero,
            title: AppText(
              text: translations.newNote.tr.capitalizeFirstOfEach,
              style: context.appTextTheme.bodyLarge!,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField.withOnChanged(
                    validator: validateIsEmpty,
                    onChanged: (val) => title = val!,
                    label: translations.noteTitle.tr.capitalizeFirstOfEach),
                AppTextField.withOnChanged(
                    onChanged: (val) => description = val!,
                    label:
                        translations.noteDescription.tr.capitalizeFirstOfEach),
                AppDropDownField<NotePriority>(
                  label: translations.priority.tr.capitalizeFirst,
                  items: DropDownItems.notePriorityDropDownItems(context),
                  onSelect: ((value) => priority = value!),
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
                  onPressed: () async {
                    Note note = Note(
                        id: uuid.v1(),
                        title: title.trimAndLower,
                        description: description.trimAndLower,
                        createdAt:
                            DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        priority: priority);
                    if (_formKey.currentState!.validate()) {
                      AppDialogs.showAndDismissAsyncDialog(
                          context: context,
                          future: _controller.addNote(note),
                          confirmedDialg: true,
                          errorMessage:
                              translations.errorAddNote.tr.capitalizeFirst,
                          successMessage: translations
                              .successAddNote.tr.capitalizeFirstOfEach);
                    }
                  },
                  text: translations.add.tr.capitalizeFirst),
            ],
          ),
        ),
      ),
    );
  }
}
