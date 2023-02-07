part of 'transactions_controller.dart';

mixin TransactionsFilteringController {
  final Map<String, bool> _filters = {
    'dateFilter': true,
    'paidFilter': false,
    'notPaidFilter': false,
    'partiallyPaidFilter': false,
    'noterNotPaid': false,
    'providerNotPaid': false,
    'refNotPaid': false,
    'showPinned': false
  };

  int? _filterMonth;
  int? _filterYear;

  int get selectedMonth => _filterMonth ?? DateTime.now().month;

  int get selectedYear => _filterYear ?? DateTime.now().year;

  Map<String, bool> get paymentFilters => {
        'paid': _filters['paidFilter']!,
        'notPaid': _filters['notPaidFilter']!,
        'partiallyPaid': _filters['partiallyPaidFilter']!,
        'showPinned': _filters['showPinned']!,
        'noterNotPaid': _filters['noterNotPaid']!,
        'refNotPaid': _filters['refNotPaid']!,
        'providerNotPaid': _filters['providerNotPaid']!,
      };

  bool get _filterApplied {
    if (_filters['paidFilter'] == false &&
        _filters['notPaidFilter'] == false &&
        _filters['partiallyPaidFilter'] == false &&
        _filters['showPinned'] == false &&
        _filters['providerNotPaid'] == false &&
        _filters['noterNotPaid'] == false &&
        _filters['refNotPaid'] == false) {
      return false;
    }
    return true;
  }

  List<Transaction> filterableTransactions(
      {required List<Transaction> transactionsList,
      required int? month,
      String? providerName}) {
    if (month != null) {
      final filteredList = getMonthlyFilterableTransactions(
          transactionsList, month, providerName)
        ..sortTransactions();

      return _filterApplied ? filteredList : transactionsList;
    } else {
      final filteredList =
          getFilterableTransactions(transactionsList, providerName);
      return _filterApplied ? filteredList : transactionsList
        ..sortTransactions();
    }
  }

  List<Transaction> getFilterableTransactions(
      List<Transaction> transactionsList,
      [String? providerName]) {
    return transactionsList.where((transaction) {
      if (isPaidFiltered(transaction)) {
        return true;
      }
      if (isNotPaidFiltered(transaction)) {
        return true;
      }
      if (isPartiallyPaidFiltered(transaction)) {
        return true;
      }
      if (isNoterNotPaid(transaction)) {
        return true;
      }
      if (isRefNotPaid(transaction)) {
        return true;
      }
      if (isProviderNotPaid(transaction, providerName)) {
        return true;
      }
      if (isPinnedFiltered(transaction)) {
        return true;
      }
      return false;
    }).toList()
      ..sortTransactions();
  }

  List<Transaction> getMonthlyFilterableTransactions(
      List<Transaction> transactionsList, int month,
      [String? providerName]) {
    return transactionsList.where((transaction) {
      bool isSameMonthFiltered =
          transaction.dateTime.month == month && _filters['dateFilter']!;

      if (isPaidFiltered(transaction) && isSameMonthFiltered) {
        return true;
      }
      if (isNotPaidFiltered(transaction) && isSameMonthFiltered) {
        return true;
      }
      if (isPartiallyPaidFiltered(transaction) && isSameMonthFiltered) {
        return true;
      }
      if (isNoterNotPaid(transaction) && isSameMonthFiltered) {
        return true;
      }
      if (isRefNotPaid(transaction) && isSameMonthFiltered) {
        return true;
      }
      if (isProviderNotPaid(transaction, providerName) && isSameMonthFiltered) {
        return true;
      }
      if (isPinnedFiltered(transaction) && isSameMonthFiltered) {
        return true;
      }

      if (isSameMonthFiltered &&
          _filters['dateFilter']! &&
          !_filters['paidFilter']! &&
          !_filters['notPaidFilter']! &&
          !_filters['showPinned']! &&
          !_filters['providerNotPaid']! &&
          !_filters['refNotPaid']! &&
          !_filters['noterNotPaid']! &&
          !_filters['partiallyPaidFilter']!) {
        return true;
      }

      return false;
    }).toList()
      ..sortTransactions();
  }

  bool isPaidFiltered(Transaction transaction) {
    return transaction.paymentStatus == PaymentStatus.paid &&
        _filters['paidFilter']!;
  }

  bool isNotPaidFiltered(Transaction transaction) {
    return transaction.paymentStatus == PaymentStatus.notPaid &&
        _filters['notPaidFilter']!;
  }

  bool isPartiallyPaidFiltered(Transaction transaction) {
    return transaction.paymentStatus == PaymentStatus.partiallyPaid &&
        _filters['partiallyPaidFilter']!;
  }

  bool isNoterNotPaid(Transaction transaction) {
    return transaction.noterDetails?.noterPayment?.payment == 'not done' &&
        _filters['noterNotPaid']!;
  }

  bool isRefNotPaid(Transaction transaction) {
    return (transaction.referenceDetails?.toRefPayment?.description ==
                'not done' ||
            transaction.referenceDetails?.toRefPayment?.description ==
                'partly done') &&
        _filters['refNotPaid']!;
  }

  bool isProviderNotPaid(Transaction transaction, String? providerName) {
    return providerName == null
        ? _checkIfUnpaidServices(transaction.extraServices) &&
            _filters['providerNotPaid']!
        : _checkIfUnpaidService(
                extraServicesList: transaction.extraServices,
                serviceProviderName: providerName) &&
            _filters['providerNotPaid']!;
  }

  bool isPinnedFiltered(Transaction transaction) {
    return transaction.isPinned && _filters['showPinned']!;
  }

  bool _checkIfUnpaidServices(List<ExtraService>? extraServicesList) {
    bool checkResult = false;
    if (extraServicesList != null) {
      for (var extraService in extraServicesList) {
        bool isPartiallyPaid =
            extraService.paymentStatus == PaymentStatus.partiallyPaid;
        bool isNotPaid = extraService.paymentStatus == PaymentStatus.notPaid;
        if (isPartiallyPaid || isNotPaid) checkResult = true;
      }
    }

    return checkResult;
  }

  bool _checkIfUnpaidService(
      {List<ExtraService>? extraServicesList, String? serviceProviderName}) {
    bool checkResult = false;
    if (serviceProviderName != null && extraServicesList != null) {
      for (var extraService in extraServicesList) {
        bool isPartiallyPaid =
            extraService.paymentStatus == PaymentStatus.partiallyPaid;
        bool isNotPaid = extraService.paymentStatus == PaymentStatus.notPaid;
        bool isSameProvider =
            extraService.serviceProviderName == serviceProviderName;
        if (isPartiallyPaid || isNotPaid && isSameProvider) checkResult = true;
      }
    } else {
      if (extraServicesList != null) {
        for (var extraService in extraServicesList) {
          bool isPartiallyPaid =
              extraService.paymentStatus == PaymentStatus.partiallyPaid;
          bool isNotPaid = extraService.paymentStatus == PaymentStatus.notPaid;
          if (isPartiallyPaid || isNotPaid) checkResult = true;
        }
      }
    }
    return checkResult;
  }
}
