import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/login.dart';
import 'package:flutter_application_1/component/form_component.dart';
import 'package:flutter_application_1/entity/Pengguna.dart';
import 'package:flutter_application_1/client/PenggunaClient.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _nomorIdentitasController = TextEditingController();
  final _jenisKelaminController = TextEditingController();
  final _umurController = TextEditingController();
  final _emailController = TextEditingController();
  final _kataSandiController = TextEditingController();
  final _confirmKataSandiController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  
  final _fotoProfileController = TextEditingController(text: 'https://media.istockphoto.com/id/1495088043/id/vektor/ikon-profil-pengguna-avatar-atau-ikon-orang-gambar-profil-simbol-potret-gambar-potret.jpg?s=612x612&w=0&k=20&c=vMnxIgiQh5EFyQrFGGNKtbb6tuGCT04L58nwwEGzIbc');

  Future<void> _registerUser() async {
    if (_kataSandiController.text != _confirmKataSandiController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kata sandi tidak cocok!')),
      );
      return;
    }

      Pengguna pengguna = Pengguna(
        namaPengguna: _namaController.text,
        nomorIdentitas: _nomorIdentitasController.text,
        jenisKelamin: _jenisKelaminController.text,
        email: _emailController.text,
        umur: int.parse(_umurController.text).toString(),
        kataSandi: _kataSandiController.text,
        nomorTelepon: _nomorTeleponController.text,
        fotoProfile: _fotoProfileController.text,
      );


    try {
      await Penggunaclient.create(pengguna);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran berhasil!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginView(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pendaftaran gagal: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "ATMAGYM",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      "FITNESS CENTER",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    const SizedBox(height: 40),

                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Pengguna tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _namaController,
                      hintTxt: 'Nama Pengguna',
                      helperTxt: 'Masukkan Nama Pengguna',
                      iconData: Icons.person,
                    ),

                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor Identitas tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _nomorIdentitasController,
                      hintTxt: 'Nomor Identitas (KTP / SIM)',
                      helperTxt: 'Masukkan Nomor Identitas',
                      iconData: Icons.credit_card,
                    ),

                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jenis Kelamin tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _jenisKelaminController,
                      hintTxt: 'Jenis Kelamin',
                      helperTxt: 'Masukkan Jenis Kelamin',
                      iconData: Icons.transgender,
                    ),

                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _emailController,
                      hintTxt: 'Alamat Email',
                      helperTxt: 'Masukkan Alamat Email',
                      iconData: Icons.email,
                    ),

                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Umur tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _umurController,
                      hintTxt: 'Umur',
                      helperTxt: 'Masukkan Umur',
                      iconData: Icons.calendar_today,
                    ),

                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kata Sandi tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _kataSandiController,
                      hintTxt: 'Kata Sandi',
                      helperTxt: 'Masukkan Kata Sandi',
                      iconData: Icons.lock,
                      password: true,
                    ),

                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi Kata Sandi tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _confirmKataSandiController,
                      hintTxt: 'Konfirmasi Kata Sandi',
                      helperTxt: 'Masukkan Konfirmasi Kata Sandi',
                      iconData: Icons.lock,
                      password: true,
                    ),

                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor Telepon tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _nomorTeleponController,
                      hintTxt: 'Nomor Telepon',
                      helperTxt: 'Masukkan Nomor Telepon',
                      iconData: Icons.phone,
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _registerUser();
                        }
                      },
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginView(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sudah punya akun? Kembali ke Login',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
