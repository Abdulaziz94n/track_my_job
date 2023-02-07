part of 'pdf_generator.dart';

Page noterReport({
  required String fileName,
  required String noterName,
  required List<Transaction> transactions,
  required int month,
  required int year,
}) {
  return MultiPage(
    margin: EdgeInsets.zero.copyWith(left: 6, right: 6),
    pageFormat: PdfPageFormat.a4,
    header: (context) => Center(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.p16),
          child: Image(height: 100, width: 100, MemoryImage(_logo))),
    ),
    build: (context) {
      final data = transactions.reversed.map((transaction) {
        return mapTransactionToTableData(transaction);
      }).toList();
      return [
        Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.p16),
            child: Text('Noter $noterName Report for $month/$year',
                style: TextStyle(fontWeight: FontWeight.bold, font: _font))),
        Table.fromTextArray(
          headers: ['Customer Name', 'Noter Fee', 'Noter Profit', 'Date'],
          headerStyle: TextStyle(fontWeight: FontWeight.bold),
          data: data,
          cellAlignment: Alignment.center,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: Sizes.p16)),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('All Transactions Count : ${transactions.length}'),
              Text('Notary Total : ${transactions.calcNoterTotalAmount()}')
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Notary Total Profit : ${transactions.calcTranslatorApproxGain()}'),
            ]),
      ];
    },
  );
}

List<dynamic> mapTransactionToTableData(Transaction transaction) {
  final noterDetails = transaction.noterDetails;
  return [
    transaction.customer.toString().capitalizeFirstOfEach,
    noterDetails!.noterFee.toString(),
    noterDetails.noterProfit,
    transaction.dateTime.dMyFromDateSlashSeperated
  ];
}
