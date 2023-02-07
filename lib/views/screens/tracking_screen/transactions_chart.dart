import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../core/constants/sizes.dart';
import '../../../controllers/transactions_controller.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../localization/translation_keys.dart' as translations;
import '../../../../core/enums/transaction_types.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../models/transaction.dart';
import '../../shared/app_card.dart';
import '../../shared/app_text.dart';
import '../../shared/spacing_widgets.dart';
import 'customers_chart.dart';

class TransactionsChart extends GetView<TransactionsController> {
  const TransactionsChart({
    Key? key,
  }) : super(key: key);

  List<Transaction> get allTransactions => controller.chartData;
  double transactionTypePercentage(TransactionType transactionType) {
    final transactionTypeTotal = allTransactions
        .where((element) => element.transactionType == transactionType)
        .toList()
        .length;
    final percentageRes = (transactionTypeTotal / allTransactions.length) * 100;
    return percentageRes.roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return allTransactions.isEmpty
        ? AppCard(
            child: Center(
              child: AppText(
                  style: context.appTextTheme.bodyMedium!,
                  text: translations.noData.tr.capitalizeFirstOfEach),
            ),
          )
        : LayoutBuilder(builder: (context, constrains) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AppText(
                    style: context.appTextTheme.titleMedium!,
                    text: translations.services.tr.capitalizeFirst),
                VerticalSpacingWidget(Sizes.p16),
                Flexible(
                  child: PieChart(
                    PieChartData(sectionsSpace: 0, sections: [
                      PieChartSectionData(
                        showTitle: true,
                        color: Colors.cyan,
                        value:
                            transactionTypePercentage(TransactionType.embassy),
                        title:
                            '${transactionTypePercentage(TransactionType.embassy)} %',
                        titleStyle: context.appTextTheme.bodySmall,
                      ),
                      PieChartSectionData(
                        showTitle: true,
                        color: Colors.blue,
                        value: transactionTypePercentage(TransactionType.legal),
                        title:
                            '${transactionTypePercentage(TransactionType.legal)} %',
                        titleStyle: context.appTextTheme.bodySmall,
                      ),
                      PieChartSectionData(
                        showTitle: true,
                        color: Colors.orange,
                        value: transactionTypePercentage(TransactionType.visa),
                        title:
                            '${transactionTypePercentage(TransactionType.visa)} %',
                        titleStyle: context.appTextTheme.bodySmall,
                      ),
                      PieChartSectionData(
                        showTitle: true,
                        color: Colors.purple,
                        value: transactionTypePercentage(
                            TransactionType.translation),
                        title:
                            '${transactionTypePercentage(TransactionType.translation)} %',
                        titleStyle: context.appTextTheme.bodySmall,
                      ),
                      PieChartSectionData(
                        showTitle: true,
                        color: Colors.grey,
                        value: transactionTypePercentage(TransactionType.other),
                        title:
                            '${transactionTypePercentage(TransactionType.other)} %',
                        titleStyle: context.appTextTheme.bodySmall,
                      ),
                    ]),
                  ),
                ),
                VerticalSpacingWidget(Sizes.p16),
                Flexible(child: TransactionLabels()),
              ],
            );
          });
  }
}

class TransactionLabels extends StatelessWidget {
  const TransactionLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            LabelLine(
                color: Colors.purple,
                text: translations.translation.tr.capitalizeFirst),
            LabelLine(
                color: Colors.cyan,
                text: translations.embassy.tr.capitalizeFirst),
            LabelLine(
                color: Colors.blue,
                text: translations.legal.tr.capitalizeFirst),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            LabelLine(
                color: Colors.orange,
                text: translations.visa.tr.capitalizeFirst),
            LabelLine(
                color: Colors.grey,
                text: translations.others.tr.capitalizeFirst),
          ],
        )
      ],
    );
  }
}
