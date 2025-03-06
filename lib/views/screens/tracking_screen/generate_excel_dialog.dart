import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../controllers/transactions_controller.dart';
import '../../../localization/translation_keys.dart' as translations;
import '../../../services/excel_generator.dart';
import '../../shared/app_loading_indicator.dart';
import '../../shared/app_outlined_btn.dart';
import '../../shared/app_text.dart';

class GenerateExcelDialog extends StatefulWidget {
  const GenerateExcelDialog({super.key});

  @override
  State<GenerateExcelDialog> createState() => _GenerateExcelDialogState();
}

class _GenerateExcelDialogState extends State<GenerateExcelDialog> {
  TransactionsController transactionsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText(
        style: context.appTextTheme.bodyLarge!,
        text: translations.generateExcel.tr.capitalizeFirstOfEach,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        // AppOutlinedButton(
        //   onPressed: () async {
        //     final selectedDate = await Utils.showMonthsYearPicker(context);
        //     if (selectedDate != null) {
        //       _generateExcel(selectedDate);
        //     }
        //   },
        //   text: translations.generateExcel.tr.capitalizeFirstOfEach,
        // ),
        AppOutlinedButton(
            onPressed: () => Get.back(),
            text: translations.cancel.tr.capitalizeFirstOfEach),
      ],
    );
  }

  _generateExcel(
    DateTime selectedDate,
  ) async {
    final ExcelReportGenerator excelGenerator = ExcelReportGenerator();
    final month = selectedDate.month;
    final year = selectedDate.year;
    final fileName = '$month-$year Report';

    showDialog(
      context: context,
      builder: (context) => AppLoadingIndicator(),
    );
    final monthlyTransaction =
        await transactionsController.getMonthlyTransactions(month, year);
    excelGenerator.createAndViewMonthlyReport(fileName, monthlyTransaction);
    Get.back();
    Get.back();
  }
}
