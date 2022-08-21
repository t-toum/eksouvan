import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/features/register/domain/entity/patient.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/utils/constants.dart';

class ReportPatientPdf extends StatelessWidget {
  final List<Patient> listPateint;
  final DateTime? startDate;
  final DateTime? endDate;
  const ReportPatientPdf(
      {Key? key, required this.listPateint, this.startDate, this.endDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.kReportPatient.tr()),
      ),
      body: PdfPreview(build: ((format) => _generatePdf(format))),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final img = pw.MemoryImage(
        (await rootBundle.load(AppImages.brannerImg)).buffer.asUint8List());
    final font = pw.Font.ttf(
        await rootBundle.load("assets/fonts/NotoSansLao-Regular.ttf"));
    pdf.addPage(pw.MultiPage(
      pageFormat: format,
      margin: const pw.EdgeInsets.all(30),
      build: (context) {
        return [
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Row(
              children: [
                pw.Image(img, width: 100),
              ],
            ),
            pw.SizedBox(height: 20),
          (startDate!=null)?  pw.Row(
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(LocaleKeys.kStartDate.tr(),style:pw.TextStyle(font: font)),
                    pw.Text(ConvertDatas.converDateFormat(startDate))
                  ]
                ),
                pw.SizedBox(width: 20),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(LocaleKeys.kEndDate.tr(),style:pw.TextStyle(font: font)),
                    pw.Text(ConvertDatas.converDateFormat(endDate))
                  ]
                ),
              ]
            ):pw.SizedBox(),
            pw.Divider(),
            pw.Table.fromTextArray(
              headerStyle: pw.TextStyle(
                font: font,
                fontWeight: pw.FontWeight.bold,
                fontSize: 16,
              ),
              // cellStyle: pw.TextStyle(font: font),
              headerAlignment: pw.Alignment.centerLeft,
              border: pw.TableBorder(
                  horizontalInside: pw.BorderSide(
                      width: 0.5, color: PdfColor.fromHex('#707070'))),
              context: context,
              data: <List<String>>[
                List.generate(reportPatientcolumns.length,
                    (index) => reportPatientcolumns[index]),
                ...listPateint.map((patient) => [
                      "${listPateint.indexOf(patient) + 1}",
                      ConvertDatas.convertGender(
                          id: patient.gender, isShort: true),
                      patient.firstname ?? '',
                      patient.lastname ?? '',
                      ConvertDatas.converDateFormat(patient.birthday),
                      ConvertDatas.converDateFormat(patient.createDate),
                    ])
              ],
            ),
          ]),
        ];
      },
    ));

    return pdf.save();
  }
}
