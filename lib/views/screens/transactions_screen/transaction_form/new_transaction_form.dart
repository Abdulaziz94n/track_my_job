import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../controllers/transactions_controller.dart';
import '../../../../controllers/transactions_form_controller.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../controllers/agencies_controller.dart';
import '../../../../controllers/service_providers_controller.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../models/transaction.dart';
import '../../../../routing/app_router.dart';
import '../../../../../core/utils/app_dialogs.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_back_button.dart';
import '../../../shared/app_elevated_btn.dart';
import 'form_customer_details.dart';
import 'form_extra_services.dart';
import 'form_noter_details.dart';
import 'form_transaction_details.dart';

const double? kCustomDropDownButtonHeight = null;

class NewTransactionForm extends StatefulWidget {
  const NewTransactionForm({
    super.key,
    this.fromUpdate = false,
    this.transaction,
  }) : assert((fromUpdate == false && transaction == null) ||
            (fromUpdate == true && transaction != null));
  final bool? fromUpdate;
  final Transaction? transaction;
  @override
  State<NewTransactionForm> createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm>
    with Validators {
  late TransactionsController transactionsController;
  late ServiceProviderController providersController;
  late AgenciesController agenciesController;
  late TransactionsFormController formController;

  @override
  void initState() {
    super.initState();
    transactionsController = Get.find<TransactionsController>();
    providersController = Get.find<ServiceProviderController>();
    agenciesController = Get.find<AgenciesController>();
    formController = Get.find<TransactionsFormController>();
    if (widget.fromUpdate == true) {
      formController.editableTransaction = widget.transaction?.copyWith(
          extraServices: [...widget.transaction!.extraServices ?? []]);
      formController.setFromUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formController.formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FormTransactionDetails(),
                FormExtraServices(),
                FormNoterDetails(),
                FormCustomerDetails(),
                SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    onPressed: () async {
                      await formController.submitForm(context,
                          widget.fromUpdate! ? widget.transaction : null);
                    },
                    text: formController.fromUpdate
                        ? translations.editTransaction.tr.capitalizeFirstOfEach
                        : translations.addTransaction.tr.capitalizeFirstOfEach,
                  ),
                ),
                AppBackButton(
                  onPressed: () async => await AppDialogs.confirmDialog(
                    context: context,
                    contentText:
                        translations.sureToGoBack.tr.capitalizeFirstOfEach,
                    onConfirm: !widget.fromUpdate!
                        ? () => Get.offNamedUntil(
                            AppRoutes.homeScreen, (route) => false)
                        : () {
                            Get.back();
                            Get.back();
                          },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
