part of 'pdf_generator.dart';

Page serviceProviderReportBody(
    {required String fileName,
    required String serviceProviderName,
    required List<Transaction> transactions,
    required int month,
    required int year}) {
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
        return mapTransactionToProviderTableData(
            transaction, serviceProviderName);
      }).toList();
      return [
        Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.p16),
            child: Text('$serviceProviderName Report for $month/$year',
                style: TextStyle(fontWeight: FontWeight.bold, font: _font))),
        Table.fromTextArray(
          headers: [
            'Customer Name',
            'Service Type',
            'Cost',
            'Payment',
            'Note',
            'Date'
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
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('All Transactions Count : ${transactions.length}'),
              Text(
                  'Portions Total : ${transactions.calcProviderPortions(serviceProviderName)}')
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Unpaid Portions Count : ${transactions.calcProviderUnpaidPortionsCount(serviceProviderName)}'),
              Text(
                  'Unpaid Portions Total : ${transactions.calcProviderUnpaidPortions(serviceProviderName)}')
            ]),
      ];
    },
  );
}

List<dynamic> mapTransactionToProviderTableData(
    Transaction transaction, String agencyName) {
  List<dynamic> serviceData = [];
  for (var service in transaction.extraServices!) {
    final isSameProvider =
        service.serviceProviderName?.trimAndLower == agencyName.trimAndLower;

    if (isSameProvider) {
      serviceData.add(transaction.customer!.capitalizeFirstOfEach);
      serviceData.add(service.service!.type.capitalizeFirstOfEach);
      serviceData.add(service.buyPrice!.capitalizeFirstOfEach);
      serviceData.add(service.paymentStatus!.description.capitalizeFirstOfEach);
      serviceData.add(service.note?.capitalizeFirstOfEach ?? 'No Note');
      serviceData.add(transaction.dateTime.dMyFromDateSlashSeperated);
    }
  }
  return serviceData;
}
