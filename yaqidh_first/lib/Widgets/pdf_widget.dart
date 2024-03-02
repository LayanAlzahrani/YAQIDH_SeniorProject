// ignore_for_file: prefer_const_constructors, prefer_adjacent_string_concatenation
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:yaqidh_first/Widgets/pdf_txts.dart';

class PdfWidget {
  Future<Uint8List> generatePDF() async {
    final font = await rootBundle.load("fonts/Tajawal/Tajawal-Medium.ttf");
    final ttf = pw.Font.ttf(font);

    final font2 = await rootBundle.load("fonts/Tajawal/Tajawal-Bold.ttf");
    final ttfbold = pw.Font.ttf(font2);

    final pdf = pw.Document();

    //Title
    final title = pw.Center(
      child: pw.Text(
        "تقرير فرط الحركة ونقص الإنتباه",
        textDirection: pw.TextDirection.rtl,
        style: pw.TextStyle(font: ttfbold, fontSize: 20),
      ),
    );

    //Solid line
    final solidLine = pw.Container(
      margin: pw.EdgeInsets.symmetric(vertical: 8),
      height: 1,
      color: PdfColors.black,
    );

    //Text fields -first row-
    final textFieldRow = pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Row(children: [
          PdfTxts(
              text: 'أ. ريم احمد',
              font: ttf,
              textDirection: pw.TextDirection.rtl),
          PdfTxts(
              text: 'المسؤول عن التشخيص: ',
              font: ttfbold,
              textDirection: pw.TextDirection.rtl),
        ]),
        pw.Row(children: [
          PdfTxts(
              text: 'ندى فيصل', font: ttf, textDirection: pw.TextDirection.rtl),
          PdfTxts(
              text: 'إسم الطالب: ',
              font: ttfbold,
              textDirection: pw.TextDirection.rtl),
        ]),
      ],
    );

    //space
    final gap00 = pw.SizedBox(height: 10);

    //Text fields -sec row-
    final infoFieldRow = pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Row(children: [
          PdfTxts(
              text: '27 يونيو 2023',
              font: ttf,
              textDirection: pw.TextDirection.rtl),
          PdfTxts(
              text: 'التاريخ: ',
              font: ttfbold,
              textDirection: pw.TextDirection.rtl),
        ]),
      ],
    );

    //Solid line
    final solidLine2 = pw.Container(
      margin: pw.EdgeInsets.symmetric(vertical: 8),
      height: 1,
      color: PdfColors.black,
    );

    //space
    final gap0 = pw.SizedBox(height: 15);

    //Text
    final resultText = pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        PdfTxts(
            text: 'نتائج اللعبة:',
            font: ttfbold,
            textDirection: pw.TextDirection.rtl),
      ],
    );

    //space
    final gap1 = pw.SizedBox(height: 10);

    //first table
    final table = pw.TableHelper.fromTextArray(
      border: pw.TableBorder(
          left: pw.BorderSide(width: 1),
          top: pw.BorderSide(width: 1),
          right: pw.BorderSide(width: 1),
          bottom: pw.BorderSide(width: 1),
          horizontalInside: pw.BorderSide(width: 1),
          verticalInside: pw.BorderSide(width: 1)),
      headerAlignment: pw.Alignment.center,
      cellAlignment: pw.Alignment.center,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.zero,
        color: PdfColors.grey300,
      ),
      cellHeight: 30,
      data: [
        [
          PdfTxts(
              text: 'الدرجة',
              font: ttfbold,
              textDirection: pw.TextDirection.rtl),
          PdfTxts(
              text: 'اسم اللعبة',
              font: ttfbold,
              textDirection: pw.TextDirection.rtl)
        ],
        [
          PdfTxts(text: '', font: ttf, textDirection: pw.TextDirection.rtl),
          PdfTxts(
              text: 'اللعبة الأولى',
              font: ttf,
              textDirection: pw.TextDirection.rtl)
        ],
        [
          PdfTxts(text: '', font: ttf, textDirection: pw.TextDirection.rtl),
          PdfTxts(
              text: 'اللعبة الثانية',
              font: ttf,
              textDirection: pw.TextDirection.rtl)
        ],
        [
          PdfTxts(text: '', font: ttf, textDirection: pw.TextDirection.rtl),
          PdfTxts(
              text: 'اللعبة الثالثة',
              font: ttf,
              textDirection: pw.TextDirection.rtl)
        ],
        [
          PdfTxts(text: '', font: ttf, textDirection: pw.TextDirection.rtl),
          PdfTxts(
              text: 'اللعبة الرابعة',
              font: ttf,
              textDirection: pw.TextDirection.rtl)
        ],
        [
          PdfTxts(text: '', font: ttfbold, textDirection: pw.TextDirection.rtl),
          PdfTxts(
              text: 'المجموع',
              font: ttfbold,
              textDirection: pw.TextDirection.rtl)
        ],
      ],
    );

    //space
    final gap2 = pw.SizedBox(height: 25);

    //second table
    final table1 = pw.Column(
      children: [
        pw.Container(
          padding: pw.EdgeInsets.only(right: 10),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey300,
            border: pw.Border(
              left: pw.BorderSide(width: 1),
              top: pw.BorderSide(width: 1),
              right: pw.BorderSide(width: 1),
              bottom:
                  pw.BorderSide(width: 1), // Add border to bottom of each row
            ),
          ),
          height: 30,
          alignment: pw.Alignment.centerRight,
          child: PdfTxts(
              text: 'ملخص:',
              font: ttfbold,
              textDirection: pw.TextDirection.rtl),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide(width: 1),
              top: pw.BorderSide(width: 1),
              right: pw.BorderSide(width: 1),
              bottom:
                  pw.BorderSide(width: 1), // Add border to bottom of each row
            ),
          ),
          height: 100,
          alignment: pw.Alignment.topLeft,
          child: pw.Text('',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
        ),
      ],
    );

    //Build PDF
    pdf.addPage(
      pw.Page(
        //theme: ThemeData.withFont(base: font),
        //pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              title,
              gap1,
              solidLine,
              textFieldRow,
              gap00,
              infoFieldRow,
              solidLine2,
              gap0,
              resultText,
              gap1,
              table,
              gap2,
              table1,
              pw.Spacer(),
              pw.Align(
                alignment: pw.Alignment.bottomCenter,
                child: PdfTxts(
                    text: 'YAQIDH | يَقِظ',
                    font: ttfbold,
                    textDirection: pw.TextDirection.rtl),
              ),
            ],
          );
        },
      ),
    );

    // Save PDF to temporary directory
    final Uint8List pdfBytes = await pdf.save();
    await savePdfFile("ADHD_Report", pdfBytes);

    return pdfBytes;
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    try {
      final output = await getTemporaryDirectory();
      var filePath = "${output.path}/$fileName.pdf";
      final file = File(filePath);
      await file.writeAsBytes(byteList);
      await OpenFile.open(filePath);
    } catch (e) {
      print('Error saving or opening PDF file: $e');
    }
  }
}
