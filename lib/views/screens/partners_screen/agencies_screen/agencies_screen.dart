import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../controllers/agencies_controller.dart';
import '../../../../models/agency.dart';
import '../../../shared/app_future_builder.dart';
import '../../../shared/app_search_textfield.dart';
import '../../transactions_screen/partners_title.dart';
import 'agencies_list.dart';

class AgenciesBody extends GetView<AgenciesController> {
  const AgenciesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PartnersTitle(),
        AppSearchTextField(
            onChanged: (val) => controller.setSearchQuery(val!.toLowerCase())),
        GetBuilder<AgenciesController>(
          id: 'agencies',
          builder: ((controller) {
            return Flexible(
              child: AppFutureBuilder<List<Agency>>(
                future: controller.getAgencies(),
                futureSuccessWidget: (agencies) {
                  return GetBuilder<AgenciesController>(
                      id: 'filterable',
                      builder: (controller) {
                        return AgenciesList(
                            agencies:
                                controller.getFilterableAgencies(agencies));
                      });
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
