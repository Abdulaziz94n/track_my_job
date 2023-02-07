import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../../core/constants/drop_downs_items.dart';
import '../../../../controllers/transactions_form_controller.dart';
import '../../../../../core/enums/customer_type.dart';
import '../../../../../core/enums/payment_status.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../models/reference_details.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_dropdown.dart';
import '../../../shared/app_text.dart';
import '../../../shared/app_textfield.dart';
import 'form_reference_details.dart';

class FormCustomerDetails extends StatefulWidget {
  const FormCustomerDetails({super.key});

  @override
  State<FormCustomerDetails> createState() => _FormCustomerDetailsState();
}

class _FormCustomerDetailsState extends State<FormCustomerDetails>
    with Validators {
  @override
  Widget build(BuildContext context) {
    final formController = Get.find<TransactionsFormController>();
    final fromUpdate = formController.fromUpdate;
    return ExpansionTile(
      title: AppText(
          text: translations.customerDetails.tr.capitalizeFirstOfEach,
          style: context.appTextTheme.titleMedium!),
      maintainState: true,
      children: [
        AppDropDownField<CustomerType>(
          initialValue: fromUpdate
              ? formController.editableTransaction?.customerType
              : null,
          items: DropDownItems.customerTypeDropDownItems(context),
          label: translations.customerType.tr.capitalizeFirstOfEach,
          onSelect: (value) {
            if (value == CustomerType.direct) {
              formController.referenceDetails = ReferenceDetails.initNull();
            }
            setState(() {
              formController.setCustomerType(value!);
            });
          },
          validator: validateGenericIsEmpty,
        ),
        if (formController.customerType == CustomerType.referenced ||
            formController.editableTransaction?.customerType ==
                CustomerType.referenced)
          FormReferenceDetails(),
        AppTextField.withOnChanged(
          initialValue:
              fromUpdate ? formController.editableTransaction?.customer : null,
          onChanged: (value) => formController.setCustomer(value!),
          label: translations.customer.tr.capitalizeFirst,
          validator: validateIsEmpty,
        ),
        AppDropDownField<PaymentStatus>(
          initialValue: fromUpdate
              ? formController.editableTransaction?.paymentStatus
              : null,
          items: DropDownItems.paymentDropDownItems(context),
          label: translations.paymentStatus.tr.capitalizeFirstOfEach,
          onSelect: (value) => formController.setPaymentStatus(value!),
          validator: validateGenericIsEmpty,
        ),
        AppTextField.withOnChanged(
          initialValue:
              fromUpdate ? formController.editableTransaction?.note : null,
          onChanged: (value) => formController.setNote(value!),
          label: translations.notes.tr.capitalizeFirst,
          maxLines: 2,
        ),
      ],
    );
  }
}
