import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import '../../../shared/models/transaction.dart';

class ExportService {
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  // Export to PDF
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
            ],
          ),
        ],
        footer: (context) => pw.Center(
          child: pw.Text('Página ${context.pageNumber} de ${context.pagesCount}'),
        ),
      ),
    );

    if (kIsWeb) {
      await Printing.sharePdf(bytes: await pdf.save(), filename: 'relatorio_financeiro.pdf');
    } else {
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/relatorio_financeiro.pdf');
      await file.writeAsBytes(await pdf.save());
      await Share.shareXFiles([XFile(file.path)], text: 'Meu Relatório Financeiro');
    }
  }

  // Export to Excel
  Future<void> exportTransactionsToExcel(List<Transaction> transactions) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Transações'];

    // Header
    sheetObject.appendRow(['Data', 'Descrição', 'Categoria', 'Valor', 'Tipo']);

    // Data
    for (var t in transactions) {
      sheetObject.appendRow([
        DateFormat('dd/MM/yyyy').format(t.date),
        t.title,
        t.category,
        t.amount,
        t.type == TransactionType.income ? 'Receita' : 'Despesa'
      ]);
    }

    var bytes = excel.save();
    if (bytes != null) {
      if (kIsWeb) {
        // Web download logic (omitted for brevity, typically uses dart:html)
        await Printing.sharePdf(bytes: Uint8List.fromList(bytes), filename: 'relatorio_financeiro.xlsx');
      } else {
        final output = await getTemporaryDirectory();
        final file = File('${output.path}/relatorio_financeiro.xlsx');
        await file.writeAsBytes(bytes);
        await Share.shareXFiles([XFile(file.path)], text: 'Meu Relatório Financeiro Excel');
      }
    }
  }
}
