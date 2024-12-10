import 'package:flutter/material.dart';
import 'package:flutter_application_1/entity/Pembayaran.dart'; // Ensure you import your Pembayaran model
import 'package:flutter_application_1/client/PembayaranClient.dart'; // Ensure you import your PembayaranClient

class Pembayaran extends StatefulWidget {
  final String jenisKelas;
  final String namaTrainer;
  final String alatGym;
  final String jadwalKelas;
  final double hargaAlatGym; // Price of gym equipment
  final int hargaKelas; // Class price
  final int idPemesanan; // Keep only the order ID as an integer

  const Pembayaran({
    super.key,
    required this.jenisKelas,
    required this.namaTrainer,
    required this.alatGym,
    required this.jadwalKelas,
    required this.hargaAlatGym,
    required this.hargaKelas,
    required this.idPemesanan, // Keep the order ID as an integer
  });

  @override
  _PembayaranState createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  String? jenisPembayaran; // Variable to hold the selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(0xFFEFEFEF),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              height: 83,
              color: const Color(0xFFFB3286),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    const Text(
                      'Pembayaran',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
            // Detail Pembayaran Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Detail Pembayaran',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Display Order ID only
                  Text(
                    'ID Pemesanan: ${widget.idPemesanan}', // Displaying the integer ID
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row for Class Type and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Jenis Kelas : ${widget.jenisKelas}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              'Rp. ${widget.hargaKelas.toStringAsFixed(0)},', // Display the class price
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Trainer Row
                        Text(
                          'Trainer : ${widget.namaTrainer}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Row for Gym Equipment and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Alat GYM : ${widget.alatGym}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              'Rp. ${widget.hargaAlatGym.toStringAsFixed(0)},', // Display the dynamic price
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Schedule Row
                        Text(
                          'Jadwal : ${widget.jadwalKelas}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Rp. ${(widget.hargaKelas + widget.hargaAlatGym).toStringAsFixed(0)},', // Calculate total payment
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 40, color: Color(0xFFD9D9D9), thickness: 2),

            // Payment Method Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Radio buttons for payment methods with icons
                  ListTile(
                    title: Row(
                      children: [
                        Image.asset('lib/assets/bca_mobile.png',
                            width: 30, height: 30),
                        const SizedBox(width: 10),
                        const Text('Kartu Kredit'),
                      ],
                    ),
                    leading: Radio<String>(
                      value: 'Kartu Kredit',
                      groupValue: jenisPembayaran,
                      onChanged: (value) {
                        setState(() {
                          jenisPembayaran = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Image.asset('lib/assets/bni.png',
                            width: 30, height: 30),
                        const SizedBox(width: 10),
                        const Text('Debit'),
                      ],
                    ),
                    leading: Radio<String>(
                      value: 'Debit',
                      groupValue: jenisPembayaran,
                      onChanged: (value) {
                        setState(() {
                          jenisPembayaran = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Image.asset('lib/assets/gopay.png',
                            width: 30, height: 30),
                        const SizedBox(width: 10),
                        const Text('E - Wallet'),
                      ],
                    ),
                    leading: Radio<String>(
                      value: 'E - Wallet',
                      groupValue: jenisPembayaran,
                      onChanged: (value) {
                        setState(() {
                          jenisPembayaran = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 40, color: Color(0xFFD9D9D9), thickness: 2),

            // Final Payment Summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Pembayaran',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Rp. ${(widget.hargaKelas + widget.hargaAlatGym).toStringAsFixed(0)},', // Calculate total payment
                    style: const TextStyle(
                      color: Color(0xFFFB3286),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE10003),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Handle cancel action
                      Navigator.pop(context); // Go back to the previous screen
                    },
                    child: const Text(
                      'BATAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFB3286),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (jenisPembayaran != null) {
                        try {
                          // Calculate total payment
                          int totalPembayaran =
                              (widget.hargaKelas + widget.hargaAlatGym).toInt();

                          await PembayaranClient.createPembayaran(
                            idPemesanan:
                                widget.idPemesanan, // Pastikan ini adalah int
                            jenisPembayaran: jenisPembayaran!,
                            statusPembayaran: 'On Going', // Set initial status
                            totalPembayaran: totalPembayaran,
                          );

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Pesanan berhasil dibuat!')),
                          );

                          // Optionally, navigate to another screen or reset the form
                          Navigator.pop(
                              context); // Go back to the previous screen
                        } catch (e) {
                          // Show an error message if the order creation fails
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Gagal membuat pesanan: $e')),
                          );
                        }
                      } else {
                        // Show an error message if no payment method is selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Pilih metode pembayaran')),
                        );
                      }
                    },
                    child: const Text(
                      'BUAT PESANAN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
