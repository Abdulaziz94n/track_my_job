import 'dart:io';

import 'package:excel/excel.dart';
// import 'package:open_filex/open_filex.dart';
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
    final cells = headers.map((e) => TextCellValue(e)).toList();
    excel.appendRow(fileName, cells);
    for (var transaction in excelData) {
      excel.appendRow(fileName, mapTransactionToRow(transaction));
    }
    final generatedFile = await saveExcel(excel, fileName);
    // await OpenFilex.open(generatedFile.path);
  }

  List<CellValue> mapTransactionToRow(Transaction transaction) {
    final noterDetails = transaction.noterDetails;
    final refDetails = transaction.referenceDetails;
    final extraServices = transaction.extraServices;
    final row = <CellValue>[];

    mapTransactionData(transaction, row);
    mapNoterData(noterDetails, row);
    mapRefData(refDetails, row);
    mapExtraServicesData(extraServices, row);
    return row;
  }

  mapTransactionData(Transaction transaction, List<CellValue> row) {
    final date = transaction.dateTime;
    row.add(DateTimeCellValue(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: date.hour,
        minute: date.minute));
    row.add(TextCellValue(transaction.customerType.name.capitalizeFirstOfEach));
    row.add(TextCellValue(transaction.customer!.capitalizeFirstOfEach));
    row.add(
        TextCellValue(transaction.transactionType.name.capitalizeFirstOfEach));
    row.add(TextCellValue(transaction.amount.toString().capitalizeFirstOfEach +
        ' ' +
        transaction.currency.name.capitalizeFirstOfEach));
    row.add(
        TextCellValue(transaction.netProfit.toString().capitalizeFirstOfEach));
    row.add(TextCellValue(
        transaction.paymentStatus.description.capitalizeFirstOfEach));
    row.add(TextCellValue(transaction.note?.capitalizeFirstOfEach ??
        'No Notes'.capitalizeFirstOfEach));
  }

  mapNoterData(NoterDetails? noterDetails, List<CellValue> row) {
    if (noterDetails != null) {
      row.add(TextCellValue('Included'.capitalizeFirstOfEach));
      row.add(TextCellValue(noterDetails.id.toString().capitalizeFirstOfEach));
      row.add(TextCellValue(
          noterDetails.noterFee.toString().capitalizeFirstOfEach));
      row.add(TextCellValue(
          noterDetails.noterProfit.toString().capitalizeFirstOfEach));
      row.add(TextCellValue(
          noterDetails.noterPayment!.payment.toString().capitalizeFirstOfEach));
    } else {
      row.add(TextCellValue(''));
      row.add(TextCellValue(0.toString()));
      row.add(TextCellValue(0.toString()));
      row.add(TextCellValue(0.toString()));
      row.add(TextCellValue('No Payment'.capitalizeFirstOfEach));
    }
  }

  mapRefData(ReferenceDetails? refDetails, List<CellValue> row) {
    if (refDetails != null) {
      row.add(TextCellValue(refDetails.reference!.name.capitalizeFirstOfEach));
      row.add(
          TextCellValue(refDetails.paymentBy.toString().capitalizeFirstOfEach));
      row.add(TextCellValue(
          refDetails.referencePortion.toString().capitalizeFirstOfEach));
      row.add(TextCellValue(
          refDetails.toRefPayment!.description.capitalizeFirstOfEach));
      row.add(TextCellValue(refDetails.note.toString().capitalizeFirstOfEach));
    } else {
      row.add(TextCellValue(''));
      row.add(TextCellValue(''));
      row.add(TextCellValue(''));
      row.add(TextCellValue(''));
      row.add(TextCellValue(''));
    }
  }

  mapExtraServicesData(List<ExtraService>? extraServices, List<CellValue> row) {
    if (extraServices != null) {
      row.add(TextCellValue(extraServices.length.toString()));
    } else {
      row.add(TextCellValue('No Extra Services'));
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
