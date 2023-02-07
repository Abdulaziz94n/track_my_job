import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../controllers/transactions_controller.dart';
import '../../../../core/extensions/transaction_extension.dart';
import '../../../localization/translation_keys.dart' as translations;
import '../../../../core/constants/sizes.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../models/transaction.dart';
import '../../../routing/app_router.dart';
import '../../shared/app_card.dart';
import '../../shared/app_text.dart';
import '../../shared/spacing_widgets.dart';
import 'payment_indicator.dart';
import 'transaction_slidable.dart';

class TransactionTile extends GetView<TransactionsController> {
  const TransactionTile({super.key, required this.transaction});
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    final isPaid = transaction.isPaid;
    final isRefPaid = transaction.isRefsPaid;
    final isProvidersPaid = transaction.isProvidersPaid;
    final isNoterPaid = transaction.isNoterPaid;

    return AppCard(
      margin: EdgeInsets.symmetric(vertical: Sizes.p8),
      clipBehavior: Clip.hardEdge,
      child: LayoutBuilder(
        builder: (layOutcontext, constraints) {
          return TransactionSlidable(
            transaction: transaction,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: AppColors.transactionTileGradient)),
              child: ListTile(
                horizontalTitleGap: 0,
                minLeadingWidth: Sizes.p20,
                isThreeLine: true,
                onTap: () => Get.toNamed(AppRoutes.transactionDetails,
                    arguments: transaction),
                title: AppText(
                  text: Transaction.getTransactionTypeTranslatedText(
                      transaction.transactionType),
                  style: context.appTextTheme.bodyLarge!,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: transaction.customer.nullOrEmpty
                          ? translations.anonymous.tr.capitalizeFirst
                          : transaction.customer!.capitalizeFirstOfEach,
                      style: context.appTextTheme.bodyMedium!
                          .copyWith(letterSpacing: 0.8),
                      maxLines: 1,
                    ),
                    const VerticalSpacingWidget(Sizes.p4),
                    AppText(
                      text:
                          DateFormat('yyyy.MM.dd').format(transaction.dateTime),
                      style: context.appTextTheme.bodySmall!.copyWith(
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                leading: PaymentIndicator(
                    clientPayment: transaction.isPaid,
                    noterPayment: transaction.isNoterPaid,
                    refPayment: transaction.isRefsPaid,
                    providerPayment: transaction.isProvidersPaid,
                    height: constraints.maxHeight / 0.5),
                trailing: ColoredBox(
                  color: Colors.transparent,
                  child: LayoutBuilder(builder: (context, c) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                            textAlign: TextAlign.end,
                            TextSpan(children: [
                              TextSpan(
                                text: transaction.amount.toString() + ' ',
                                style: context.appTextTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: transaction.currency.symbol,
                                style: context.appTextTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ])),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildIndicator('N', isNoterPaid),
                            HorizontalSpacingWidget(Sizes.p8),
                            _buildIndicator('P', isProvidersPaid),
                            HorizontalSpacingWidget(Sizes.p8),
                            _buildIndicator('A', isRefPaid),
                            HorizontalSpacingWidget(Sizes.p8),
                            _buildIndicator('C', isPaid),
                            // _buildIcon(Icons.arrow_drop_down, isProvidersPaid),
                            // _buildIcon(Icons.arrow_drop_down, isRefPaid),
                            // _buildIcon(Icons.arrow_drop_down, isPaid),
                          ],
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppText _buildIndicator(String text, bool state) {
    final doneColor = Colors.green;
    final notDoneColor = AppColors.secondary;
    return AppText(
      text: text,
      style: TextStyle().copyWith(color: state ? doneColor : notDoneColor),
    );
  }
}
