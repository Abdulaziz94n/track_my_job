import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../../core/constants/sizes.dart';
import '../../../../controllers/transactions_form_controller.dart';
import '../../../../../core/enums/currencies.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../../core/constants/drop_downs_items.dart';
import '../../../../../core/enums/transaction_types.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_dropdown.dart';
import '../../../shared/app_text.dart';
import '../../../shared/app_textfield.dart';
import '../../../shared/spacing_widgets.dart';
import 'form_date_button.dart';

class FormTransactionDetails extends StatelessWidget with Validators {
  const FormTransactionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final formController = Get.find<TransactionsFormController>();
    final fromUpdate = formController.fromUpdate;
    return ExpansionTile(
        title: AppText(
          text: translations.transactionsDetials.tr.capitalizeFirstOfEach,
          style: context.appTextTheme.titleMedium!,
        ),
        maintainState: true,
        initiallyExpanded: true,
        children: [
          AppDropDownField<TransactionType>(
            initialValue: fromUpdate
                ? formController.editableTransaction?.transactionType
                : null,
            items: DropDownItems.transactionTypesDropDownItems(context),
            onSelect: (value) => formController.setTransactionType(value!),
            label: translations.transactionType.tr.capitalizeFirstOfEach,
            validator: validateGenericIsEmpty,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: AppTextField.withOnChanged(
                  initialValue: fromUpdate
                      ? formController.editableTransaction!.amount.toString()
                      : null,
                  onChanged: (value) =>
                      formController.setAmount(int.tryParse(value!)!),
                  inputType: TextInputType.number,
                  label: translations.amount.tr.capitalizeFirst,
                  validator: validateNumbersOnly,
                ),
              ),
              const HorizontalSpacingWidget(Sizes.p12),
              Flexible(
                child: AppDropDownField<Currency>(
                  initialValue: fromUpdate
                      ? formController.editableTransaction!.currency
                      : null,
                  items: DropDownItems.currenciesDropDownItems(context),
                  label: translations.currency.tr.capitalizeFirst,
                  onSelect: (value) => formController.setCurrency(value!),
                  validator: validateGenericIsEmpty,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AppTextField.withOnChanged(
                  initialValue: fromUpdate
                      ? formController.editableTransaction!.netProfit.toString()
                      : null,
                  onChanged: (value) =>
                      formController.setNetProfit(int.tryParse(value!)!),
                  inputType: TextInputType.number,
                  label: translations.netProfit.tr.capitalizeFirstOfEach,
                  validator: validateNumbersOnly,
                ),
              ),
              const HorizontalSpacingWidget(Sizes.p12),
              Expanded(
                child: FormDateButton(
                    formController: formController,
                    passedDate: formController.editableTransaction?.dateTime),
              )
            ],
          )
        ]);
  }
}
