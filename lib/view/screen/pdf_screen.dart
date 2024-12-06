import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerar PDF')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdf = pw.Document();
            pdf.addPage(pw.Page(build: (context) {
              return pw.Center(child: pw.Text('Relatório de Séries'));
            }));
            await Printing.layoutPdf(onLayout: (format) async => pdf.save());
          },
          child: Text('Gerar PDF'),
        ),
      ),
    );
  }
}
