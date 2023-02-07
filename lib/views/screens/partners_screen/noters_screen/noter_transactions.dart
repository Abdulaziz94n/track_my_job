import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:intl/intl.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../controllers/transactions_controller.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/extensions/transactions_list_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;

import '../../../../models/noter.dart';
import '../../../../models/transaction.dart';
import '../../../shared/app_back_button.dart';
import '../../../shared/app_elevated_btn.dart';
import '../../../shared/app_future_builder.dart';
import '../../../shared/app_scaffold.dart';
import '../../../shared/app_search_textfield.dart';
import '../../../shared/months_picker_button.dart';
import '../../../shared/screen_title_text.dart';
import '../../../shared/transactions_filters.dart';
import '../../transactions_screen/transactions_list.dart';
import 'noter_report_dialog.dart';

class NoterTransactions extends StatefulWidget {
  const NoterTransactions({super.key});

  @override
  State<NoterTransactions> createState() => _NoterTransactionsState();
}

class _NoterTransactionsState extends State<NoterTransactions> {
  Noter get noter => Get.arguments;
  late Noter noterCopy;
  late List<Transaction> transactionsListCopy;
  int? selectedYear;
  String? text;

  TransactionsController get _transactionsController => Get.find();

  @override
  void initState() {
    super.initState();
    noterCopy = noter;
  }

  @override
  Widget build(BuildContext context) {
    final btnSize = Size(Sizes.p32, Sizes.p16);
    return AppScaffold(
      title: ScreenTitleText(
        text:
            '${translations.noter.tr.capitalizeFirst} ${noterCopy.id} ${translations.transactions.tr.capitalizeFirstOfEach}',
      ),
      body: GetBuilder<TransactionsController>(
          id: 'transactions',
          builder: (controller) {
            return Column(
              children: [
                const TransactionsFilters(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MonthsPicker(
                        padding: EdgeInsets.zero,
                        fixedSize: btnSize,
                        onSelect: (value) {
                          selectedYear = value.year;
                          controller.setSelectedMonth(value.month);
                          controller.setSelectedYear(value.year);
                          text = DateFormat('MM-yyyy').format(value);
                        },
                        text: text),
                    AppElevatedButton(
                      fixedSize: btnSize,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        final currentYear = DateTime.now().year;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return NoterReportDialog(
                                  noter: noterCopy,
                                  transactions: transactionsListCopy,
                                  month: _transactionsController.selectedMonth,
                                  year: selectedYear ?? currentYear);
                            });
                      },
                      text: translations.report.tr.capitalizeFirst,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.p4),
                  child: AppSearchTextField(
                    onChanged: (value) {
                      controller.setSearchQuery(value!.toLowerCase());
                    },
                  ),
                ),
                Flexible(
                  child: AppFutureBuilder<List<Transaction>>(
                      future: controller.getNoterMonthlyTransactions(
                          noterId: noterCopy.id),
                      futureSuccessWidget: (transactionList) {
                        transactionsListCopy = transactionList;
                        return GetBuilder<TransactionsController>(
                            id: 'filterable',
                            builder: (controller) {
                              return TransactionsList(
                                  transactions: controller
                                      .filterableTransactions(
                                          transactionsList: transactionList,
                                          month: controller.selectedMonth)
                                      .applySearch(controller.query));
                            });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBackButton(),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
