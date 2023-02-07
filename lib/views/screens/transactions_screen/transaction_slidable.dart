import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:track_my_job/core/utils/app_dialogs.dart';
import 'package:track_my_job/views/screens/transactions_screen/transaction_form/add_transaction_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../controllers/transactions_controller.dart';
import '../../../controllers/transactions_form_controller.dart';
import '../../../../core/enums/noter_payment.dart';
import '../../../../core/enums/payment_status.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../localization/translation_keys.dart' as translations;
import '../../../models/transaction.dart';
import '../../shared/app_loading_indicator.dart';
import '../../shared/app_text.dart';

class TransactionSlidable extends GetView<TransactionsController> {
  const TransactionSlidable(
      {super.key, required this.transaction, required this.child});

  final Transaction transaction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: Slidable(
        closeOnScroll: true,
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            GetBuilder<TransactionsController>(builder: (controller) {
              return CustomSlidableAction(
                padding: EdgeInsets.all(Sizes.p4),
                child: AppText(
                  textAlign: TextAlign.center,
                  style: context.appTextTheme.bodyMedium!,
                  text: transaction.isPinned
                      ? translations.unpin.tr.capitalizeFirstOfEach
                      : translations.pin.tr.capitalizeFirstOfEach,
                ),
                autoClose: false,
                backgroundColor: AppColors.blue,
                onPressed: (context) async {
                  await controller.toggleIsPinned(transaction);
                },
              );
            }),
            CustomSlidableAction(
              padding: EdgeInsets.all(Sizes.p4),
              child: AppText(
                textAlign: TextAlign.center,
                style: context.appTextTheme.bodyMedium!,
                text: translations.edit.tr.capitalizeFirstOfEach,
              ),
              backgroundColor: AppColors.green,
              autoClose: true,
              onPressed: (context) {
                Get.to(
                    () => AddTransactionScreen(
                          fromUpdate: true,
                          transaction: transaction,
                        ),
                    binding: BindingsBuilder.put(
                      () => TransactionsFormController(),
                    ));
              },
            ),
            CustomSlidableAction(
              padding: EdgeInsets.all(Sizes.p4),
              child: AppText(
                textAlign: TextAlign.center,
                style: context.appTextTheme.bodyMedium!,
                text: translations.delete.tr.capitalizeFirstOfEach,
              ),
              autoClose: false,
              backgroundColor: AppColors.secondary,
              onPressed: (context) async {
                AppDialogs.confirmDialog(
                  context: context,
                  contentText:
                      translations.sureToDeleteTransaction.tr.capitalizeFirst,
                  onConfirm: () async {
                    AppDialogs.showAndDismissAsyncDialog(
                      context: context,
                      successMessage: translations
                          .successDeleteTransaction.tr.capitalizeFirst,
                      errorMessage: translations
                          .errorDeleteTransaction.tr.capitalizeFirst,
                      future: controller.deleteTransaction(transaction.id),
                      confirmedDialg: true,
                    );
                  },
                );
              },
            ),
          ],
        ),
        endActionPane: ActionPane(
            extentRatio: 0.5,
            motion: const ScrollMotion(),
            children: [
              CustomSlidableAction(
                padding: EdgeInsets.all(Sizes.p4),
                child: AppText(
                  textAlign: TextAlign.center,
                  style: context.appTextTheme.bodyMedium!,
                  text: translations.markAsPaid.tr.capitalizeFirstOfEach,
                ),
                backgroundColor: AppColors.darkBlue,
                onPressed: (context) async {
                  if (transaction.paymentStatus != PaymentStatus.paid ||
                      transaction.noterDetails?.noterPayment !=
                          NoterPayment.done) {
                    await AppDialogs.showAndDismissAsyncDialog(
                        context: context,
                        confirmedDialg: false,
                        future: controller.markAsPaid(transaction),
                        loadingIndicator: (buildContext) =>
                            AppLoadingIndicator(),
                        errorMessage: translations
                            .errorEditTransaction.tr.capitalizeFirst,
                        successMessage: translations
                            .successEditTransaction.tr.capitalizeFirst);
                  } else {
                    Get.defaultDialog(
                        title:
                            translations.noChangesMade.tr.capitalizeFirstOfEach,
                        content: AppText(
                          style: context.appTextTheme.bodyMedium!,
                          text: translations.paymentAlreadyDone.capitalizeFirst,
                        ));
                  }
                },
              ),
              CustomSlidableAction(
                padding: EdgeInsets.all(Sizes.p4),
                child: AppText(
                  textAlign: TextAlign.center,
                  style: context.appTextTheme.bodyMedium!,
                  text: translations.markRefAsPaid.tr.capitalizeFirstOfEach,
                ),
                backgroundColor: AppColors.green,
                onPressed: transaction.referenceDetails == null
                    ? null
                    : (context) async {
                        if (transaction.referenceDetails!.toRefPayment !=
                            PaymentStatus.paid) {
                          await AppDialogs.showAndDismissAsyncDialog(
                              context: context,
                              confirmedDialg: false,
                              future: controller.markRefAsPaid(transaction),
                              loadingIndicator: (buildContext) =>
                                  AppLoadingIndicator(),
                              errorMessage: translations
                                  .errorEditTransaction.tr.capitalizeFirst,
                              successMessage: translations
                                  .successEditTransaction.tr.capitalizeFirst);
                        } else {
                          Get.defaultDialog(
                              title: translations
                                  .noChangesMade.tr.capitalizeFirstOfEach,
                              content: AppText(
                                style: context.appTextTheme.bodyMedium!,
                                text: translations
                                    .paymentAlreadyDone.capitalizeFirst,
                              ));
                        }
                      },
              ),
            ]),
        child: child,
      ),
    );
  }
}
