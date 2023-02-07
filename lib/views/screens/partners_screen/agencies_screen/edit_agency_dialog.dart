import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../core/utils/app_dialogs.dart';
import '../../../../localization/translation_keys.dart' as translations;

import '../../../../controllers/agencies_controller.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../models/agency.dart';

import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_outlined_btn.dart';
import '../../../shared/app_text.dart';
import '../../../shared/app_textfield.dart';

class EditAgencyDialog extends StatefulWidget {
  const EditAgencyDialog({super.key, required this.name, required this.id});
  final String name;
  final String id;
  @override
  State<EditAgencyDialog> createState() => _EditAgencyDialogState();
}

class _EditAgencyDialogState extends State<EditAgencyDialog> with Validators {
  String? name;
  final _formKey = GlobalKey<FormState>();
  AgenciesController agenciesController = Get.find<AgenciesController>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: AppText(
                text: translations.editAgency.tr.capitalizeFirst,
                style: context.appTextTheme.bodyLarge!),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField.withOnChanged(
                    initialValue: widget.name,
                    validator: validateIsEmpty,
                    onChanged: (val) => name = val!,
                    label: translations.agencyName.tr.capitalizeFirstOfEach),
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
                    Agency agency = Agency(
                      id: widget.id,
                      name: name ?? widget.name.trimAndLower,
                    );
                    if (_formKey.currentState!.validate()) {
                      AppDialogs.showAndDismissAsyncDialog(
                          context: context,
                          future: agenciesController.editAgency(
                            agency: agency,
                          ),
                          confirmedDialg: true,
                          errorMessage:
                              translations.errorEditAgency.tr.capitalizeFirst,
                          successMessage: translations.successEditAgency);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
