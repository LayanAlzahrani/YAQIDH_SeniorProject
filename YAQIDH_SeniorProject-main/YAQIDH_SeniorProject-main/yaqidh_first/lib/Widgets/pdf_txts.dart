import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTxts extends pw.StatelessWidget {
  final String text;
  final pw.Font font;
  final pw.TextDirection textDirection;

  PdfTxts({
    Key? key,
    required this.textDirection,
    required this.text,
    required this.font,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(
      text,
      textDirection: textDirection,
      style: pw.TextStyle(
        font: font,
      ),
    );
  }
}
