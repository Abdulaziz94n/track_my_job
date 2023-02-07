import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../core/extensions/string_extension.dart';
import '../../../controllers/transactions_controller.dart';
import '../../../core/utils/app_dialogs.dart';
import '../../../localization/translation_keys.dart' as translations;
import '../../../models/transaction.dart';
import '../../shared/app_confirmation_dialog.dart';
import 'transaction_tile.dart';

import '../../shared/no_items.dart';

class TransactionsList extends GetView<TransactionsController> {
  const TransactionsList({Key? key, required this.transactions})
      : super(key: key);
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(
            child: NoItemsWidget(
                text: translations.noTransaction.tr.capitalizeFirstOfEach))
        : GestureDetector(
            onLongPress: () => showDialog(
                context: context,
                builder: (context) {
                  return AppConfirmationAlert(
                    contentText:
                        translations.sureToMarkAsPaid.tr.capitalizeFirst,
                    actionAlignment: MainAxisAlignment.center,
                    onCancel: () => Get.back(),
                    onConfirm: () async {
                      await AppDialogs.showAndDismissAsyncDialog(
                          context: context,
                          future: controller.markAllAsPaid(transactions),
                          confirmedDialg: true,
                          errorMessage: translations
                              .errorEditTransaction.tr.capitalizeFirst,
                          successMessage: translations
                              .successEditTransaction.tr.capitalizeFirst);
                    },
                  );
                }),
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: ((context, index) => TransactionTile(
                    key: UniqueKey(),
                    transaction: transactions[index],
                  )),
            ),
          );
  }
}
