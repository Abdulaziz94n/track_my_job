import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../core/constants/sizes.dart';
import '../../../controllers/transactions_controller.dart';
import '../../../../core/extensions/transactions_list_extension.dart';
import '../../../models/transaction.dart';
import '../../shared/app_future_builder.dart';
import '../../shared/app_search_textfield.dart';
import '../../shared/months_picker_button.dart';
import '../../shared/transactions_filters.dart';
import 'direct_agency_transactions_selector.dart';
import 'transactions_list.dart';
import 'weekly_monthly_selector.dart';

class TransactionsBody extends GetView<TransactionsController> {
  const TransactionsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text;
    return GetBuilder<TransactionsController>(
        id: 'transactionsScreen',
        builder: (controller) {
          return AppFutureBuilder<List<Transaction>>(
            future: controller.isWeekly
                ? controller.getWeeklyTransactions()
                : controller.getMonthlyTransactions(),
            futureSuccessWidget: (transactions) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MonthlyWeeklySelector().paddingOnly(left: Sizes.p8),
                      Spacer(),
                      DirectAgencyTransactionsSelector()
                          .paddingOnly(right: Sizes.p8),
                    ],
                  ).paddingSymmetric(vertical: Sizes.p8),
                  TransactionsFilters(),
                  if (!controller.isWeekly)
                    MonthsPicker(
                            onSelect: (value) {
                              controller.setSelectedMonth(value.month);
                              controller.setSelectedYear(value.year);
                              text = DateFormat('MM-yyyy').format(value);
                            },
                            text: text)
                        .paddingOnly(left: Sizes.p8),
                  AppSearchTextField(
                      onChanged: (val) =>
                          controller.setSearchQuery(val!.toLowerCase())),
                  Flexible(
                      child: GetBuilder<TransactionsController>(
                          id: 'filterable',
                          builder: (controller) {
                            return TransactionsList(
                                transactions: controller
                                    .filterableTransactions(
                                      transactionsList: transactions,
                                      month: controller.selectedMonth,
                                    )
                                    .showOnly(controller.isDirect)
                                    .applySearch(controller.query));
                          }))
                ],
              );
            },
          );
        });
  }
}
