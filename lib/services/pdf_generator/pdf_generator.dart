import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/enums/ref_payment_by.dart';
import '../../../core/extensions/date_time_extension.dart';
import '../../../core/extensions/string_extension.dart';
import '../../../core/extensions/transactions_list_extension.dart';
import '../../../core/utils/utils.dart';
import '../../core/constants/assets.dart';
import '../../models/transaction.dart';

part 'agency_reports.dart';
part 'noter_reports.dart';
part 'service_provider_reports.dart';

late Uint8List _logo;
late Font _font;

class PdfGenerator {
  static Future<void> init() async {
    _font = await PdfGoogleFonts.nunitoExtraLight();
    _logo = (await rootBundle.load(AssetsManager.pdfLogo)).buffer.asUint8List();
  }

  void generateAgencyReport(
      {required String fileName,
      required String agencyName,
      required List<Transaction> transactions,
      required int month,
      required bool fromCollect,
      required int year}) async {
    final pdf = Document(
      theme: ThemeData.withFont(base: _font)
          .copyWith(defaultTextStyle: TextStyle(fontSize: 11)),
    );

    pdf.addPage(agencyPayReportBody(
        agencyName: agencyName,
        fromCollect: fromCollect,
        month: month,
        transactions: transactions,
        year: year));

    _saveAndOpenPdf(pdf, fileName);
  }

  void generateServiceProviderReport({
    required String fileName,
    required String serviceProviderName,
    required List<Transaction> transactions,
    required int month,
    required int year,
  }) {
    final pdf = Document(
      theme: ThemeData.withFont(base: _font)
          .copyWith(defaultTextStyle: TextStyle(fontSize: 11)),
    );
    pdf.addPage(serviceProviderReportBody(
        fileName: fileName,
        serviceProviderName: serviceProviderName,
        transactions: transactions,
        month: month,
        year: year));

    _saveAndOpenPdf(pdf, fileName);
  }

  void generateNoterReport({
    required String fileName,
    required String noterName,
    required List<Transaction> transactions,
    required int month,
    required int year,
  }) {
    final pdf = Document(
      theme: ThemeData.withFont(base: _font)
          .copyWith(defaultTextStyle: TextStyle(fontSize: 11)),
    );
    pdf.addPage(noterReport(
        fileName: fileName,
        noterName: noterName,
        transactions: transactions,
        month: month,
        year: year));
    _saveAndOpenPdf(pdf, fileName);
  }

  _saveAndOpenPdf(Document pdf, String fileName) async {
    try {
      final doc = await pdf.save();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName.pdf');
      final generatedPDF = await file.writeAsBytes(doc);
      // await OpenFilex.open(generatedPDF.path);
    } catch (e) {
      Utils.showGetxErrorSnackBar();
    }
  }
}
