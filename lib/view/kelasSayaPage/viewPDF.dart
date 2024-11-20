import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class PdfGenerator extends StatefulWidget {
  const PdfGenerator({super.key});

  @override
  _PdfGeneratorState createState() => _PdfGeneratorState();
}

class _PdfGeneratorState extends State<PdfGenerator> {
  final String id = "30DT-919848-AAB45372-G57"; // Contoh ID barcode
  final String name = "Gaspar Rivaldi";
  final String phone = "08123456789";
  final String address = "Jl. Kebon Jeruk No. 1";
  final List<Map<String, dynamic>> soldProducts = [
    {"name": "Yoga Class", "price": 50000, "amount": 1},
    {"name": "Yoga Matt", "price": 15000, "amount": 1},
  ];

  @override
  void initState() {
    super.initState();
    // Panggil createPdf() saat halaman dimuat
    createPdf();
  }

  // Fungsi untuk membuat PDF dan langsung membuka file PDF
  Future<void> createPdf() async {
    final doc = pw.Document();
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    // Placeholder logo image
    final imageLogo = (await rootBundle.load("lib/assets/logo Atma GYM.png")).buffer.asUint8List();
    final imageInvoice = pw.MemoryImage(imageLogo);

    // Calculate totals
    double subTotal = soldProducts.fold(0, (sum, item) => sum + item['price'] * item['amount']);
    double total = subTotal; // Add tax or other charges if needed

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          buildBackground: (pw.Context context) => pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.pinkAccent, width: 2),
            ),
          ),
        ),
        header: (pw.Context context) => pw.Center(
          child: pw.Text(
            "Detail Pemesanan",
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
        ),
        footer: (pw.Context context) => pw.Center(
          child: pw.Text("Generated on $formattedDate"),
        ),
        build: (pw.Context context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Personal details
              pw.Text("Nama: $name", style: pw.TextStyle(fontSize: 16)),
              pw.Text("No Telepon: $phone", style: pw.TextStyle(fontSize: 16)),
              pw.Text("Alamat: $address", style: pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 20),

              // Invoice table
              pw.Table.fromTextArray(
                headers: ['Nama Barang', 'Harga', 'Jumlah', 'Subtotal'],
                data: soldProducts.map((item) {
                  return [
                    item['name'],
                    "Rp ${item['price']}",
                    "${item['amount']}",
                    "Rp ${item['price'] * item['amount']}"
                  ];
                }).toList(),
              ),
              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  "Total: Rp $total",
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
              ),

              // Barcode
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.BarcodeWidget(
                  barcode: pw.Barcode.qrCode(),
                  data: id,
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // Save PDF to device
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/transaction.pdf");
    await file.writeAsBytes(await doc.save());

    // Open PDF in a viewer
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Generator"),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Text(
          "PDF telah dihasilkan dan dibuka.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
