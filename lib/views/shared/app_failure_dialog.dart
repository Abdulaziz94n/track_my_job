import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../core/extensions/build_context_extension.dart';
import '../../../core/extensions/string_extension.dart';
import '../../localization/translation_keys.dart' as translations;
import 'app_elevated_btn.dart';
import 'app_text.dart';

class AppFailureAlert extends StatelessWidget {
  const AppFailureAlert({super.key, required this.contentText, this.onAction});
  final String contentText;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: AppText(
        style: context.appTextTheme.bodyLarge!,
        text: contentText,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        AppElevatedButton(
            onPressed: onAction ??
                () {
                  Get.back();
                },
            text: translations.ok.tr.capitalizeFirst)
      ],
    );
  }
}
