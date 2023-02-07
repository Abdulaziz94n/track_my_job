import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../core/extensions/widget_extension.dart';

import '../../../../core/constants/sizes.dart';
import '../../../controllers/transactions_controller.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../models/transaction.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../shared/app_elevated_btn.dart';
import '../../shared/app_future_builder.dart';
import 'tracking_chart.dart';
import 'transactions_chart.dart';
import '../../shared/spacing_widgets.dart';

import 'customers_chart.dart';

class TrackingBody extends GetView<TransactionsController> {
  const TrackingBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<Transaction> currentMonthTransactions = [];
    final now = DateTime.now();
    var selectedDate = DateTime(now.year);
    int selectedYear = selectedDate.year;
    final currentMonth = now.month;
    return GetBuilder<TransactionsController>(
      id: 'summary',
      builder: (controller) {
        return AppFutureBuilder<List<Transaction>>(
          future: controller.getYearlyTransactions(year: selectedYear),
          futureSuccessWidget: (transactionsList) {
            debugPrint(currentMonthTransactions.toString());
            currentMonthTransactions = transactionsList
                .where(
                    (transaction) => transaction.dateTime.month == currentMonth)
                .toList();
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppElevatedButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      await AppDialogs.yearSelectorDialog(
                        context,
                        (date) {
                          controller.setSummarySelectedYear(date.year);
                          selectedYear = date.year;
                          Get.back();
                        },
                      );
                    },
                    text: selectedYear.toString(),
                  )
                      .align(alignment: Alignment.topLeft)
                      .paddingOnly(left: Sizes.p8),
                  SizedBox(
                    height: context.screenHeight * 0.30,
                    child: TrackingChart(year: selectedYear),
                  ),
                  VerticalSpacingWidget(Sizes.p16),
                  Flexible(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: TransactionsChart(),
                      ),
                      Flexible(
                        child: CustomersChart(),
                      ),
                    ],
                  )),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
