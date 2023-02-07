import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../controllers/transactions_form_controller.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../models/transaction.dart';
import '../../../../../core/utils/utils.dart';
import '../../../shared/screen_title_text.dart';
import 'new_transaction_form.dart';
import '../../../shared/app_scaffold.dart';

class AddTransactionScreen extends GetView<TransactionsFormController> {
  AddTransactionScreen({
    super.key,
    this.fromUpdate = false,
    this.transaction,
  }) : assert((fromUpdate == false && transaction == null) ||
            (fromUpdate == true && transaction != null));
  final bool? fromUpdate;
  final Transaction? transaction;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Utils.willPopConfirmation(
          context: context,
          contentText: translations.sureToGoBack.tr.capitalizeFirstOfEach),
      child: AppScaffold(
        title: ScreenTitleText(
            text: fromUpdate!
                ? translations.editTransaction.tr.capitalizeFirstOfEach
                : translations.newTransactionForm.tr.capitalizeFirstOfEach),
        body: NewTransactionForm(
          fromUpdate: fromUpdate,
          transaction: transaction,
        ),
      ),
    );
  }
}
