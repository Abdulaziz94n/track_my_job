import 'package:flutter/material.dart';
import 'service_provider_tile.dart';

import '../../../../models/service_provider.dart';

class ServiceProvidersList extends StatelessWidget {
  const ServiceProvidersList({super.key, required this.serviceProvidersList});
  final List<ServiceProvider> serviceProvidersList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: serviceProvidersList.length,
        itemBuilder: ((context, index) {
          final serviceProvider = serviceProvidersList[index];
          return ServiceProviderTile(
            key: ValueKey(serviceProvider.name),
            serviceProvider: serviceProvider,
          );
        }));
  }
}
