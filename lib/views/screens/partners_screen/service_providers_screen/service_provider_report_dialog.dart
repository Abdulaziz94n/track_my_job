import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:track_my_job/services/pdf_generator/pdf_generator.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/extensions/transactions_list_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;

import '../../../../../core/constants/sizes.dart';
import '../../../../models/service_provider.dart';
import '../../../../models/transaction.dart';
import '../../../shared/app_elevated_btn.dart';
import '../../../shared/app_text.dart';

class ServiceProviderReportDialog extends StatelessWidget {
  const ServiceProviderReportDialog({
    Key? key,
    required this.serviceProvider,
    required this.month,
    required this.year,
    required this.transactions,
  }) : super(key: key);

  final ServiceProvider serviceProvider;
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
                '${serviceProvider.name.capitalizeFirstOfEach} ${translations.report.tr.capitalizeFirst}'),
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
                '${translations.refPortions.tr.capitalizeFirstOfEach} = ${transactions.calcProviderPortions(serviceProvider.name)}',
            style: context.appTextTheme.bodyMedium!,
            padding: const EdgeInsets.only(bottom: Sizes.p8),
          ),
          AppText(
            text:
                '${translations.refUnpaidPortions.tr.capitalizeFirstOfEach} = ${transactions.calcProviderUnpaidPortions(serviceProvider.name)}',
            style: context.appTextTheme.bodyMedium!,
            padding: const EdgeInsets.only(bottom: Sizes.p8),
          ),
          AppText(
            text:
                '${translations.total.tr.capitalizeFirst} = ${transactions.calcProviderTotalAmount(serviceProvider.name)}',
            style: context.appTextTheme.bodyMedium!,
            padding: const EdgeInsets.only(bottom: Sizes.p8),
          ),
          AppElevatedButton(
              onPressed: () {
                PdfGenerator pdfCreator = PdfGenerator();
                pdfCreator.generateServiceProviderReport(
                  fileName:
                      '${serviceProvider.name} Report'.capitalizeFirstOfEach,
                  serviceProviderName: serviceProvider.name,
                  transactions: transactions,
                  month: month,
                  year: year,
                );
                Get.back();
              },
              text: translations.createPDF.tr.capitalizeFirstOfEach)
        ],
      ),
    );
  }
}
