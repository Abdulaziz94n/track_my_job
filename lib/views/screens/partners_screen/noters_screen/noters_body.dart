import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../controllers/noters_controller.dart';
import '../../../../models/noter.dart';
import '../../../shared/app_future_builder.dart';
import '../../../shared/app_search_textfield.dart';
import '../../transactions_screen/partners_title.dart';
import 'noters_list.dart';

class NotersBody extends GetView<NotersController> {
  const NotersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PartnersTitle(),
        AppSearchTextField(
            onChanged: (val) => controller.setSearchQuery(val!.toLowerCase())),
        GetBuilder<NotersController>(
          id: 'noters',
          builder: ((controller) {
            return Flexible(
              child: AppFutureBuilder<List<Noter>>(
                future: controller.getNoters(),
                futureSuccessWidget: (noters) {
                  final isSearch = controller.query != null;
                  return GetBuilder<NotersController>(
                      id: 'filterable',
                      builder: (controller) {
                        return NotersList(
                            noters: isSearch
                                ? controller.filteredNoters
                                : controller.notersList);
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
