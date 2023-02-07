import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../core/constants/sizes.dart';
import '../../../controllers/partners_controller.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/extensions/text_style_extension.dart';
import '../../../localization/translation_keys.dart' as translations;

class PartnersTitle extends StatelessWidget {
  const PartnersTitle({super.key});
  @override
  Widget build(BuildContext context) {
    final selectedStyle = context.appTextTheme.titleMedium!
        .copyWith(fontWeight: FontWeight.bold)
        .withShadow;
    final unSelectedStyle = context.appTextTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.normal,
        color: Get.isDarkMode ? Colors.white60 : Colors.black12);

    return GetBuilder<PartnersController>(builder: (controller) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: translations.agencies.tr.capitalizeFirst + '  ',
              style: controller.index == 0 ? selectedStyle : unSelectedStyle,
              recognizer: controller.index == 0 ? null : TapGestureRecognizer()
                ?..onTap = () => controller.setIndex(0),
            ),
            TextSpan(
                text: translations.providers.tr.capitalizeFirst + '  ',
                style: controller.index == 1 ? selectedStyle : unSelectedStyle,
                recognizer:
                    controller.index == 1 ? null : TapGestureRecognizer()
                      ?..onTap = () => controller.setIndex(1)),
            TextSpan(
              text: translations.notary.tr.capitalizeFirst,
              style: controller.index == 2 ? selectedStyle : unSelectedStyle,
              recognizer: controller.index == 2 ? null : TapGestureRecognizer()
                ?..onTap = () => controller.setIndex(2),
            ),
          ])),
        ],
      ).paddingOnly(top: Sizes.p8, left: Sizes.p8);
    });
  }
}
