import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../core/constants/app_colors.dart';
import '../../../../core/enums/note_priority.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../localization/translation_keys.dart' as translations;

import '../../../../core/constants/sizes.dart';
import '../../../controllers/notes_controller.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../models/note.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../shared/app_card.dart';
import '../../shared/app_text.dart';

import 'edit_note_dialog.dart';

class NoteTile extends GetView<NotesController> {
  const NoteTile({super.key, required this.note});
  final Note note;
  @override
  Widget build(BuildContext context) {
    final extentRatio = 0.25;
    const contentPadding = EdgeInsets.fromLTRB(12, 12, 12, 12);
    return AppCard(
      clipBehavior: Clip.hardEdge,
      child: LayoutBuilder(builder: (context, constrains) {
        return Slidable(
            closeOnScroll: true,
            startActionPane: ActionPane(
                extentRatio: extentRatio,
                motion: const ScrollMotion(),
                children: [
                  CustomSlidableAction(
                    padding: EdgeInsets.all(Sizes.p4),
                    child: AppText(
                      textAlign: TextAlign.center,
                      style: context.appTextTheme.bodyMedium!,
                      text: translations.edit.tr.capitalizeFirstOfEach,
                    ),
                    onPressed: (context2) {
                      showDialog(
                          context: context,
                          builder: (context2) =>
                              EditNoteDialog(passedNote: note));
                    },
                    backgroundColor: AppColors.green,
                  )
                ]),
            endActionPane: ActionPane(
                extentRatio: extentRatio,
                motion: const ScrollMotion(),
                children: [
                  CustomSlidableAction(
                    padding: EdgeInsets.all(Sizes.p4),
                    child: AppText(
                      textAlign: TextAlign.center,
                      style: context.appTextTheme.bodyMedium!,
                      text: translations.delete.tr.capitalizeFirstOfEach,
                    ),
                    onPressed: (context2) async {
                      AppDialogs.confirmDialog(
                        context: context2,
                        contentText:
                            translations.sureToDeleteNote.tr.capitalizeFirst,
                        onConfirm: () async {
                          AppDialogs.showAndDismissAsyncDialog(
                              context: context,
                              future: controller.deleteNote(note.id),
                              confirmedDialg: true,
                              errorMessage: translations
                                  .errorDeleteNote.tr.capitalizeFirst,
                              successMessage: translations
                                  .successDeleteNote.tr.capitalizeFirstOfEach);
                        },
                      );
                    },
                    backgroundColor: AppColors.secondary,
                    autoClose: true,
                  )
                ]),
            child: Stack(
              children: [
                ListTile(
                  contentPadding: contentPadding,
                  title: AppText(
                    text: note.title.capitalizeFirstOfEach,
                    style: context.appTextTheme.titleSmall!,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: note.description.capitalizeFirst,
                        style: context.appTextTheme.bodyMedium!,
                      ),
                      AppText(
                        text: note.createdAt.capitalizeFirstOfEach,
                        style: context.appTextTheme.bodySmall!,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: _priorityColor(),
                  ),
                ),
              ],
            ));
      }),
    );
  }

  Color _priorityColor() {
    switch (note.priority) {
      case NotePriority.important:
        return AppColors.amber;
      case NotePriority.veryImportant:
        return AppColors.secondary;
      default:
        return AppColors.grey;
    }
  }
}
