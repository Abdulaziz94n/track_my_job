import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../controllers/noters_controller.dart';
import '../../../../controllers/transactions_controller.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;

import '../../../../models/noter.dart';
import '../../../../routing/app_router.dart';
import '../../../../../core/utils/app_dialogs.dart';
import '../../../shared/app_text.dart';
import 'edit_noter_dialog.dart';

class NoterTile extends GetView<TransactionsController> {
  const NoterTile({super.key, required this.noter});
  final Noter noter;

  NotersController get notersController => Get.find();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.p16),
      child: Slidable(
          closeOnScroll: true,
          startActionPane: ActionPane(
              extentRatio: 0.50,
              motion: const BehindMotion(),
              children: [
                CustomSlidableAction(
                  padding: EdgeInsets.all(Sizes.p4),
                  child: AppText(
                    textAlign: TextAlign.center,
                    style: context.appTextTheme.bodyMedium!,
                    text: translations.edit.tr.capitalizeFirstOfEach,
                  ),
                  onPressed: (context) {
                    showDialog(
                        context: context,
                        builder: ((context) =>
                            EditNoterDialog(name: noter.id)));
                  },
                  backgroundColor: AppColors.green,
                )
              ]),
          endActionPane: ActionPane(
              extentRatio: 0.50,
              motion: const BehindMotion(),
              children: [
                CustomSlidableAction(
                  padding: EdgeInsets.all(Sizes.p4),
                  child: AppText(
                    textAlign: TextAlign.center,
                    style: context.appTextTheme.bodyMedium!,
                    text: translations.delete.tr.capitalizeFirstOfEach,
                  ),
                  onPressed: (context2) {
                    AppDialogs.confirmDialog(
                      context: context2,
                      contentText: translations.sureToDeleteNotery,
                      onConfirm: () async {
                        await AppDialogs.showAndDismissAsyncDialog(
                          context: context,
                          errorMessage:
                              translations.errorDeleteNotery.tr.capitalizeFirst,
                          successMessage: translations
                              .successDeleteNotery.tr.capitalizeFirst,
                          confirmedDialg: true,
                          future: notersController.deleteNoter(noter.id),
                        );
                      },
                    );
                  },
                  backgroundColor: AppColors.secondary,
                )
              ]),
          child: ListTile(
            onTap: () {
              controller.resetFilters();
              Get.toNamed(AppRoutes.noterTransactions, arguments: noter);
            },
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.secondary,
              child: AppText(
                  style: context.appTextTheme.titleSmall!, text: noter.id),
            ),
            title: AppText(
              style: context.appTextTheme.bodyLarge!,
              text: 'Noter' + ' ' + noter.id,
            ),
          )),
    );
  }
}
