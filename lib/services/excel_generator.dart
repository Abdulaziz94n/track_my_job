import 'dart:io';

import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:track_my_job/models/extra_service.dart';
import 'package:track_my_job/models/noter_details.dart';
import 'package:track_my_job/models/reference_details.dart';

import '../../core/extensions/string_extension.dart';
import '../models/transaction.dart';

abstract class ExcelGenerator {
  void createAndViewMonthlyReport(
      String fileName, List<Transaction> transactionsList);
}

class ExcelReportGenerator implements ExcelGenerator {
  @override
  void createAndViewMonthlyReport(
      String fileName, List<Transaction> transactionsList) async {
    final excelData = transactionsList.reversed.toList();
    final excel = Excel.createExcel();
    final defaultSheet = excel.getDefaultSheet();

    excel.rename(defaultSheet!, fileName);
    final headers = [
      'Date',
      'Customer Type',
      'Client',
      'Transaction Type',
      'Amount',
      'Net Profit',
      'Payment Status',
      'Notes',
      'Notary',
      'Notary No',
      'Notary Fee',
      'Notary Profit',
      'Notary Payment',
      'Reference',
      'Payment By',
      'Reference Portion',
      'To Reference Payment',
      'Reference Note',
      'Extra Services'
    ];
    excel.appendRow(fileName, headers);
    for (var transaction in excelData) {
      excel.appendRow(fileName, mapTransactionToRow(transaction));
    }
    final generatedFile = await saveExcel(excel, fileName);
    await OpenFilex.open(generatedFile.path);
  }

  List<String> mapTransactionToRow(Transaction transaction) {
    final noterDetails = transaction.noterDetails;
    final refDetails = transaction.referenceDetails;
    final extraServices = transaction.extraServices;
    final row = <String>[];

    mapTransactionData(transaction, row);
    mapNoterData(noterDetails, row);
    mapRefData(refDetails, row);
    mapExtraServicesData(extraServices, row);
    return row;
  }

  mapTransactionData(Transaction transaction, List<String> row) {
    row.add(DateFormat('dd/MM/yyyy').format(transaction.dateTime));
    row.add(transaction.customerType.name.capitalizeFirstOfEach);
    row.add(transaction.customer!.capitalizeFirstOfEach);
    row.add(transaction.transactionType.name.capitalizeFirstOfEach);
    row.add(transaction.amount.toString().capitalizeFirstOfEach +
        ' ' +
        transaction.currency.name.capitalizeFirstOfEach);
    row.add(transaction.netProfit.toString().capitalizeFirstOfEach);
    row.add(transaction.paymentStatus.description.capitalizeFirstOfEach);
    row.add(transaction.note?.capitalizeFirstOfEach ??
        'No Notes'.capitalizeFirstOfEach);
  }

  mapNoterData(NoterDetails? noterDetails, List<String> row) {
    if (noterDetails != null) {
      row.add('Included'.capitalizeFirstOfEach);
      row.add(noterDetails.id.toString().capitalizeFirstOfEach);
      row.add(noterDetails.noterFee.toString().capitalizeFirstOfEach);
      row.add(noterDetails.noterProfit.toString().capitalizeFirstOfEach);
      row.add(
          noterDetails.noterPayment!.payment.toString().capitalizeFirstOfEach);
    } else {
      row.add('');
      row.add(0.toString());
      row.add(0.toString());
      row.add(0.toString());
      row.add('No Payment'.capitalizeFirstOfEach);
    }
  }

  mapRefData(ReferenceDetails? refDetails, List<String> row) {
    if (refDetails != null) {
      row.add(refDetails.reference!.name.capitalizeFirstOfEach);
      row.add(refDetails.paymentBy.toString().capitalizeFirstOfEach);
      row.add(refDetails.referencePortion.toString().capitalizeFirstOfEach);
      row.add(refDetails.toRefPayment!.description.capitalizeFirstOfEach);
      row.add(refDetails.note.toString().capitalizeFirstOfEach);
    } else {
      row.add('');
      row.add('');
      row.add('');
      row.add('');
      row.add('');
    }
  }

  mapExtraServicesData(List<ExtraService>? extraServices, List<String> row) {
    if (extraServices != null) {
      row.add(extraServices.length.toString());
    } else {
      row.add('No Extra Services');
    }
  }

  Future<File> saveExcel(Excel excel, String name) async {
    final bytes = excel.save();
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/$name.xlsx';
    final file = File(path);
    File generatedFile = file..writeAsBytesSync(bytes!);
    return generatedFile;
  }
}
