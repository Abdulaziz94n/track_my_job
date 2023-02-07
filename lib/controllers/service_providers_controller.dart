import 'package:get/get.dart';
import '../core/abstracts/data_repository.dart';
import '../core/extensions/string_extension.dart';
import '../models/service_provider.dart';

import '../../core/utils/utils.dart';

class ServiceProviderController extends GetxController {
  ServiceProviderController(this._serviceProviderRepo);
  final DataRepository<ServiceProvider> _serviceProviderRepo;
  late List<ServiceProvider> _serviceProviders;

  @override
  void onInit() async {
    super.onInit();
    await getServiceProviders();
  }

  String? _query;

  String? get query => _query;

  List<ServiceProvider> get serviceProviders => [..._serviceProviders];
  List<String> get serviceProviderNames =>
      [..._serviceProviders].map((e) => e.name).toList();

  Future<List<ServiceProvider>> getServiceProviders() async {
    final providersList = await _serviceProviderRepo.getAllData()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    _serviceProviders = providersList;
    return providersList;
  }

  Future<void> addProvider(ServiceProvider provider) async {
    try {
      await _serviceProviderRepo.addData(provider);
      _serviceProviders = await getServiceProviders();
      update(['serviceProviders']);
    } catch (e) {
      Utils.showGetxErrorSnackBar(errorMessage: e.toString());
    }
  }

  Future<void> editServiceProvider(
    ServiceProvider serviceProvider,
  ) async {
    try {
      await _serviceProviderRepo.updateData(serviceProvider);
      _serviceProviders = await getServiceProviders();

      update(['serviceProviders']);
    } catch (e) {
      Utils.showGetxErrorSnackBar(errorMessage: e.toString());
    }
  }

  Future<void> deleteProvider(String id) async {
    try {
      await _serviceProviderRepo.deleteData(id);
      _serviceProviders = await getServiceProviders();

      update(['serviceProviders']);
    } catch (e) {
      Utils.showGetxErrorSnackBar(errorMessage: e.toString());
    }
  }

  List<ServiceProvider> getFilterableProviders(
      List<ServiceProvider> serviceProviders) {
    if (_query.nullOrEmpty) return serviceProviders;
    final filteredList = serviceProviders
        .where((agency) => agency.name.contains(_query!))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return filteredList;
  }

  void setSearchQuery(String newVal) {
    _query = newVal;
    update(['filterable']);
  }

  bool checkIfEdited(
      ServiceProvider oldServiceProvider, ServiceProvider newServiceProvider) {
    if (oldServiceProvider == newServiceProvider) {
      Utils.showGetxErrorSnackBar(errorTitle: 'No Changes Made');
      return false;
    } else {
      return true;
    }
  }

  void resetQuery() {
    _query = null;
  }
}
