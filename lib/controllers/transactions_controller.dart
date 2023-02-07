import 'package:get/get.dart' hide GetStringUtils;
import '../core/abstracts/transactions_repository.dart';
import '../core/enums/payment_status.dart';
import '../core/exceptions/app_exception.dart';
import '../core/extensions/transactions_list_extension.dart';
import '../localization/translation_keys.dart' as translations;
import '../models/extra_service.dart';
import '../models/transaction.dart';
import '../core/utils/utils.dart';

part 'transaction_filtering_controller.dart';

class TransactionsController extends GetxController
    with TransactionsFilteringController {
  TransactionsController(this._transactionsRepo);
  final TransactionsRepository _transactionsRepo;

  String? _searchQuery;
  bool _isWeekly = true;
  bool _isDirect = true;
  List<Transaction> chartData = [];

  bool get isWeekly => _isWeekly;

  bool get isDirect => _isDirect;

  String? get query => _searchQuery;

  Future<List<Transaction>> getTransactions() async {
    try {
      final response = await _transactionsRepo.getAllData();
      chartData = response;
      return response..sortTransactions();
    } catch (e) {
      throw AppException(message: 'Error Fetching Transactions');
    }
  }

  Future<List<Transaction>> getYearlyTransactions({int? year}) async {
    try {
      final response = await _transactionsRepo.getYearlyTransactions(year);
      chartData = response;
      return response..sortTransactions();
    } catch (e) {
      throw AppException(message: 'Error Fetching Transactions');
    }
  }

  Future<List<Transaction>> getWeeklyTransactions() async {
    try {
      final response = await _transactionsRepo.getCurrentWeekTransactions();
      return response..sortTransactions();
    } catch (e) {
      throw AppException(message: 'Error Fetching Transactions $e');
    }
  }

  Future<List<Transaction>> getMonthlyTransactions(
      [int? month, int? year]) async {
    try {
      final response = await _transactionsRepo.getMonthlyTransactions(
          month ?? selectedMonth, year ?? selectedYear);
      return response..sortTransactions();
    } catch (e) {
      throw AppException(message: 'Error Fetching Transactions $e');
    }
  }

  Future<List<Transaction>> getMonthlyDirectTransactions() async {
    try {
      final response = await _transactionsRepo.getMonthlyDirectTransactions(
          selectedMonth, selectedYear);
      return response..sortTransactions();
    } catch (e) {
      throw AppException(message: 'Error Fetching Transactions $e');
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    try {
      await _transactionsRepo.addData(transaction);
    } catch (e) {
      throw AppException(message: 'Could not add Transaction $e');
    }
  }

  Future<void> editTransaction(Transaction transaction) async {
    try {
      await _transactionsRepo.updateData(transaction);
      update(['transactionsScreen', 'transactions']);
    } catch (e) {
      throw AppException(message: 'Could not edit Transaction ');
    }
  }

  Future<bool> markAsPaid(Transaction transaction) async {
    try {
      await _transactionsRepo.markAsPaid(
          transaction.id, transaction.noterDetails);
      update(['transactionsScreen', 'transactions']);
      return true;
    } catch (e) {
      Utils.showGetxErrorSnackBar(
          errorMessage: translations.errorEditTransaction);
      return false;
    }
  }

  Future<bool> markRefAsPaid(Transaction transaction) async {
    try {
      await _transactionsRepo.markRefAsPaid(transaction.id);
      update(['transactionsScreen', 'transactions']);
      return true;
    } catch (e) {
      Utils.showGetxErrorSnackBar(
          errorMessage: translations.errorEditTransaction);
      return false;
    }
  }

  Future<void> toggleIsPinned(Transaction transaction) async {
    try {
      await _transactionsRepo.toggleIsPinned(transaction);
      update(['filterable', 'transactions', 'transactionsScreen']);
    } catch (e) {
      Utils.showGetxErrorSnackBar(
          errorMessage: translations.errorEditTransaction);
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      await _transactionsRepo.deleteData(id);
      update(['transactions', 'transactionsScreen']);
    } catch (e) {
      Utils.showGetxErrorSnackBar(errorMessage: 'Could not add Transaction $e');
    }
  }

  Future<void> markAllAsPaid(List<Transaction> transactionsList) async {
    try {
      await _transactionsRepo.markAllAsPaid(transactionsList);
      update(['transactions', 'transactionsScreen']);
    } catch (e) {
      Utils.showGetxErrorSnackBar(
          errorMessage: 'Could not edit all Transaction $e');
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    update(['filterable']);
  }

  void setSelectedMonth(int? newMonth) {
    _filterMonth = newMonth;
    update(['filterable', 'transactions', 'transactionsScreen']);
  }

  void setSelectedYear(int? newYear) {
    _filterYear = newYear;
    update(['filterable', 'transactions', 'transactionsScreen']);
  }

  void setSummarySelectedYear(int? newYear) {
    _filterYear = newYear;
    update(['summary']);
  }

  void toggleIsWeekly() {
    _isWeekly = !_isWeekly;
    update(['transactionsScreen']);
  }

  void toggleIsDirect() {
    _isDirect = !_isDirect;
    update(['filterable']);
  }

  void togglePaidFilter() {
    _filters['paidFilter'] = !_filters['paidFilter']!;
    update(['paid', 'filterable'], true);
  }

  void togglepartiallyPaidFilter() {
    _filters['partiallyPaidFilter'] = !_filters['partiallyPaidFilter']!;

    update(['partiallyPaid', 'filterable'], true);
  }

  void toggleNotPaidFilter() {
    _filters['notPaidFilter'] = !_filters['notPaidFilter']!;

    update(['notPaid', 'filterable'], true);
  }

  void toggleShowPinnedFilter() {
    _filters['showPinned'] = !_filters['showPinned']!;
    update(['showPinned', 'filterable'], true);
  }

  void toggleRefNotPaidFilter() {
    _filters['refNotPaid'] = !_filters['refNotPaid']!;

    update(['refNotPaid', 'filterable'], true);
  }

  void toggleProviderNotPaidFilter() {
    _filters['providerNotPaid'] = !_filters['providerNotPaid']!;

    update(['providerNotPaid', 'filterable'], true);
  }

  void toggleNoterNotPaidFilter() {
    _filters['noterNotPaid'] = !_filters['noterNotPaid']!;

    update(['noterNotPaid', 'filterable'], true);
  }

  Future<List<Transaction>> getAgencyTransactions(
      {required String agencyName}) async {
    try {
      final agencyTransactions = await _transactionsRepo.getAgencyTransactions(
        name: agencyName,
      );
      return agencyTransactions..sortTransactions();
    } catch (e) {
      throw e;
    }
  }

  Future<List<Transaction>> getAgencyMonthlyTransactions(
      {required String agencyName}) async {
    try {
      final agencyTransactions =
          await _transactionsRepo.getAgencyMonthlyTransactions(
        name: agencyName,
        month: selectedMonth,
        year: selectedYear,
      );
      return agencyTransactions..sortTransactions();
    } catch (e) {
      throw e;
    }
  }

  Future<List<Transaction>> getMonthlyProviderTransactions(
      {required String providerName}) async {
    try {
      final providerTransactions =
          await _transactionsRepo.getMonthlyProviderTransactions(
        name: providerName,
        month: selectedMonth,
        year: selectedYear,
      );
      return providerTransactions..sortTransactions();
    } catch (e) {
      throw e;
    }
  }

  Future<List<Transaction>> getNoterMonthlyTransactions(
      {required String noterId}) async {
    try {
      final noterTransactions =
          await _transactionsRepo.getNoterMonthlyTransactions(
        name: noterId,
        month: selectedMonth,
        year: selectedYear,
      );
      return noterTransactions..sortTransactions();
    } catch (e) {
      throw e;
    }
  }

  bool checkIfEdited(
      {required Transaction oldTransaction,
      required Transaction newTransaction}) {
    if (oldTransaction == newTransaction) {
      return false;
    } else {
      return true;
    }
  }

  void resetFilters() {
    if (_filterApplied) {
      for (var filter in _filters.keys) {
        if (filter != 'dateFilter') {
          _filters[filter] = false;
        }
      }
    }
    _searchQuery = null;
    _filterMonth = null;
    _filterYear = null;
    update([
      'paid',
      'notPaid',
      'showPinned',
      'partiallyPaid',
      'filterable',
      'providerNotPaid',
      'noterNotPaid',
      'refNotPaid'
    ]);
  }
}
