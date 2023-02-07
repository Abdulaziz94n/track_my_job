import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:uuid/uuid.dart';

import '../../../../controllers/noters_controller.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../models/noter.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_outlined_btn.dart';
import '../../../shared/app_text.dart';
import '../../../shared/app_textfield.dart';

class AddNoterDialog extends StatefulWidget {
  const AddNoterDialog({super.key});

  @override
  State<AddNoterDialog> createState() => _AddNoterDialogState();
}

class _AddNoterDialogState extends State<AddNoterDialog> with Validators {
  String? name;
  final _formKey = GlobalKey<FormState>();
  NotersController notersController = Get.find();
  Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: AppText(
              text: translations.addNoter.tr.capitalizeFirstOfEach,
              style: context.appTextTheme.bodyLarge!,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField.withOnChanged(
                    validator: validateIsEmpty,
                    onChanged: (val) => name = val!,
                    label: translations.noterNo.tr.capitalizeFirst),
              ],
            ),
            actions: [
              AppOutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  text: translations.cancel.tr.capitalizeFirst),
              AppOutlinedButton(
                text: translations.add.tr.capitalizeFirst,
                onPressed: () async {
                  Noter noter = Noter(
                    id: name!,
                  );
                  if (_formKey.currentState!.validate()) {
                    AppDialogs.showAndDismissAsyncDialog(
                        context: context,
                        future: notersController.addNoter(noter),
                        confirmedDialg: true,
                        errorMessage:
                            translations.errorAddNotery.tr.capitalizeFirst,
                        successMessage: translations
                            .successAddNotery.capitalizeFirstOfEach);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
