import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../controllers/transactions_form_controller.dart';
import '../../../../../core/utils/app_dialogs.dart';
import '../../../shared/app_outlined_btn.dart';

class FormDateButton extends StatefulWidget {
  const FormDateButton(
      {super.key, required this.formController, this.passedDate});
  final TransactionsFormController formController;
  final DateTime? passedDate;
  @override
  State<FormDateButton> createState() => _FormDateButtonState();
}

class _FormDateButtonState extends State<FormDateButton> {
  @override
  Widget build(BuildContext context) {
    final formController = widget.formController;
    final fromUpdate = formController.fromUpdate;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.p16),
          border: Border.all(
              width: 1,
              color: Get.isDarkMode ? AppColors.lightGrey : Colors.black12)),
      child: AppOutlinedButton(
          textStyle: context.appTextTheme.bodyLarge!
              .copyWith(color: Colors.grey.shade600),
          fixedSize: Size(58, 58),
          onPressed: () async {
            final newDate = await AppDialogs.pickDateDialog(context);
            widget.formController.setDate(newDate);
            setState(() {});
          },
          textAlign: TextAlign.left,
          text: fromUpdate
              ? formController.editableTransaction?.dateTime
                  .toString()
                  .substring(0, 10)
              : widget.formController.date?.toString().substring(0, 10) ??
                  translations.date.tr.capitalizeFirst),
    );
  }
}
