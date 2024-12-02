import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class PdfGenerator extends StatefulWidget {
  const PdfGenerator({super.key});

  @override
  _PdfGeneratorState createState() => _PdfGeneratorState();
}

class _PdfGeneratorState extends State<PdfGenerator> {
  final String id = "30DT-919848-AAB45372-G57";
  final String paymentId = "12#3456";
  final String orderId = "uyt34";
  final String name = "Gaspar Rivaldi";
  final String phone = "08123456789";
  final String email = "gasparr@gmail.com";
  final String address = "Jl. Kebon Jeruk No. 1";
  final String orderDate = "20 September 2024";
  final String paymentMethod = "ShopeePay";
  final String paymentNumber = "08123456789";
  final List<Map<String, dynamic>> soldProducts = [
    {"name": "Jenis Kelas : Yoga", "price": 50000, "trainer": "Bowo", "schedule": "Senin 08.00 - 09.00"},
    {"name": "Alat GYM : Yoga Matt", "price": 15000},
  ];

  @override
  void initState() {
    super.initState();
    createPdf();
  }

  Future<void> createPdf() async {
    final doc = pw.Document();

    // Create PDF content
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            pw.Container(
              color: PdfColors.pinkAccent,
              width: double.infinity,
              padding: pw.EdgeInsets.all(10),
              child: pw.Center(
                child: pw.Text(
                  "Detail Pemesanan",
                  style: pw.TextStyle(fontSize: 24, color: PdfColors.white, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.SizedBox(height: 10),

            // Payment and Order Details
            pw.Text("Bukti Pembayaran", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 5),
            pw.Text("ID Pembayaran : $paymentId"),
            pw.Text("ID Pemesanan : $orderId"),
            pw.SizedBox(height: 10),
            pw.Text("id : 330305120750002"),
            pw.Text("pengguna : $name"),
            pw.Text("email : $email"),
            pw.Text("no telepon : ${phone.replaceRange(3, 11, "*******")}"),
            pw.Text("Tanggal Pemesanan : $orderDate"),
            pw.SizedBox(height: 15),

            // Product details
            pw.Container(
              padding: pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey200,
                borderRadius: pw.BorderRadius.circular(10),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: soldProducts.map((item) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 5),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(child: pw.Text(item['name'])),
                        pw.Text("Rp. ${item['price'].toStringAsFixed(0)}"),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            pw.SizedBox(height: 15),

            // Payment method
            pw.Text("Metode Pembayaran : $paymentMethod"),
            pw.Text("No : $paymentNumber"),
            pw.SizedBox(height: 15),
            pw.Divider(),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                "Total Pembayaran : Rp. 65.000",
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
            ),

            // Barcode and ID
            pw.SizedBox(height: 30),
            pw.Center(
              child: pw.BarcodeWidget(
                barcode: pw.Barcode.code128(),
                data: id,
                width: 200,
                height: 70,
              ),
            ),
            pw.Center(child: pw.Text(id)),
          ],
        ),
      ),
    );

    // Save PDF
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/transaction.pdf");
    await file.writeAsBytes(await doc.save());

    // Open PDF
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
