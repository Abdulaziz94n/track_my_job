import 'package:get/get.dart';

import '../core/abstracts/data_repository.dart';
import '../core/extensions/string_extension.dart';
import '../models/noter.dart';

class NotersController extends GetxController {
  NotersController(this._notersRepo);
  final DataRepository<Noter> _notersRepo;
  late List<Noter> _noters;
  String? _query;

  @override
  onInit() async {
    super.onInit();
    await getNoters();
  }

  List<Noter> get notersList => [..._noters];
  List<Noter> get filteredNoters =>
      _noters.where(((element) => element.id.contains(_query!))).toList();

  String? get query => _query;

  Future<List<Noter>> getNoters() async {
    try {
      final noters = await _notersRepo.getAllData();
      _noters = noters;
      return noters;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addNoter(Noter noter) async {
    await _notersRepo.addData(noter);
    _noters = await getNoters();
    update(['noters']);
  }

  Future<void> editNoter({required Noter newNoter}) async {
    await _notersRepo.updateData(newNoter);
    _noters = await getNoters();
    update(['noters']);
  }

  Future<void> deleteNoter(String id) async {
    await _notersRepo.deleteData(id);
    _noters = await getNoters();

    update(['noters']);
  }

  void setSearchQuery(String newVal) {
    _query = newVal;
    update(['filterable']);
  }

  List<Noter> getFilterableNoters(List<Noter> agencies) {
    if (_query.nullOrEmpty) return agencies;
    final filteredList =
        agencies.where((agency) => agency.id.contains(_query!)).toList();
    return filteredList;
  }

  void resetQuery() {
    _query = null;
  }
}
