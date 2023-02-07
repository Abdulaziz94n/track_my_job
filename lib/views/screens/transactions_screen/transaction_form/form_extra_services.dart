import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../controllers/transactions_form_controller.dart';
import '../../../shared/app_elevated_btn.dart';
import '../../../shared/app_outlined_btn.dart';
import '../../../shared/app_text.dart';
import '../../../shared/spacing_widgets.dart';
import 'form_extra_service_item.dart';

class FormExtraServices extends StatelessWidget {
  const FormExtraServices({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsFormController>(
        id: 'transaction form',
        builder: (controller) {
          return ExpansionTile(
              title: AppText(
                text: translations.extraServices.tr.capitalizeFirstOfEach,
                style: context.appTextTheme.titleMedium!,
              ),
              maintainState: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppElevatedButton(
                      onPressed: () => controller.addExtraService(),
                      text: translations.addService.tr.capitalizeFirst,
                    ),
                    HorizontalSpacingWidget(Sizes.p8),
                    if (!controller.fromUpdate
                        ? controller.extraServices.isNotEmpty
                        : controller
                            .editableTransaction!.extraServices!.isNotEmpty)
                      AppOutlinedButton(
                          onPressed: () => controller.clearExtraServices(),
                          text: translations
                              .clearServices.tr.capitalizeFirstOfEach)
                  ],
                ),
                for (int i = 0; i < controller.getExtraServices().length; i++)
                  ExtraServiceFormItem(
                    key: ValueKey(i),
                    index: i,
                  ),
              ]);
        });
  }
}
