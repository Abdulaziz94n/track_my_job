import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../controllers/transactions_controller.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/extensions/text_style_extension.dart';
import '../../../localization/translation_keys.dart' as translations;

class DirectAgencyTransactionsSelector extends StatelessWidget {
  const DirectAgencyTransactionsSelector({super.key});
  @override
  Widget build(BuildContext context) {
    final selectedText = context.appTextTheme.titleMedium!.withShadow;
    final unselectedText = context.appTextTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.normal,
        color: Get.isDarkMode ? Colors.white60 : Colors.black12);

    return GetBuilder<TransactionsController>(
        id: 'filterable',
        builder: (controller) {
          final isDirect = controller.isDirect;
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: translations.direct.tr.capitalizeFirst,
                  style: isDirect ? selectedText : unselectedText,
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => !isDirect ? controller.toggleIsDirect() : null,
                ),
                TextSpan(text: '  ', style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: translations.referenced.tr.capitalizeFirst,
                  style: !isDirect ? selectedText : unselectedText,
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => isDirect ? controller.toggleIsDirect() : null,
                ),
              ],
            ),
          );
        });
  }
}
