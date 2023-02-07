part of 'pdf_generator.dart';

Page agencyPayReportBody({
  required bool fromCollect,
  required List<Transaction> transactions,
  required String agencyName,
  required int month,
  required int year,
}) {
  final referenceTransactions = transactions
      .where((element) =>
          (element.referenceDetails!.paymentBy == PaymentBy.reference))
      .toList();

  final portionTransactions = transactions
      .where((element) => (element.referenceDetails!.referencePortion != '0'))
      .toList();

  return MultiPage(
    margin: EdgeInsets.zero.copyWith(left: 6, right: 6),
    pageFormat: PdfPageFormat.a4,
    header: (context) => Center(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.p16),
          child: Image(height: 100, width: 100, MemoryImage(_logo))),
    ),
    build: (context) {
      final data = fromCollect
          ? referenceTransactions.reversed.map((transaction) {
              return mapTransactionToAgencyTableData(transaction, fromCollect);
            }).toList()
          : portionTransactions.reversed
              .map((transaction) =>
                  mapTransactionToAgencyTableData(transaction, fromCollect))
              .toList();
      return [
        Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.p16),
            child: Text('$agencyName Report for $month/$year',
                style: TextStyle(fontWeight: FontWeight.bold, font: _font))),
        Table.fromTextArray(
          headers: [
            'Customer Name',
            'Transaction Type',
            'Cost',
            'Payment',
            'Note',
            'Date',
            'Noter',
          ],
          headerStyle: TextStyle(fontWeight: FontWeight.bold),
          columnWidths: {
            0: FixedColumnWidth(125),
            4: FixedColumnWidth(75),
          },
          data: data,
          cellAlignment: Alignment.center,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: Sizes.p16)),
        if (!fromCollect)
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Portions Count : ${transactions.calcPortionsCount()}'),
                Text('Portions Total : ${transactions.calcPortionsTotal()}')
              ]),
        if (!fromCollect)
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Paid Portions Count : ${transactions.calcPaidPortionsCount()}'),
                Text('Paid Portions Total : ${transactions.calcPaidPortions()}')
              ]),
        if (!fromCollect)
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Unpaid Portions Count : ${transactions.calcUnpaidPortionsCount()}'),
                Text(
                    'Unpaid Portions Total : ${transactions.calcUnpaidPortions()}'),
              ]),
        if (fromCollect)
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Transactions Count : ${referenceTransactions.calcAgencyTransactionsCount()}'),
                Text(
                    'Transactions Total : ${referenceTransactions.calcAgencyTransactionsTotal()}')
              ]),
        if (fromCollect)
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Paid Transactions Count : ${referenceTransactions.calcPaidTransactionsCount()}'),
                Text(
                    'Paid Transactions Total : ${referenceTransactions.calcPaidTransactionsTotal()}')
              ]),
        if (fromCollect)
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Unpaid Transactions Count : ${referenceTransactions.calcUnpaidTransactionsCount()}'),
                Text(
                    'Unpaid Transactions Total : ${referenceTransactions.calcAgencyUnpaidTransactionsTotal()}')
              ]),
      ];
    },
  );
}

List<dynamic> mapTransactionToAgencyTableData(
    Transaction transaction, bool fromCollect) {
  if (fromCollect) {
    return [
      transaction.customer!.capitalizeFirstOfEach,
      transaction.transactionType.name.capitalizeFirstOfEach,
      transaction.referenceDetails!.paymentBy != PaymentBy.reference
          ? transaction.referenceDetails!.referencePortion
              .toString()
              .capitalizeFirst
          : transaction.amount.toString().capitalizeFirst,
      transaction.paymentStatus.description.capitalizeFirstOfEach,
      transaction.referenceDetails?.note?.capitalizeFirst ?? 'No Note',
      transaction.dateTime.dMyFromDateSlashSeperated,
      transaction.noterDetails != null ? 'Noter' : 'No Noter'
    ];
  } else {
    return [
      transaction.customer!.capitalizeFirstOfEach,
      transaction.transactionType.name.capitalizeFirstOfEach,
      transaction.referenceDetails!.referencePortion.toString().capitalizeFirst,
      transaction
          .referenceDetails?.toRefPayment?.description.capitalizeFirstOfEach,
      transaction.referenceDetails?.note ?? 'No Note',
      transaction.dateTime.dMyFromDateSlashSeperated,
      transaction.noterDetails != null ? 'Noter' : 'No Noter'
    ];
  }
}
