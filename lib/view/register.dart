import 'dart:io';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/login.dart';
import 'package:flutter_application_1/component/form_component.dart';
import 'package:flutter_application_1/entity/Pengguna.dart';
import 'package:flutter_application_1/client/PenggunaClient.dart';

class RegisterView extends StatefulWidget {
  final Map? data;
  const RegisterView({super.key, this.data});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();
  TextEditingController _nomorIdentitasController = TextEditingController();
  TextEditingController _jenisKelaminController = TextEditingController();
  TextEditingController _umurController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _kataSandiController = TextEditingController();
  TextEditingController _confirmKataSandiController = TextEditingController();
  TextEditingController _nomorTeleponController = TextEditingController();

  File? _fotoProfil;

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
      umur: _umurController.text,
      kataSandi: _kataSandiController.text,
      nomorTelepon: _nomorTeleponController.text,
      fotoProfil: _fotoProfil?.path ?? 'https://default-profile-url.com/default.jpg',

    );

    try {
      await Penggunaclient.create(pengguna);

      Fluttertoast.showToast(
        msg: "Register berhasil!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 175, 76, 135),
        textColor: Colors.white,
        fontSize: 16.0,
      );


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginView(),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Register gagal: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    }
  }

  Future<void> _takePicture() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: firstCamera),
      ),
    );

    if (result != null && result is File) {
      setState(() {
        _fotoProfil = result;
      });
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

                    GestureDetector(
                      onTap: _takePicture,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage:
                            _fotoProfil != null ? FileImage(_fotoProfil!) : null,
                        child: _fotoProfil == null
                            ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),

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

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({super.key, required this.camera});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      Navigator.pop(context, File(image.path));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ambil Foto')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}