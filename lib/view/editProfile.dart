import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/form_component.dart';

class Editprofile extends StatelessWidget {
  const Editprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 137, 137, 137),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 40, 40, 40),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Color(0xFFD9D9D9),
                      backgroundImage: NetworkImage(
                        'https://storage.googleapis.com/a1aa/image/r2zxfcEaRKRIQyJ93rkhZOGaF5nkwCef8wobNoQ7cCHDOcJnA.jpg',
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        print('Upload new profile picture clicked');
                      },
                      child: Text(
                        'Upload new profile picture',
                        style: TextStyle(
                          color: Color(0xFFFB3286),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Menggunakan inputForm dari form_component.dart
              inputForm(
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Pengguna tidak boleh kosong';
                  }
                  return null;
                },
                controller: TextEditingController(),
                hintTxt: 'Masukkan Nama Pengguna',
                helperTxt: 'Masukkan Nama Pengguna Anda',
                iconData: Icons.person,
              ),
              const SizedBox(height: 20),

              inputForm(
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Identitas tidak boleh kosong';
                  }
                  return null;
                },
                controller: TextEditingController(),
                hintTxt: 'Masukkan Nomor ID',
                helperTxt: 'Masukkan Nomor ID Anda',
                iconData: Icons.credit_card,
              ),
              const SizedBox(height: 20),

              inputForm(
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis Kelamin tidak boleh kosong';
                  }
                  return null;
                },
                controller: TextEditingController(),
                hintTxt: 'Masukkan Jenis Kelamin',
                helperTxt: 'Masukkan Jenis Kelamin Anda',
                iconData: Icons.transgender,
              ),
              const SizedBox(height: 20),

              inputForm(
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Umur tidak boleh kosong';
                  }
                  return null;
                },
                controller: TextEditingController(),
                hintTxt: 'Masukkan Umur',
                helperTxt: 'Masukkan Umur Anda',
                iconData: Icons.calendar_today,
              ),
              const SizedBox(height: 20),

              inputForm(
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat Email tidak boleh kosong';
                  }
                  return null;
                },
                controller: TextEditingController(),
                hintTxt: 'Masukkan Email',
                helperTxt: 'Masukkan Alamat Email Anda',
                iconData: Icons.email,
              ),
              const SizedBox(height: 20),

              inputForm(
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Telepon tidak boleh kosong';
                  }
                  return null;
                },
                controller: TextEditingController(),
                hintTxt: 'Masukkan Nomor Telepon',
                helperTxt: 'Masukkan Nomor Telepon Anda',
                iconData: Icons.phone,
              ),
              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFB3286),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    print('Simpan Perubahan clicked');
                  },
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
