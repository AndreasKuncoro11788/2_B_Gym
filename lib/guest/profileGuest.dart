import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/register.dart';

class ProfileGuest extends StatelessWidget {
  const ProfileGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Pink yang menutupi bagian atas
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 40), // Padding atas diatur untuk menyesuaikan dengan desain
            color: Colors.pink,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,  // Ukuran avatar lebih besar
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.pink,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tamu',
                  style: TextStyle(
                    fontSize: 24,  // Ukuran font lebih besar
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Kamu belum punya akun\nSilahkan buat akun dengan klik tombol "Buat Akun" di bawah ini',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            ),
            onPressed: () {
              _showRegisterDialog(context);
            },
            child: const Text(
              'Buat Akun',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi
  void _showRegisterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Buat Akun'),
          content: const Text('Apakah Anda ingin membuat akun baru?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Teks warna putih
                backgroundColor: Colors.pink, // Warna latar belakang tombol Batal
              ),
              onPressed: () {
                Navigator.pop(context); // Menutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Teks warna putih
                backgroundColor: Colors.pink, // Warna latar belakang tombol Register
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterView()),
                );
              },
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }
}
