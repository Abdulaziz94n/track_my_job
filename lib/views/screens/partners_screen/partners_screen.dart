import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/partners_controller.dart';
import 'agencies_screen/agencies_screen.dart';
import 'noters_screen/noters_body.dart';
import 'service_providers_screen/service_providers_screen.dart';

class PartnersBody extends StatelessWidget {
  const PartnersBody();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnersController>(
      builder: (controller) => selectedTab(controller.index),
    );
  }

  Widget selectedTab(int index) {
    switch (index) {
      case 0:
        return AgenciesBody();
      case 1:
        return ServiceProvidersBody();
      case 2:
        return NotersBody();
      default:
        return SizedBox.shrink();
    }
  }
}
