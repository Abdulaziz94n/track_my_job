import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:track_my_job/views/screens/transactions_screen/transaction_details/transaction_detail_main_card.dart';

import '../../../../controllers/transactions_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/enums/payment_status.dart';
import '../../../../core/enums/services.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../models/transaction.dart';
import '../../../shared/app_back_button.dart';
import '../../../shared/app_scaffold.dart';
import '../../../shared/screen_title_text.dart';
import '../../../shared/spacing_widgets.dart';
import 'transaction_details_tile.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key});
  Transaction get transaction => Get.arguments;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: ScreenTitleText(
          text: translations.transactionsDetials.tr.capitalizeFirstOfEach),
      body: GetBuilder<TransactionsController>(
          id: 'transaction details',
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TransactionMainDetailsCard(transaction: transaction),
                    VerticalSpacingWidget(Sizes.p20),
                    TransactionDetailTile(
                        iconBackgroundColor: Colors.cyan,
                        leadingIcon: Icons.info_outline,
                        text1: transaction.referenceDetails != null
                            ? transaction.referenceDetails?.paymentBy?.name ??
                                translations.client.tr.capitalizeFirst
                            : translations.client.tr.capitalizeFirst,
                        text2:
                            '${transaction.note ?? translations.noNote.tr.capitalizeFirstOfEach}',
                        titleText: translations
                            .generalDetails.tr.capitalizeFirstOfEach,
                        trailingText: '${transaction.netProfit} TL'),
                    if (transaction.referenceDetails != null)
                      TransactionDetailTile(
                        iconBackgroundColor: AppColors.lightGrey,
                        leadingIcon: Icons.account_circle_outlined,
                        text1: transaction.referenceDetails!.reference!.name
                            .capitalizeFirstOfEach,
                        text2: transaction.referenceDetails?.note ??
                            translations.noNotes.tr.capitalizeFirstOfEach,
                        titleText:
                            translations.refDetails.tr.capitalizeFirstOfEach,
                        trailingText:
                            transaction.referenceDetails!.referencePortion!,
                      ),
                    if (transaction.noterDetails != null)
                      TransactionDetailTile(
                        iconBackgroundColor: Colors.amber.shade800,
                        leadingIcon: Icons.beenhere_outlined,
                        text1: 'Noter ${transaction.noterDetails?.id}',
                        text2:
                            'Profit ${transaction.noterDetails?.noterProfit}',
                        titleText:
                            translations.noterDetails.tr.capitalizeFirstOfEach,
                        trailingText:
                            '${transaction.noterDetails!.noterFee!} TL',
                      ),
                    TransactionDetailTile(
                      iconBackgroundColor: Colors.green,
                      leadingIcon: Icons.paid_outlined,
                      text1:
                          '${translations.client.tr.capitalizeFirst}: ${PaymentStatus.getPaymentTranslatedText(transaction.paymentStatus.description)}',
                      text2: transaction.noterDetails != null
                          ? 'Noter: ${PaymentStatus.getPaymentTranslatedText(transaction.noterDetails!.noterPayment!.payment)}'
                          : '${translations.noNoter.tr.capitalizeFirstOfEach}',
                      titleText:
                          translations.paymentsStatus.tr.capitalizeFirstOfEach,
                      trailingText: transaction.referenceDetails != null
                          ? '${translations.ref.tr.capitalizeFirst}: ${PaymentStatus.getPaymentTranslatedText(transaction.referenceDetails!.toRefPayment!.description)}'
                          : '${translations.ref.tr.capitalizeFirst}: ${translations.noPayment.tr.capitalizeFirstOfEach}',
                    ),
                    if (transaction.extraServices != null &&
                        transaction.extraServices!.isNotEmpty)
                      for (var service in transaction.extraServices!)
                        TransactionDetailTile(
                          iconBackgroundColor: Colors.orange.shade900,
                          trailingText:
                              '${service.sellPrice!} - ${service.buyPrice!}',
                          trailingText2: PaymentStatus.getPaymentTranslatedText(
                              service.paymentStatus!.description),
                          text1:
                              '${service.serviceProviderName!} / ${Services.getServiceTranslatedText(service.service!)}',
                          text2: service.note ??
                              translations.noNote.tr.capitalizeFirstOfEach,
                          titleText: translations
                              .extraService.tr.capitalizeFirstOfEach,
                          leadingIcon: Icons.add_circle_outline,
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppBackButton(),
                        AppBackButton(),
                      ],
                    ),
                  ]),
            );
          }),
    );
  }
}
