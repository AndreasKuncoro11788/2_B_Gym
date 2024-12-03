import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/login.dart';
import 'package:flutter_application_1/component/form_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> saveUserData(Map<String, dynamic> formData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = '${firstNameController.text}${lastNameController.text}'.toLowerCase();
  await prefs.setString('username', username);
  await prefs.setString('password', formData['password']);
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

                    // Nama Pengguna
                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Pengguna tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: firstNameController,
                      hintTxt: 'Nama Pengguna',
                      helperTxt: 'Masukkan Nama Pengguna',
                      iconData: Icons.person,
                    ),

                    // Nomor Identitas
                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor Identitas tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: idController,
                      hintTxt: 'Nomor Identitas (KTP / SIM)',
                      helperTxt: 'Masukkan Nomor Identitas',
                      iconData: Icons.credit_card,
                    ),

                    // Jenis Kelamin
                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jenis Kelamin tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: genderController,
                      hintTxt: 'Jenis Kelamin',
                      helperTxt: 'Masukkan Jenis Kelamin',
                      iconData: Icons.transgender,
                    ),

                    // Alamat Email
                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: emailController,
                      hintTxt: 'Alamat Email',
                      helperTxt: 'Masukkan Alamat Email',
                      iconData: Icons.email,
                    ),
                    
                    // Umur
                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Umur tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: ageController,
                      hintTxt: 'Umur',
                      helperTxt: 'Masukkan Umur',
                      iconData: Icons.calendar_today,
                    ),

                    // Kata Sandi
                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kata Sandi tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: passwordController,
                      hintTxt: 'Kata Sandi',
                      helperTxt: 'Masukkan Kata Sandi',
                      iconData: Icons.lock,
                      password: true,
                    ),

                    // Konfirmasi Kata Sandi
                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi Kata Sandi tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: confirmPasswordController,
                      hintTxt: 'Konfirmasi Kata Sandi',
                      helperTxt: 'Masukkan Konfirmasi Kata Sandi',
                      iconData: Icons.lock,
                      password: true,
                    ),

                    // Nomor Telepon
                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor Telepon tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: phoneController,
                      hintTxt: 'Nomor Telepon',
                      helperTxt: 'Masukkan Nomor Telepon',
                      iconData: Icons.phone,
                    ),


                    const SizedBox(height: 16),

                    // Tombol Daftar
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
                          Map<String, dynamic> formData = {
                            'username': emailController.text,
                            'password': passwordController.text,
                          };

                          await saveUserData(formData);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginView(data: formData),
                            ),
                          );
                        }
                      },
                      child: const Text('Daftar'),
                    ),

                    const SizedBox(height: 16),

                    // Tautan ke Login
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