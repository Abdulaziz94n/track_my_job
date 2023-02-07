import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../controllers/transactions_controller.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/extensions/text_style_extension.dart';
import '../../../localization/translation_keys.dart' as translations;

class MonthlyWeeklySelector extends GetView<TransactionsController> {
  const MonthlyWeeklySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeekly = controller.isWeekly;
    final selectedText = context.appTextTheme.titleMedium!.withShadow;
    final unselectedText = context.appTextTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.normal,
        color: Get.isDarkMode ? Colors.white60 : Colors.black12);
    return Stack(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: translations.weekly.tr.capitalizeFirst,
                style: isWeekly ? selectedText : unselectedText,
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => !isWeekly ? controller.toggleIsWeekly() : null,
              ),
              TextSpan(text: '  '),
              TextSpan(
                text: translations.monthly.tr.capitalizeFirst,
                style: !isWeekly ? selectedText : unselectedText,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => isWeekly ? controller.toggleIsWeekly() : null,
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: translations.weekly.tr.capitalizeFirst,
                style: isWeekly ? selectedText : unselectedText,
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => !isWeekly ? controller.toggleIsWeekly() : null,
              ),
              TextSpan(text: '  '),
              TextSpan(
                text: translations.monthly.tr.capitalizeFirst,
                style: !isWeekly ? selectedText : unselectedText,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => isWeekly ? controller.toggleIsWeekly() : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
