import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../../core/constants/drop_downs_items.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../controllers/noters_controller.dart';
import '../../../../controllers/transactions_form_controller.dart';
import '../../../../../core/enums/noter_payment.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../models/noter.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_dropdown.dart';
import '../../../shared/app_text.dart';
import '../../../shared/app_textfield.dart';

class FormNoterDetails extends StatefulWidget {
  const FormNoterDetails({super.key});

  @override
  State<FormNoterDetails> createState() => _FormNoterDetailsState();
}

class _FormNoterDetailsState extends State<FormNoterDetails> with Validators {
  @override
  Widget build(BuildContext context) {
    final formController = Get.find<TransactionsFormController>();
    final notersController = Get.find<NotersController>();
    final fromUpdate = formController.fromUpdate;
    final noterDetails = formController.editableTransaction?.noterDetails;

    bool validateNoter() {
      if (formController.noterDetails!.id.nullOrEmpty &&
          (formController.noterDetails!.noterFee == null ||
              formController.noterDetails!.noterFee.toString().isNotEmpty) &&
          formController.noterDetails!.noterPayment == null) {
        return false;
      }
      return true;
    }

    return ExpansionTile(
        title: AppText(
          text: translations.noterDetails.tr.capitalizeFirstOfEach,
          style: context.appTextTheme.titleMedium!,
        ),
        maintainState: true,
        children: [
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AppDropDownField<NoterPayment>(
                      initialValue: fromUpdate
                          ? formController
                              .editableTransaction?.noterDetails?.noterPayment
                          : null,
                      items: DropDownItems.noterPaymentDropDownItems(context),
                      label: translations.noterPayment.tr.capitalizeFirstOfEach,
                      onSelect: (value) => setState(() {
                        formController.setNoterPayment(value!);
                      }),
                      validator:
                          validateNoter() ? validateGenericIsEmpty : null,
                    ).paddingSymmetric(horizontal: 5),
                  ),
                  Flexible(
                    child: AppDropDownField<Noter>(
                      initialValue: fromUpdate
                          ? noterDetails != null
                              ? formController.editableTransaction!.noterDetails
                                          ?.id ==
                                      null
                                  ? null
                                  : notersController.notersList.firstWhere(
                                      (element) =>
                                          element.id ==
                                          formController.editableTransaction!
                                              .noterDetails?.id)
                              : null
                          : null,
                      items: appDropDownItems(
                          context, notersController.notersList),
                      label: translations.noterNo.tr.capitalizeFirstOfEach,
                      onSelect: (value) => setState(() {
                        formController.setNoterNo(value!.id);
                      }),
                      validator:
                          validateNoter() ? validateGenericIsEmpty : null,
                    ).paddingSymmetric(horizontal: 5),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AppTextField.withOnChanged(
                      initialValue: fromUpdate
                          ? formController
                              .editableTransaction?.noterDetails?.noterFee
                              .toString()
                          : null,
                      onChanged: (value) => setState(() {
                        if (value!.isNotEmpty)
                          formController.setNoterFee(int.tryParse(value)!);
                      }),
                      label: translations.noterFee.tr.capitalizeFirstOfEach,
                      inputType: TextInputType.number,
                      fontSize: Sizes.p14,
                      validator:
                          validateNoter() ? validateNumbersOnlyGt2 : null,
                    ).paddingSymmetric(horizontal: 5),
                  ),
                  Flexible(
                    child: AppTextField.withOnChanged(
                      initialValue: fromUpdate
                          ? formController
                              .editableTransaction?.noterDetails?.noterProfit
                              .toString()
                          : null,
                      onChanged: (value) => setState(() {
                        if (value!.isNotEmpty)
                          formController.setNoterProfit(int.tryParse(value)!);
                      }),
                      label: translations.notaryProfit.tr.capitalizeFirstOfEach,
                      inputType: TextInputType.number,
                      fontSize: Sizes.p14,
                      validator: validateNoter() ? validateNumbersOnly : null,
                    ).paddingSymmetric(horizontal: 5),
                  ),
                ],
              ),
            ],
          ),
        ]);
  }
}
