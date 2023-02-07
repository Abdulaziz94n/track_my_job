import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../controllers/noters_controller.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../localization/translation_keys.dart' as translations;

import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';

import '../../../../../models/noter.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_outlined_btn.dart';
import '../../../shared/app_text.dart';
import '../../../shared/app_textfield.dart';

class EditNoterDialog extends StatefulWidget {
  const EditNoterDialog({super.key, required this.name});
  final String name;
  @override
  State<EditNoterDialog> createState() => _EditNoterDialogState();
}

class _EditNoterDialogState extends State<EditNoterDialog> with Validators {
  String? name;
  final _formKey = GlobalKey<FormState>();
  NotersController notersController = Get.find<NotersController>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: AppText(
                text: translations.editNoter.tr.capitalizeFirst,
                style: context.appTextTheme.bodyLarge!),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField.withOnChanged(
                    initialValue: widget.name,
                    validator: validateIsEmpty,
                    onChanged: (val) => name = val!,
                    label: translations.noterNo.tr.capitalizeFirstOfEach),
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
                    Noter noter = Noter(
                      id: name!,
                    );
                    if (_formKey.currentState!.validate()) {
                      AppDialogs.showAndDismissAsyncDialog(
                          context: context,
                          future: notersController.editNoter(newNoter: noter),
                          confirmedDialg: true,
                          errorMessage:
                              translations.errorEditNotery.tr.capitalizeFirst,
                          successMessage: translations.successEditNotery);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
