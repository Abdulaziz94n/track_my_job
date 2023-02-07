import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../controllers/service_providers_controller.dart';
import '../../../../controllers/transactions_controller.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;

import '../../../../models/service_provider.dart';
import '../../../../routing/app_router.dart';
import '../../../../../core/utils/app_dialogs.dart';
import '../../../shared/app_text.dart';
import 'edit_service_provider_dialog.dart';

class ServiceProviderTile extends GetView<TransactionsController> {
  const ServiceProviderTile({super.key, required this.serviceProvider});
  final ServiceProvider serviceProvider;

  ServiceProviderController get serviceProviderController => Get.find();

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
                  onPressed: (context2) {
                    showDialog(
                        barrierDismissible: true,
                        context: context2,
                        builder: ((context2) => EditServiceProviderDialog(
                              serviceProvider: serviceProvider,
                            )));
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
                  onPressed: (context2) async {
                    AppDialogs.confirmDialog(
                      context: context2,
                      contentText:
                          translations.sureToDeleteAgency.tr.capitalizeFirst,
                      onConfirm: () {
                        AppDialogs.showAndDismissAsyncDialog(
                            context: context,
                            future: serviceProviderController
                                .deleteProvider(serviceProvider.id),
                            confirmedDialg: true,
                            errorMessage: translations
                                .errorDeleteServiceProvider.capitalizeFirst,
                            successMessage: translations
                                .successDeleteServiceProvider
                                .capitalizeFirstOfEach);
                      },
                    );
                  },
                  backgroundColor: AppColors.secondary,
                )
              ]),
          child: ListTile(
            onTap: () {
              controller.resetFilters();
              Get.toNamed(AppRoutes.serviceProviderTransactions,
                  arguments: serviceProvider);
            },
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 20,
              child: AppText(
                style: context.appTextTheme.titleSmall!,
                text: serviceProvider.name[0].toUpperCase(),
              ),
              backgroundColor: AppColors.secondary,
            ),
            title: AppText(
              style: context.appTextTheme.bodyLarge!,
              text: serviceProvider.name.capitalizeFirstOfEach,
            ),
          )),
    );
  }
}
