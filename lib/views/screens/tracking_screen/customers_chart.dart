import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../core/constants/sizes.dart';
import '../../../controllers/transactions_controller.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../localization/translation_keys.dart' as translations;
import '../../../../core/enums/customer_type.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../models/transaction.dart';
import '../../shared/app_text.dart';
import '../../shared/spacing_widgets.dart';

import '../../shared/app_card.dart';

class CustomersChart extends GetView<TransactionsController> {
  const CustomersChart({
    Key? key,
  }) : super(key: key);

  List<Transaction> get allTransactions => controller.chartData;
  double customerTypePercentage(CustomerType customerType) {
    final customerTypeTotal = allTransactions
        .where((element) => element.customerType == customerType)
        .toList()
        .length;
    final percentageRes = (customerTypeTotal / allTransactions.length) * 100;
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
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                    style: context.appTextTheme.titleMedium!,
                    text: translations.source.tr.capitalizeFirst),
                VerticalSpacingWidget(Sizes.p24),
                Flexible(
                  child: PieChart(
                    PieChartData(sectionsSpace: 0, sections: [
                      PieChartSectionData(
                          showTitle: true,
                          color: Colors.purple,
                          value: customerTypePercentage(CustomerType.direct),
                          title:
                              '${customerTypePercentage(CustomerType.direct)}%',
                          titleStyle: context.appTextTheme.bodySmall),
                      PieChartSectionData(
                          showTitle: true,
                          color: Colors.grey,
                          value:
                              customerTypePercentage(CustomerType.referenced),
                          title:
                              '${customerTypePercentage(CustomerType.referenced)}%',
                          titleStyle: context.appTextTheme.bodySmall),
                    ]),
                  ),
                ),
                VerticalSpacingWidget(Sizes.p16),
                Flexible(
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: CustomerLabels(),
                  ),
                ),
              ],
            );
          });
  }
}

class CustomerLabels extends StatelessWidget {
  const CustomerLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            LabelLine(
                color: Colors.grey,
                text: translations.referenced.tr.capitalizeFirst),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelLine(
                color: Colors.purple,
                text: translations.directs.tr.capitalizeFirst),
          ],
        ),
      ],
    );
  }
}

class LabelLine extends StatelessWidget {
  const LabelLine({super.key, required this.color, required this.text});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: color,
        ),
        const HorizontalSpacingWidget(5),
        AppText(
          style: context.appTextTheme.bodySmall!,
          text: text,
        )
      ]),
    );
  }
}
