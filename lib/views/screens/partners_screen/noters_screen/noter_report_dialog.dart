import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../controllers/noters_controller.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/extensions/transactions_list_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;

import '../../../../../core/constants/sizes.dart';
import '../../../../models/noter.dart';
import '../../../../models/transaction.dart';
import '../../../../services/pdf_generator/pdf_generator.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_elevated_btn.dart';
import '../../../shared/app_text.dart';

class NoterReportDialog extends GetView<NotersController> with Validators {
  const NoterReportDialog({
    Key? key,
    required this.noter,
    required this.transactions,
    required this.month,
    required this.year,
  }) : super(key: key);

  final Noter noter;
  final int month;
  final int year;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: AppText(
            style: context.appTextTheme.bodyMedium!,
            text:
                '${translations.noter.tr.capitalizeFirst} ${noter.id.capitalizeFirstOfEach} ${translations.report.tr.capitalizeFirst}'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            textAlign: TextAlign.center,
            text: translations
                .theReportBasedOnFilteredData.tr.capitalizeFirstOfEach,
            style: context.appTextTheme.bodyMedium!,
            padding: const EdgeInsets.only(bottom: Sizes.p8),
          ),
          AppText(
            text:
                '${translations.noterTotal.tr.capitalizeFirstOfEach} = ${transactions.calcNoterTotalAmount()}',
            style: context.appTextTheme.bodyMedium!,
            padding: const EdgeInsets.only(bottom: Sizes.p8),
          ),
          AppText(
            text:
                '${translations.translatorPortion.tr.capitalizeFirstOfEach} = ${transactions.calcTranslatorApproxGain()}',
            style: context.appTextTheme.bodyMedium!,
            padding: const EdgeInsets.only(bottom: Sizes.p8),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        AppElevatedButton(
            onPressed: () {
              PdfGenerator pdfCreator = PdfGenerator();
              pdfCreator.generateNoterReport(
                fileName: 'Noter ${noter.id} Report'.capitalizeFirstOfEach,
                noterName: noter.id.toString(),
                transactions: transactions,
                month: month,
                year: year,
              );
              Get.back();
            },
            text: translations.createPDF.tr.capitalizeFirstOfEach),
      ],
    );
  }
}
