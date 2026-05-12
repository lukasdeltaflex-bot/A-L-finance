import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import '../../../shared/models/transaction.dart';

class ExportService {
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  Future<void> exportTransactionsToPdf(List<Transaction> transactions) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Relatório Financeiro Premium', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text('Gerado em: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}'),
            pw.Divider(),
          ],
        ),
        build: (context) => [
          pw.TableHelper.fromTextArray(
            context: context,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.indigo900),
            data: <List<String>>[
              <String>['Data', 'Descrição', 'Categoria', 'Valor'],
              ...transactions.map((t) => [
                DateFormat('dd/MM/yyyy').format(t.date),
                t.title,
                t.category,
                currencyFormat.format(t.amount)
              ]),
              if (transactions.isEmpty) ['-', 'Nenhuma transação no período', '-', '-'],
            ],
          ),
        ],
      ),
    );

    final bytes = await pdf.save();
    if (kIsWeb) {
      await Printing.sharePdf(bytes: bytes, filename: 'relatorio_financeiro.pdf');
    } else {
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/relatorio_financeiro.pdf');
      await file.writeAsBytes(bytes);
      await Share.shareXFiles([XFile(file.path)], text: 'Meu Relatório Financeiro');
    }
  }

  Future<void> exportTransactionsToExcel(List<Transaction> transactions) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Transações'];

    // Excel 4.0.6+ requires CellValue objects
    sheetObject.appendRow([
      TextCellValue('Data'),
      TextCellValue('Descrição'),
      TextCellValue('Categoria'),
      TextCellValue('Valor'),
      TextCellValue('Tipo'),
    ]);

    for (var t in transactions) {
      sheetObject.appendRow([
        TextCellValue(DateFormat('dd/MM/yyyy').format(t.date)),
        TextCellValue(t.title),
        TextCellValue(t.category),
        DoubleCellValue(t.amount),
        TextCellValue(t.type == TransactionType.income ? 'Receita' : 'Despesa')
      ]);
    }

    final bytes = excel.save();
    if (bytes != null) {
      if (kIsWeb) {
        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", "relatorio_financeiro.xlsx")
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        final output = await getTemporaryDirectory();
        final file = File('${output.path}/relatorio_financeiro.xlsx');
        await file.writeAsBytes(bytes);
        await Share.shareXFiles([XFile(file.path)], text: 'Meu Relatório Financeiro Excel');
      }
    }
  }
}
