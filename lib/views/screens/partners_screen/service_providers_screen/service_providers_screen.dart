import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../controllers/service_providers_controller.dart';
import '../../../../models/service_provider.dart';
import '../../../shared/app_future_builder.dart';
import '../../../shared/app_search_textfield.dart';
import '../../../shared/no_items.dart';
import '../../transactions_screen/partners_title.dart';
import 'service_providers_list.dart';

class ServiceProvidersBody extends GetView<ServiceProviderController> {
  const ServiceProvidersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PartnersTitle(),
        AppSearchTextField(onChanged: (val) {
          controller.setSearchQuery(val!);
        }),
        GetBuilder<ServiceProviderController>(
          id: 'serviceProviders',
          builder: (controller) {
            return Flexible(
              child: AppFutureBuilder<List<ServiceProvider>>(
                future: controller.getServiceProviders(),
                futureSuccessWidget: (serviceProvidersList) {
                  return serviceProvidersList.isEmpty
                      ? Center(
                          child: NoItemsWidget(
                              text: translations
                                  .noServiceProvider.tr.capitalizeFirstOfEach))
                      : GetBuilder<ServiceProviderController>(
                          id: 'filterable',
                          builder: (_) {
                            return ServiceProvidersList(
                                serviceProvidersList:
                                    controller.getFilterableProviders(
                                        serviceProvidersList));
                          });
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
