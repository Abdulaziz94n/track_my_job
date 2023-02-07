import 'package:get/get.dart';
import '../core/abstracts/data_repository.dart';
import '../core/extensions/string_extension.dart';
import '../models/agency.dart';

class AgenciesController extends GetxController {
  AgenciesController(this._agencyRepo);
  final DataRepository<Agency> _agencyRepo;
  late List<Agency> _agencies;

  String? _query;

  @override
  onInit() async {
    super.onInit();
    await getAgencies();
  }

  List<Agency> get agenciesList => [..._agencies];
  List<Agency> get filteredAgencies =>
      _agencies.where(((element) => element.name.contains(_query!))).toList();

  String? get query => _query;

  Future<List<Agency>> getAgencies() async {
    try {
      final agencies = await _agencyRepo.getAllData()
        ..sort((a, b) => a.name.compareTo(b.name));
      _agencies = agencies;
      return agencies;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addAgency(Agency agency) async {
    await _agencyRepo.addData(agency);
    _agencies = await getAgencies();

    update(['agencies']);
  }

  Future<void> editAgency({required Agency agency}) async {
    await _agencyRepo.updateData(agency);
    _agencies = await getAgencies();
    update(['agencies']);
  }

  Future<void> deleteAgency(String id) async {
    await _agencyRepo.deleteData(id);
    _agencies = await getAgencies();

    update(['agencies']);
  }

  void setSearchQuery(String newVal) {
    _query = newVal;
    update(['filterable']);
  }

  List<Agency> getFilterableAgencies(List<Agency> agencies) {
    if (_query.nullOrEmpty) return agencies;
    final filteredList = agencies
        .where((agency) => agency.name.contains(_query!))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return filteredList;
  }

  void resetQuery() {
    _query = null;
  }
}
