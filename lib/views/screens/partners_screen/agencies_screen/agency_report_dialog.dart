import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/extensions/transactions_list_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../models/agency.dart';
import '../../../../models/transaction.dart';
import '../../../shared/app_text.dart';

class AgencyReportDialog extends StatelessWidget {
  const AgencyReportDialog(
      {Key? key,
      required this.agency,
      required this.month,
      required this.year,
      required this.transactions})
      : super(key: key);

  final Agency agency;
  final int month;
  final int year;

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    final fixedSize = Size(75, 25);
    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: AppText(
            style: context.appTextTheme.bodyMedium!,
            text:
                '${agency.name.capitalizeFirstOfEach} ${translations.report.tr.capitalizeFirst}'),
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
                '${translations.refPortions.tr.capitalizeFirstOfEach} = ${transactions.calcPortions()}',
            style: context.appTextTheme.bodyMedium!,
            padding: const EdgeInsets.only(bottom: Sizes.p8),
          ),
          AppText(
            text:
                '${translations.refUnpaidPortions.tr.capitalizeFirstOfEach} = ${transactions.calcUnpaidPortions()}',
            style: context.appTextTheme.bodyMedium!,
            padding: const EdgeInsets.only(bottom: Sizes.p8),
          ),
          AppText(
            text:
                '${translations.byRefUnpaid.tr.capitalizeFirstOfEach} = ${transactions.calcUnpaidTransactionsTotal()}',
            style: context.appTextTheme.bodyMedium!,
            padding: const EdgeInsets.only(bottom: Sizes.p8),
          ),
          AppText(
            text:
                '${translations.total.tr.capitalizeFirst} = ${transactions.calcTotalAmount()}',
            style: context.appTextTheme.bodyMedium!,
            padding: const EdgeInsets.only(bottom: Sizes.p8),
          ),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     AppElevatedButton(
          //       padding: EdgeInsets.zero,
          //       fixedSize: fixedSize,
          //       textAlign: TextAlign.center,
          //       onPressed: () {
          //         PdfGenerator pdfCreator = PdfGenerator();
          //         pdfCreator.generateAgencyReport(
          //             fileName: '${agency.name} Report'.capitalizeFirstOfEach,
          //             agencyName: agency.name.capitalizeFirstOfEach,
          //             transactions: transactions,
          //             month: month,
          //             year: year,
          //             fromCollect: true);
          //         Get.back();
          //       },
          //       text:
          //           'To Collect', //translations.createPDF.tr.capitalizeFirstOfEach,
          //     ),
          //     AppElevatedButton(
          //       fixedSize: fixedSize,
          //       textAlign: TextAlign.center,

          //       onPressed: () {
          //         PdfGenerator pdfCreator = PdfGenerator();
          //         pdfCreator.generateAgencyReport(
          //             fileName: '${agency.name} Report'.capitalizeFirstOfEach,
          //             agencyName: agency.name.capitalizeFirstOfEach,
          //             transactions: transactions,
          //             month: month,
          //             year: year,
          //             fromCollect: false);
          //         Get.back();
          //       },
          //       text:
          //           'To Pay', // translations.createPDF.tr.capitalizeFirstOfEach,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
