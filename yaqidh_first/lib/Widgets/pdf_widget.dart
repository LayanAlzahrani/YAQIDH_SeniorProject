// ignore_for_file: prefer_const_constructors, prefer_adjacent_string_concatenation
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class PdfWidget {
  Future<Uint8List> generatePDF() async {
    final font = await rootBundle.load("fonts/Tajawal/Tajawal-Medium.ttf");
    final ttf = pw.Font.ttf(font);

    final pdf = pw.Document();

    //Title
    final title = pw.Center(
      child: pw.Text(
        "تقرير فرط الحركة ونقص الإنتباه",
        textDirection: pw.TextDirection.rtl,
        style: pw.TextStyle(
            font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
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
        pw.Text("المسؤول عن التشخيص: " + "أ. ريم احمد",
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(
              font: ttf,
            )),
        pw.Text("إسم الطالب: " + "ندى فيصل",
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(
              font: ttf,
            )),
      ],
    );

    //space
    final gap00 = pw.SizedBox(height: 6);

    //Text fields -sec row-
    final infoFieldRow = pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Text("التاريخ: " + "27 يونيو 2023",
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(
              font: ttf,
            )),
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
        pw.Text("نتائج اللعبة:",
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(
                font: ttf, fontSize: 14, fontWeight: pw.FontWeight.bold)),
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
          pw.Text('الدرجة',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
          pw.Text('اسم اللعبة',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
        ],
        [
          pw.Text('',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
          pw.Text('اللعبة الأولى',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
        ],
        [
          pw.Text('',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
          pw.Text('اللعبة الثانية',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
        ],
        [
          pw.Text('',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
          pw.Text('اللعبة الثالثة',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
        ],
        [
          pw.Text('',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
          pw.Text('اللعبة الرابعة',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
        ],
        [
          pw.Text('',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
          pw.Text('المجموع:',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
        ],
      ],
    );

    //space
    final gap2 = pw.SizedBox(height: 25);

    //second table
    final table1 = pw.Column(
      children: [
        pw.Container(
          padding: pw.EdgeInsets.only(left: 10),
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
          child: pw.Text('ملخص:',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
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
                child: pw.Text(
                  'YAQIDH | يَقِظ',
                  textDirection: pw.TextDirection.rtl,
                  style:
                      pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
                ),
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
