import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_application_1/entity/RiwayatPemesanan.dart';
import 'package:flutter_application_1/client/RiwayatPemesananClient.dart';
import 'package:flutter_application_1/client/PembayaranClient.dart';

class ReviewPage extends StatefulWidget {
  final String namaKelas;
  final String namaTrainer;
  final String namaAlat;
  final String jadwalKelas;
  final int idPemesanan;

  const ReviewPage({
    super.key,
    required this.namaKelas,
    required this.namaTrainer,
    required this.namaAlat,
    required this.jadwalKelas,
    required this.idPemesanan,
  });

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _rating = 0;
  TextEditingController _reviewController = TextEditingController();
  late RiwayatPemesanan _updatedRiwayat;
  late int _idPembayaran;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _updatedRiwayat = RiwayatPemesanan(id: 0, review: '', rating: 0, id_pembayaran: 0);
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true; // Tampilkan loading saat data sedang diproses
    });

    try {
      final pembayaranList = await PembayaranClient.fetchPembayaranByPemesananId(widget.idPemesanan);
      print('Pembayaran List: $pembayaranList'); // Debug log

      if (pembayaranList.isNotEmpty && pembayaranList[0].id != null) {
        _idPembayaran = pembayaranList[0].id;

        final riwayat = await RiwayatPemesananClient.fetchRiwayatPemesananByPembayaranId(_idPembayaran);
        print('Riwayat List: $riwayat'); // Debug log

        if (riwayat.isNotEmpty) {
          final singleRiwayat = riwayat[0];
          setState(() {
            _rating = singleRiwayat.rating ?? 0;
            _reviewController.text = singleRiwayat.review ?? '';
            _updatedRiwayat = singleRiwayat;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Riwayat pemesanan tidak ditemukan!')),
          );
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pembayaran tidak ditemukan!')),
        );
      }
    } catch (e) {
      print('Error: $e'); // Log error untuk debugging
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data: ${e.toString()}')),
      );
    }
  }

  void onSubmit() async {
    _updatedRiwayat = _updatedRiwayat.copyWith(
      rating: _rating,
      review: _reviewController.text,
    );

    try {
      if (_updatedRiwayat.id == null || _updatedRiwayat.id == 0) {
        await RiwayatPemesananClient.createRiwayatPemesanan(_updatedRiwayat);
      } else {
        await RiwayatPemesananClient.updateRiwayatPemesanan(_updatedRiwayat);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review berhasil dikirim!')),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Error: $e'); // Log error untuk debugging
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim review: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _reviewController.dispose(); // Pastikan controller dibersihkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Review Pemesanan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.pink,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Detail Pemesanan
                    Container(
                      width: screenWidth * 0.90,
                      padding: EdgeInsets.all(screenHeight * 0.02),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jenis Kelas: ${widget.namaKelas}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Trainer: ${widget.namaTrainer}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Alat GYM: ${widget.namaAlat}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Jadwal: ${widget.jadwalKelas}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    // Rating
                    const Text(
                      'Berikan Rating: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    RatingBar.builder(
                      initialRating: _rating.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 40.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating.toInt();
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    // Review Input Field
                    const Text(
                      'Tulis Review: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextField(
                      controller: _reviewController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Masukkan review Anda...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    // Submit Button
                    Center(
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        ),
                        child: const Text(
                          'Kirim Review',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
