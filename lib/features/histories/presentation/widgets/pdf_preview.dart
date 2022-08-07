import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../core/usecases/pdf_history_params.dart';

class PdfPreviewWidget extends StatelessWidget {
  final PdfHistoryParams? historyParams;
  const PdfPreviewWidget({Key? key, this.historyParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final img = pw.MemoryImage(
        (await rootBundle.load(AppImages.brannerImg)).buffer.asUint8List());
    final defultAvatar = pw.MemoryImage(
        (await rootBundle.load(AppImages.default_avatar)).buffer.asUint8List());
    pw.Widget textItem({required String title, String? value}) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(
              width: 150,
              child:
                  pw.Text(title, style: pw.TextStyle(font: font, fontSize: 14)),
            ),
            pw.Text(value ?? '', style: pw.TextStyle(font: font))
          ],
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        margin: const pw.EdgeInsets.all(30),
        build: (context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Image(img, width: 100),
                  ],
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                      left: 40, top: 20, right: 40, bottom: 20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Center(
                        child: pw.Text(
                          LocaleKeys.kPatientHistory.tr(),
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 25,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      //Header
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Image(
                            defultAvatar,
                            width: 60,
                          ),
                          pw.SizedBox(width: 15),
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "${historyParams?.patient?.firstname ?? ''} ${historyParams?.patient?.lastname ?? ''}",
                                  style: pw.TextStyle(font: font, fontSize: 20),
                                ),
                                pw.Text('Address',
                                    style: pw.TextStyle(font: font)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      textItem(
                        title: '${LocaleKeys.kGender.tr()}:',
                        value: ConvertDatas.convertGender(
                            historyParams?.patient?.gender),
                      ),
                      textItem(
                        title: '${LocaleKeys.kDateOfBirth.tr()}:',
                        value: ConvertDatas.converDateFormat(
                            historyParams?.patient?.birthday),
                      ),
                      textItem(
                        title: '${LocaleKeys.kWeight.tr()}:',
                        value: '${historyParams?.patient?.weight}.Kg',
                      ),
                      textItem(
                        title: '${LocaleKeys.KHeight.tr()}:',
                        value: '${historyParams?.patient?.height}.cm',
                      ),
                      textItem(
                        title: '${LocaleKeys.kCongenitalDeases.tr()}:',
                        value: historyParams?.patient?.congenitalDeases,
                      ),
                      textItem(
                        title: '${LocaleKeys.kPhone.tr()}:',
                        value: historyParams?.patient?.tel,
                      ),
                      pw.SizedBox(height: 20),
                      pw.Text(LocaleKeys.kDiagnoseHistory.tr(),
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 18,
                          )),
                      pw.Divider(),
                      pw.Table.fromTextArray(
                          headerStyle: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 16,
                          ),
                          cellStyle: pw.TextStyle(
                            font: font,
                          ),
                          headerAlignment: pw.Alignment.centerLeft,
                          border: pw.TableBorder(
                              horizontalInside: pw.BorderSide(
                                  width: 0.5,
                                  color: PdfColor.fromHex('#707070'))),
                          context: context,
                          data: <List<String>>[
                            List.generate(historyColumn.length,
                                (index) => historyColumn[index]),
                            ...historyParams?.listDiagnose.map((diagnose) => [
                                      ConvertDatas.converDateFormat(
                                          diagnose.diagnoseDate),
                                      diagnose.deases
                                          .toString()
                                          .replaceAll('[', '')
                                          .replaceAll(']', ''),
                                      diagnose.medicines
                                          .toString()
                                          .replaceAll('[', '')
                                          .replaceAll(']', ''),
                                    ]) ??
                                []
                          ]),
                      pw.SizedBox(height: 20),
                      pw.Text(LocaleKeys.kAppointmentHistory.tr(),
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 18,
                          )),
                      pw.Divider(),
                      pw.Table.fromTextArray(
                          headerStyle: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 16,
                          ),
                          cellStyle: pw.TextStyle(
                            font: font,
                          ),
                          headerAlignment: pw.Alignment.centerLeft,
                          border: pw.TableBorder(
                              horizontalInside: pw.BorderSide(
                                  width: 0.5,
                                  color: PdfColor.fromHex('#707070'))),
                          context: context,
                          data: <List<String>>[
                            List.generate(historyAppointment.length,
                                (index) => historyAppointment[index]),
                            ...historyParams?.listAppointment
                                    .map((appointment) => [
                                          ConvertDatas.converDateFormat(
                                              appointment.dueDate),
                                          appointment.description ?? ''
                                        ]) ??
                                []
                          ]),
                    ],
                  ),
                )
              ],
            )
          ];
        },
      ),
    );
    return pdf.save();
  }
}
