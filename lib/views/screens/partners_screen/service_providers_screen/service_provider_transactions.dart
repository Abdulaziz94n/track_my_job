import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:intl/intl.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../controllers/transactions_controller.dart';
import '../../../../../core/extensions/transactions_list_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../../core/extensions/string_extension.dart';
import '../../../../models/service_provider.dart';
import '../../../../models/transaction.dart';
import '../../../shared/app_back_button.dart';
import '../../../shared/app_elevated_btn.dart';
import '../../../shared/app_future_builder.dart';
import '../../../shared/app_search_textfield.dart';
import '../../../shared/screen_title_text.dart';
import '../../../shared/transactions_filters.dart';
import '../../transactions_screen/transactions_list.dart';
import '../../../shared/app_scaffold.dart';

import '../../../shared/months_picker_button.dart';
import 'service_provider_report_dialog.dart';

class ServiceProviderTransactions extends StatefulWidget {
  const ServiceProviderTransactions({super.key});

  @override
  State<ServiceProviderTransactions> createState() =>
      _ServiceProviderTransactionsState();
}

class _ServiceProviderTransactionsState
    extends State<ServiceProviderTransactions> {
  ServiceProvider get serviceProvider => Get.arguments;
  String? text;
  late ServiceProvider serviceProviderCopy;
  int? selectedYear;
  late List<Transaction> transactionsList;

  @override
  void initState() {
    super.initState();
    serviceProviderCopy = serviceProvider;
  }

  @override
  Widget build(BuildContext context) {
    final btnSize = Size(Sizes.p32, Sizes.p16);

    return AppScaffold(
        title: ScreenTitleText(
            text:
                '${serviceProviderCopy.name.capitalizeFirstOfEach} ${translations.transactions.tr.capitalizeFirst}'),
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
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ServiceProviderReportDialog(
                                serviceProvider: serviceProviderCopy,
                                year: selectedYear ?? DateTime.now().year,
                                month: controller.selectedMonth,
                                transactions: transactionsList,
                              );
                            },
                          );
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
                      future: controller.getMonthlyProviderTransactions(
                          providerName: serviceProviderCopy.name),
                      futureSuccessWidget: (data) {
                        transactionsList = data;
                        return GetBuilder<TransactionsController>(
                            id: 'filterable',
                            builder: (context) {
                              return TransactionsList(
                                  transactions: controller
                                      .filterableTransactions(
                                          transactionsList: data,
                                          month: controller.selectedMonth,
                                          providerName:
                                              serviceProviderCopy.name)
                                      .applySearch(controller.query));
                            });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBackButton(),
                      AppBackButton(),
                    ],
                  ),
                ],
              );
            }));
  }

  void resetValuesAndFilters(TransactionsController controller) {
    text = null;
    selectedYear = null;
    controller.setSelectedMonth(null);
    controller.setSelectedYear(null);
    controller.resetFilters();
  }
}
