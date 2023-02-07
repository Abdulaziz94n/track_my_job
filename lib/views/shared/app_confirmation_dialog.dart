import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../core/extensions/build_context_extension.dart';
import '../../../core/extensions/string_extension.dart';
import '../../localization/translation_keys.dart' as translations;
import 'app_elevated_btn.dart';
import 'app_text.dart';

class AppConfirmationAlert extends StatelessWidget {
  const AppConfirmationAlert(
      {super.key,
      required this.contentText,
      required this.onCancel,
      required this.onConfirm,
      this.actionAlignment});
  final String contentText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final MainAxisAlignment? actionAlignment;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: actionAlignment,
      content: AppText(
        style: context.appTextTheme.bodyLarge!,
        text: contentText,
        textAlign: TextAlign.center,
      ),
      actions: [
        AppElevatedButton(
            onPressed: onConfirm, text: translations.ok.tr.capitalizeFirst),
        AppElevatedButton(
            onPressed: onCancel, text: translations.cancel.tr.capitalizeFirst),
      ],
    );
  }
}
