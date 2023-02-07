import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:uuid/uuid.dart';

import '../../../../controllers/agencies_controller.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../models/agency.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_outlined_btn.dart';
import '../../../shared/app_text.dart';
import '../../../shared/app_textfield.dart';

class AddAgencyDialog extends StatefulWidget {
  const AddAgencyDialog({super.key});

  @override
  State<AddAgencyDialog> createState() => _AddAgencyDialogState();
}

class _AddAgencyDialogState extends State<AddAgencyDialog> with Validators {
  String? name;
  final _formKey = GlobalKey<FormState>();
  AgenciesController agenciesController = Get.find<AgenciesController>();
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
              text: translations.addAgency.tr.capitalizeFirst,
              style: context.appTextTheme.bodyLarge!,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField.withOnChanged(
                    validator: validateIsEmpty,
                    onChanged: (val) => name = val!,
                    label: translations.agencyName.tr.capitalizeFirst),
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
                  Agency agency = Agency(
                    id: uuid.v1(),
                    name: name!.trimAndLower,
                  );
                  if (_formKey.currentState!.validate()) {
                    AppDialogs.showAndDismissAsyncDialog(
                        context: context,
                        future: agenciesController.addAgency(agency),
                        confirmedDialg: true,
                        errorMessage:
                            translations.errorAddAgency.tr.capitalizeFirst,
                        successMessage:
                            translations.successAddAgency.tr.capitalizeFirst);
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
