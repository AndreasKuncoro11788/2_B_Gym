import 'package:flutter/material.dart';

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

              _buildInputField(
                label: 'Nama Depan',
                placeholder: 'Masukkan Nama Depan',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),

              _buildInputField(
                label: 'Nama Belakang',
                placeholder: 'Masukkan Nama Belakang',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),

              _buildInputField(
                label: 'Nomor Identitas',
                placeholder: 'Masukkan Nomor ID',
                icon: Icons.badge,
              ),
              const SizedBox(height: 20),

              _buildInputField(
                label: 'Jenis Kelamin',
                placeholder: 'Masukkan Jenis Kelamin',
                icon: Icons.wc,
              ),
              const SizedBox(height: 20),

              _buildInputField(
                label: 'Umur',
                placeholder: 'Masukkan Umur',
                icon: Icons.volunteer_activism,
              ),

              const SizedBox(height: 20),
              _buildInputField(
                label: 'Alamat Email',
                placeholder: 'Masukkan Email',
                icon: Icons.email,
              ),
              const SizedBox(height: 20),

              _buildInputField(
                label: 'Nomor Telepon',
                placeholder: 'Masukkan Nomor Telepon',
                icon: Icons.phone,
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

  Widget _buildInputField({
    required String label,
    required String placeholder,
    required IconData icon,
  }) {
    return Center( 
      child: Container(
        width: 350,
        height: 72,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 11,
              child: Container(
                width: 350,
                height: 61,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFFB3286)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 17,
              top: 0,
              child: SizedBox(
                width: 85,
                height: 22,
                child: Text(
                  label,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.black,
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 52,
              top: 29,
              child: SizedBox(
                width: 222,
                height: 22,
                child: Text(
                  placeholder,
                  style: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 17,
              top: 29,
              child: Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
