import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/transactions_controller.dart';
import 'spacing_widgets.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/extensions/build_context_extension.dart';
import '../../localization/translation_keys.dart' as translations;

import 'app_text.dart';

class FiltersRow extends StatelessWidget {
  const FiltersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<TransactionsController>(
            id: 'paid',
            builder: (controller) {
              return FilterChip(
                label: AppText(
                    text: translations.paid.tr.capitalizeFirst!,
                    style: context.appTextTheme.bodyMedium!),
                onSelected: (_) {
                  controller.togglePaidFilter();
                },
                selected: controller.paymentFilters['paid']!,
              );
            },
          ),
          HorizontalSpacingWidget(Sizes.p4),
          GetBuilder<TransactionsController>(
            id: 'notPaid',
            builder: (controller) {
              return FilterChip(
                label: AppText(
                    text: translations.notPaid.tr.capitalizeFirst!,
                    style: context.appTextTheme.bodyMedium!),
                onSelected: (_) {
                  controller.toggleNotPaidFilter();
                },
                selected: controller.paymentFilters['notPaid']!,
              );
            },
          ),
          HorizontalSpacingWidget(Sizes.p4),
          GetBuilder<TransactionsController>(
            id: 'partiallyPaid',
            builder: (controller) {
              return FilterChip(
                label: AppText(
                    text: translations.partlyPaid.tr.capitalizeFirst!,
                    style: context.appTextTheme.bodyMedium!),
                onSelected: (_) {
                  controller.togglepartiallyPaidFilter();
                },
                selected: controller.paymentFilters['partiallyPaid']!,
              );
            },
          ),
          HorizontalSpacingWidget(Sizes.p4),
          GetBuilder<TransactionsController>(
            id: 'showPinned',
            builder: (controller) {
              return FilterChip(
                label: AppText(
                    text: translations.pinned.tr.capitalizeFirst!,
                    style: context.appTextTheme.bodyMedium!),
                onSelected: (_) {
                  controller.toggleShowPinnedFilter();
                },
                selected: controller.paymentFilters['showPinned']!,
              );
            },
          ),
          HorizontalSpacingWidget(Sizes.p4),
          GetBuilder<TransactionsController>(
            id: 'noterNotPaid',
            builder: (controller) {
              return FilterChip(
                label: AppText(
                    text: translations.noterNotPaid.tr.capitalizeFirst!,
                    style: context.appTextTheme.bodyMedium!),
                onSelected: (_) {
                  controller.toggleNoterNotPaidFilter();
                },
                selected: controller.paymentFilters['noterNotPaid']!,
              );
            },
          ),
          HorizontalSpacingWidget(Sizes.p4),
          GetBuilder<TransactionsController>(
            id: 'refNotPaid',
            builder: (controller) {
              return FilterChip(
                label: AppText(
                    text: translations.refNotPaid.tr.capitalizeFirst!,
                    style: context.appTextTheme.bodyMedium!),
                onSelected: (_) {
                  controller.toggleRefNotPaidFilter();
                },
                selected: controller.paymentFilters['refNotPaid']!,
              );
            },
          ),
          HorizontalSpacingWidget(Sizes.p4),
          GetBuilder<TransactionsController>(
            id: 'providerNotPaid',
            builder: (controller) {
              return FilterChip(
                label: AppText(
                    text: translations.providerNotPaid.tr.capitalizeFirst!,
                    style: context.appTextTheme.bodyMedium!),
                onSelected: (_) {
                  controller.toggleProviderNotPaidFilter();
                },
                selected: controller.paymentFilters['providerNotPaid']!,
              );
            },
          ),
        ],
      ),
    );
  }
}
