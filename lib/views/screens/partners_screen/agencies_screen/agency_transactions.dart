import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:intl/intl.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../controllers/transactions_controller.dart';
import '../../../../../core/extensions/transactions_list_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;

import '../../../../../core/extensions/string_extension.dart';
import '../../../../models/agency.dart';
import '../../../../models/transaction.dart';
import '../../../shared/app_back_button.dart';
import '../../../shared/app_elevated_btn.dart';
import '../../../shared/app_future_builder.dart';
import '../../../shared/app_scaffold.dart';
import '../../../shared/app_search_textfield.dart';
import '../../../shared/screen_title_text.dart';
import '../../../shared/transactions_filters.dart';
import '../../transactions_screen/transactions_list.dart';
import '../../../shared/months_picker_button.dart';
import 'agency_report_dialog.dart';

class AgencyTransactions extends StatefulWidget {
  const AgencyTransactions({super.key});

  @override
  State<AgencyTransactions> createState() => _AgencyTransactionsState();
}

class _AgencyTransactionsState extends State<AgencyTransactions> {
  Agency get agency => Get.arguments;
  String? text;
  int? selectedYear;
  late Agency agencyCopy;
  late List<Transaction> agencyTransactions;

  @override
  void initState() {
    super.initState();
    agencyCopy = agency;
  }

  @override
  Widget build(BuildContext context) {
    final btnSize = Size(Sizes.p32, Sizes.p16);
    return GetBuilder<TransactionsController>(
        id: 'transactions',
        builder: (controller) {
          return AppScaffold(
            title: ScreenTitleText(
                text:
                    '${agencyCopy.name.capitalizeFirst} ${translations.transactions.tr.capitalizeFirst}'),
            body: GetBuilder<TransactionsController>(
                id: 'transactions',
                builder: (controller) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TransactionsFilters(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MonthsPicker(
                            fixedSize: btnSize,
                            padding: EdgeInsets.zero,
                            text: text,
                            onSelect: (value) {
                              selectedYear = value.year;
                              controller.setSelectedMonth(value.month);
                              controller.setSelectedYear(value.year);
                              text = DateFormat('MM-yyyy').format(value);
                            },
                          ),
                          AppElevatedButton(
                            padding: EdgeInsets.zero,
                            fixedSize: btnSize,
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return AgencyReportDialog(
                                    agency: agencyCopy,
                                    year: selectedYear ?? DateTime.now().year,
                                    month: controller.selectedMonth,
                                    transactions: agencyTransactions,
                                  );
                                },
                              );
                            },
                            text: translations.report.tr.capitalizeFirst,
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Sizes.p4),
                        child: AppSearchTextField(
                          onChanged: (value) {
                            controller.setSearchQuery(value!.toLowerCase());
                          },
                        ),
                      ),
                      Flexible(
                          child: AppFutureBuilder<List<Transaction>>(
                        future: controller.getAgencyMonthlyTransactions(
                            agencyName: agencyCopy.name),
                        futureSuccessWidget: (transactionsList) {
                          agencyTransactions = transactionsList;

                          return GetBuilder<TransactionsController>(
                              id: 'filterable',
                              builder: (controller) {
                                return TransactionsList(
                                  transactions: controller
                                      .filterableTransactions(
                                        transactionsList: transactionsList,
                                        month: controller.selectedMonth,
                                      )
                                      .applySearch(controller.query),
                                );
                              });
                        },
                      )),
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
        });
  }

  // void resetValuesAndFilters(TransactionsController controller) {
  //   text = null;
  //   selectedYear = null;
  //   controller.setSelectedMonth(null);
  //   controller.setSelectedYear(null);
  //   controller.resetFilters();
  // }
}
