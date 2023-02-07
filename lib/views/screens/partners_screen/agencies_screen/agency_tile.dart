import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../controllers/agencies_controller.dart';
import '../../../../controllers/transactions_controller.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../models/agency.dart';
import '../../../../routing/app_router.dart';
import '../../../../../core/utils/app_dialogs.dart';
import '../../../shared/app_text.dart';
import 'edit_agency_dialog.dart';

class AgencyTile extends GetView<AgenciesController> {
  const AgencyTile({super.key, required this.agency});
  final Agency agency;

  TransactionsController get transactionsController =>
      Get.find<TransactionsController>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.p16),
      child: Slidable(
        closeOnScroll: true,
        startActionPane: ActionPane(
            extentRatio: 0.25,
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
                          EditAgencyDialog(name: agency.name, id: agency.id)));
                },
                backgroundColor: AppColors.green,
              )
            ]),
        endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const BehindMotion(),
            children: [
              CustomSlidableAction(
                padding: EdgeInsets.all(Sizes.p4),
                child: AppText(
                  textAlign: TextAlign.center,
                  style: context.appTextTheme.bodyMedium!,
                  text: translations.delete.tr.capitalizeFirstOfEach,
                ),
                onPressed: (context2) async {
                  AppDialogs.confirmDialog(
                    context: context2,
                    contentText:
                        translations.sureToDeleteAgency.tr.capitalizeFirst,
                    onCancel: () => Get.back(),
                    onConfirm: () async {
                      await AppDialogs.showAndDismissAsyncDialog(
                        context: context,
                        errorMessage:
                            translations.errorDeleteAgency.tr.capitalizeFirst,
                        successMessage:
                            translations.successDeleteAgency.tr.capitalizeFirst,
                        confirmedDialg: true,
                        future: controller.deleteAgency(agency.id),
                      );
                    },
                  );
                },
                backgroundColor: AppColors.secondary,
              )
            ]),
        child: ListTile(
          onTap: () {
            transactionsController.resetFilters();
            controller.resetQuery();
            Get.toNamed(AppRoutes.agencyTransactions, arguments: agency);
          },
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 20,
            child: AppText(
                style: context.appTextTheme.titleSmall!,
                text: agency.name[0].capitalizeFirst),
          ),
          title: AppText(
              style: context.appTextTheme.bodyLarge!,
              text: agency.name.capitalizeFirstOfEach),
        ),
      ),
    );
  }
}
