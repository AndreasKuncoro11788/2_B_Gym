import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class PdfGenerator extends StatefulWidget {
  final String paymentId;
  final String orderId;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String orderDate;
  final String paymentMethod;
  final String paymentNumber;
  final String totalPayment;
  final List<Map<String, dynamic>> kelasOlahraga;
  final List<Map<String, dynamic>> dataAlatGym;

  const PdfGenerator({
    super.key,
    required this.paymentId,
    required this.orderId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.orderDate,
    required this.paymentMethod,
    required this.paymentNumber,
    required this.totalPayment,
    required this.kelasOlahraga,
    required this.dataAlatGym,
  });

  @override
  _PdfGeneratorState createState() => _PdfGeneratorState();
}

class _PdfGeneratorState extends State<PdfGenerator> {
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
            pw.Text("ID Pembayaran : ${widget.paymentId}"),
            pw.Text("ID Pemesanan : ${widget.orderId}"),
            pw.SizedBox(height: 10),
            pw.Text("id : 330305120750002"),
            pw.Text("pengguna : ${widget.name}"),
            pw.Text("email : ${widget.email}"),
            pw.Text("no telepon : ${widget.phone}"),
            pw.Text("Tanggal Pemesanan : ${widget.orderDate}"),
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
                children: [
                  // Menampilkan data kelas olahraga
                  ...widget.kelasOlahraga.map((item) {
                    return pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 5),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(child: pw.Text(item['name'])),
                          pw.Text("Rp. ${item['price']}"),
                        ],
                      ),
                    );
                  }).toList(),

                  // Menampilkan data alat gym
                  ...widget.dataAlatGym.map((item) {
                    return pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 5),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(child: pw.Text(item['name'])),
                          pw.Text("Rp. ${item['price']}"),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            pw.SizedBox(height: 15),

            // Payment method
            pw.Text("Metode Pembayaran : ${widget.paymentMethod}"),
            pw.Text("No : ${widget.paymentNumber}"),
            pw.SizedBox(height: 15),
            pw.Divider(),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                "Total Pembayaran : Rp. ${widget.totalPayment}",
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
            ),

            // Barcode and ID
            pw.SizedBox(height: 30),
            pw.Center(
              child: pw.BarcodeWidget(
                barcode: pw.Barcode.code128(),
                data: widget.paymentId,
                width: 200,
                height: 70,
              ),
            ),
            pw.Center(child: pw.Text(widget.paymentId)),
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
