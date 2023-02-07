import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../../core/constants/drop_downs_items.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/enums/payment_status.dart';
import '../../../../../core/enums/services.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../controllers/service_providers_controller.dart';
import '../../../../controllers/transactions_form_controller.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_dropdown.dart';
import '../../../shared/app_textfield.dart';
import '../../../shared/spacing_widgets.dart';

class ExtraServiceFormItem extends StatefulWidget {
  const ExtraServiceFormItem({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<ExtraServiceFormItem> createState() => _ExtraServiceFormItemState();
}

class _ExtraServiceFormItemState extends State<ExtraServiceFormItem>
    with Validators {
  @override
  Widget build(BuildContext context) {
    TransactionsFormController formController =
        Get.find<TransactionsFormController>();
    ServiceProviderController providersController =
        Get.find<ServiceProviderController>();
    final fromUpdate = formController.fromUpdate;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: AppDropDownField<String>(
                initialValue: fromUpdate
                    ? formController.editableTransaction
                        ?.extraServices![widget.index].serviceProviderName
                    : null,
                isExpanded: true,
                label: translations.serviceProvider.tr.capitalizeFirstOfEach,
                items: appDropDownItems(
                    context, providersController.serviceProviderNames),
                onSelect: (val) {
                  formController.setExtraServiceProvider(widget.index, val!);
                },
                validator: validateIsEmpty,
              ),
            ),
            const HorizontalSpacingWidget(Sizes.p12),
            Flexible(
              child: AppDropDownField<Services>(
                initialValue: fromUpdate
                    ? formController.editableTransaction
                        ?.extraServices![widget.index].service
                    : null,
                label: translations.service.tr.capitalizeFirst,
                isExpanded: true,
                items: DropDownItems.servicesDropDownItems(context),
                onSelect: (val) =>
                    formController.setExtraServiceService(widget.index, val!),
                validator: validateGenericIsEmpty,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: AppTextField.withOnChanged(
                initialValue: fromUpdate
                    ? formController.editableTransaction
                        ?.extraServices![widget.index].buyPrice
                    : null,
                label: translations.buyPrice.tr.capitalizeFirstOfEach,
                onChanged: (val) =>
                    formController.setExtraServiceBuyPrice(widget.index, val!),
                validator: validateIsEmpty,
              ),
            ),
            const HorizontalSpacingWidget(Sizes.p12),
            Flexible(
              child: AppTextField.withOnChanged(
                initialValue: fromUpdate
                    ? formController.editableTransaction
                        ?.extraServices![widget.index].sellPrice
                    : null,
                label: translations.soldPrice.tr.capitalizeFirstOfEach,
                onChanged: (val) =>
                    formController.setExtraServiceSellPrice(widget.index, val!),
                validator: validateIsEmpty,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 2,
              child: AppDropDownField<PaymentStatus>(
                initialValue: fromUpdate
                    ? formController.editableTransaction
                        ?.extraServices![widget.index].paymentStatus
                    : null,
                items: DropDownItems.paymentDropDownItems(context),
                onSelect: (val) =>
                    formController.setExtraServicePayment(widget.index, val!),
                label: translations.payment.tr.capitalizeFirst,
                validator: validateGenericIsEmpty,
              ),
            ),
            const HorizontalSpacingWidget(Sizes.p12),
            Flexible(
              flex: 2,
              child: AppTextField.withOnChanged(
                  initialValue: fromUpdate
                      ? formController.editableTransaction
                          ?.extraServices![widget.index].note
                      : null,
                  onChanged: (val) =>
                      formController.setExtraServiceNote(widget.index, val!),
                  label: translations.note.tr.capitalizeFirst),
            ),
          ],
        ),
      ],
    );
  }
}
