import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../../core/constants/drop_downs_items.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../controllers/agencies_controller.dart';
import '../../../../controllers/transactions_form_controller.dart';
import '../../../../../core/enums/payment_status.dart';
import '../../../../../core/enums/ref_payment_by.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../models/agency.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_dropdown.dart';
import '../../../shared/app_textfield.dart';
import '../../../shared/spacing_widgets.dart';

class FormReferenceDetails extends StatefulWidget {
  const FormReferenceDetails({super.key});

  @override
  State<FormReferenceDetails> createState() => _FormReferenceDetailsState();
}

class _FormReferenceDetailsState extends State<FormReferenceDetails>
    with Validators {
  @override
  Widget build(BuildContext context) {
    final formController = Get.find<TransactionsFormController>();
    final agenciesController = Get.find<AgenciesController>();
    final fromUpdate = formController.fromUpdate;
    final isByRef = formController.isPaymentByRef;
    final refId =
        formController.editableTransaction?.referenceDetails?.reference;
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: AppDropDownField<Agency>(
                initialValue: fromUpdate
                    ? refId != null
                        ? agenciesController.agenciesList.firstWhere(
                            (element) =>
                                element.id ==
                                formController.editableTransaction!
                                    .referenceDetails!.reference?.id)
                        : null
                    : null,
                items:
                    appDropDownItems(context, agenciesController.agenciesList),
                isExpanded: true,

                label: translations.reference.tr.capitalizeFirst,
                onSelect: (value) => formController.setRef(value!),

                // formController.referenceDetails =
                //     formController.referenceDetails!
                //         .copyWith(reference: value!),
                validator: validateGenericIsEmpty,
              ),
            ),
            const HorizontalSpacingWidget(Sizes.p12),
            Flexible(
              child: AppDropDownField<PaymentBy>(
                initialValue: fromUpdate
                    ? formController
                        .editableTransaction?.referenceDetails?.paymentBy
                    : null,
                label: translations.paymentBy.tr.capitalizeFirstOfEach,
                items: DropDownItems.paymentByDropDownItems(context),
                onSelect: (val) => setState(() {
                  formController.setPaymentBy(val!);
                }),
                validator: validateGenericIsEmpty,
              ),
            ),
          ],
        ),
        if (!isByRef)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: AppTextField.withOnChanged(
                initialValue: fromUpdate
                    ? formController
                        .editableTransaction?.referenceDetails?.referencePortion
                    : null,
                label: translations.portion.tr.capitalizeFirst,
                onChanged: (val) => formController.setRefPortion(val!),
                // formController.referenceDetails =
                //     formController.referenceDetails!
                //         .copyWith(referencePortion: val),
                validator: validateIsEmpty,
              )),
              const HorizontalSpacingWidget(Sizes.p12),
              Flexible(
                child: AppDropDownField<PaymentStatus>(
                  initialValue: fromUpdate
                      ? formController
                          .editableTransaction?.referenceDetails?.toRefPayment
                      : null,
                  label: translations.refPayment.tr.capitalizeFirstOfEach,
                  items: DropDownItems.paymentDropDownItems(context),
                  onSelect: (val) => formController.setRefPayment(val!),
                  // formController.referenceDetails =
                  //     formController.referenceDetails!
                  //         .copyWith(toRefPayment: val),
                  validator: validateGenericIsEmpty,
                ),
              ),
            ],
          ),
        AppTextField.withOnChanged(
          initialValue: fromUpdate
              ? formController.editableTransaction?.referenceDetails?.note
              : null,
          label: translations.note.tr.capitalizeFirst,
          onChanged: (val) => formController.setRefNote(val!),
          //  formController.referenceDetails =
          //     formController.referenceDetails!.copyWith(note: val),
        ),
      ],
    );
  }
}
