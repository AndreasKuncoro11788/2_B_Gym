import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_application_1/entity/RiwayatPemesanan.dart';
import 'package:flutter_application_1/client/RiwayatPemesananClient.dart';

class ReviewPage extends StatefulWidget {
  final String namaKelas;
  final String namaTrainer;
  final String namaAlat;
  final String jadwalKelas;
  final RiwayatPemesanan riwayat; // Menambahkan parameter RiwayatPemesanan

  const ReviewPage({
    super.key,
    required this.namaKelas,
    required this.namaTrainer,
    required this.namaAlat,
    required this.jadwalKelas,
    required this.riwayat, // Terima parameter riwayat
  });

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _rating = 0;
  TextEditingController _reviewController = TextEditingController();
  late RiwayatPemesanan _updatedRiwayat; // Untuk menyimpan perubahan riwayat

  @override
  void initState() {
    super.initState();
    // Inisialisasi rating dan review dengan data dari RiwayatPemesanan
    _rating = widget.riwayat.rating ?? 0; // Jika rating tidak ada, gunakan 0
    _reviewController.text = widget.riwayat.review ?? ''; // Jika review tidak ada, gunakan string kosong
    _updatedRiwayat = widget.riwayat; // Salin data riwayat yang ada
  }

  // Fungsi untuk submit form
  void onSubmit() async {
    // Update rating and review in RiwayatPemesanan
    _updatedRiwayat = _updatedRiwayat.copyWith(
      rating: _rating,
      review: _reviewController.text,
    );

    try {
      // Attempt to update the RiwayatPemesanan object
      RiwayatPemesanan success = await RiwayatPemesananClient.updateRiwayatPemesanan(_updatedRiwayat);

      // If the update is successful, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review berhasil dikirim!')),
      );

      // Go back after sending the review
      Navigator.pop(context);
    } catch (e) {
      // If an error occurs, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengirim review!')),
      );
    }
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
      body: SingleChildScrollView(
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
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating.toInt();
                    _updatedRiwayat = _updatedRiwayat.copyWith(rating: _rating); // Update rating pada riwayat
                  });
                },
              ),
              SizedBox(height: screenHeight * 0.04),

              // Review Input Field
              const Text(
                'Tulis Review:',
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
                onChanged: (text) {
                  _updatedRiwayat = _updatedRiwayat.copyWith(review: text); // Update review pada riwayat
                },
              ),
              SizedBox(height: screenHeight * 0.04),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink, // Use backgroundColor instead of primary
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.25,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Kirim Review',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
