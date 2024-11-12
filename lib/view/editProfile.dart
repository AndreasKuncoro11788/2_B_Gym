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
        centerTitle: true, // Center the title
        backgroundColor: Colors.white,
        elevation: 0, // Optional: removes the shadow under the AppBar
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // Handle back button press
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
                color: Color.fromARGB(255, 40, 40, 40), // Customize the icon color
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView( // Add SingleChildScrollView for scrollable content
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 80,  // Increase the size of the avatar
                      backgroundColor: Color(0xFFD9D9D9),
                      backgroundImage: NetworkImage(
                        'https://storage.googleapis.com/a1aa/image/r2zxfcEaRKRIQyJ93rkhZOGaF5nkwCef8wobNoQ7cCHDOcJnA.jpg',
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Text with underline
                    GestureDetector(
                      onTap: () {
                        print('Upload new profile picture clicked');
                        // Add logic for uploading new profile picture
                      },
                      child: Text(
                        'Upload new profile picture',
                        style: TextStyle(
                          color: Color(0xFFFB3286),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,  // Underline the text
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Nama Depan
              _buildInputField(
                label: 'Nama Depan',
                placeholder: 'Masukkan Nama Depan',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              // Nama Belakang
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
              // Alamat Email
              _buildInputField(
                label: 'Alamat Email',
                placeholder: 'Masukkan Email',
                icon: Icons.email,
              ),
              const SizedBox(height: 20),
              // Nomor Telepon
              _buildInputField(
                label: 'Nomor Telepon',
                placeholder: 'Masukkan Nomor Telepon',
                icon: Icons.phone,
              ),
              const SizedBox(height: 20),
              // Save Button
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
                    // Add logic to save the edited profile
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

  // Reusable widget for each input field
  Widget _buildInputField({
    required String label,
    required String placeholder,
    required IconData icon,
  }) {
    return Center(  // Center the input field horizontally
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
                  color: Colors.white, // White background for the input fields
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
                size: 24, // Set the icon size to 24
              ),
            ),
          ],
        ),
      ),
    );
  }
}
