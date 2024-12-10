import 'package:flutter/material.dart';
import 'package:flutter_application_1/entity/Pembayaran.dart'; 
import 'package:flutter_application_1/client/PembayaranClient.dart'; 

class Pembayaran extends StatefulWidget {
  final String jenisKelas;
  final String namaTrainer;
  final String alatGym;
  final String jadwalKelas;
  final double hargaAlatGym; 
  final int hargaKelas; 
  final int idPemesanan; 

  const Pembayaran({
    super.key,
    required this.jenisKelas,
    required this.namaTrainer,
    required this.alatGym,
    required this.jadwalKelas,
    required this.hargaAlatGym,
    required this.hargaKelas,
    required this.idPemesanan, 
  });

  @override
  _PembayaranState createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  String? jenisPembayaran; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(0xFFEFEFEF),
        child: Column(
          children: [
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
                  Text(
                    'ID Pemesanan: ${widget.idPemesanan}', 
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
                              'Rp. ${widget.hargaKelas.toStringAsFixed(0)},', 
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Trainer : ${widget.namaTrainer}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 4),
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
                              'Rp. ${widget.hargaAlatGym.toStringAsFixed(0)},', 
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
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
                        'Rp. ${(widget.hargaKelas + widget.hargaAlatGym).toStringAsFixed(0)},', 
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
                    'Rp. ${(widget.hargaKelas + widget.hargaAlatGym).toStringAsFixed(0)},', 
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
                      
                      Navigator.pop(context); 
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
                          
                          int totalPembayaran =
                              (widget.hargaKelas + widget.hargaAlatGym).toInt();

                          await PembayaranClient.createPembayaran(
                            idPemesanan:
                                widget.idPemesanan, 
                            jenisPembayaran: jenisPembayaran!,
                            statusPembayaran: 'On Going', 
                            totalPembayaran: totalPembayaran,
                          );

                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Pesanan berhasil dibuat!')),
                          );

                          
                          Navigator.pop(
                              context); 
                        } catch (e) {
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Gagal membuat pesanan: $e')),
                          );
                        }
                      } else {
                      
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
