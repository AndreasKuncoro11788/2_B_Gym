import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home.dart';
import 'package:flutter_application_1/view/register.dart';
import 'package:flutter_application_1/component/form_component.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart'; // Import local_auth

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication(); // Inisialisasi LocalAuthentication

  Future<bool> checkLogin(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');
    return savedUsername == username && savedPassword == password;
  }

  Future<bool> isBiometricSupported() async {
    return await auth.canCheckBiometrics;
  }

  Future<void> authenticateWithFingerprint() async {
    bool isSupported = await isBiometricSupported();
    if (!isSupported) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Biometrik Tidak Didukung'),
          content: const Text('Perangkat ini tidak mendukung autentikasi sidik jari.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

  try {
    bool authenticated = await auth.authenticate(
      localizedReason: 'Silakan autentikasi menggunakan sidik jari',
      options: const AuthenticationOptions(
        useErrorDialogs: true,
        stickyAuth: true,
      ),
    );

    if (authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
    }
  } catch (e) {
    print(e); // Tangani kesalahan jika diperlukan
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                    
                    // Menggunakan inputForm dari form_component.dart
                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Pengguna tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: usernameController,
                      hintTxt: 'Nama Pengguna',
                      helperTxt: 'Masukkan pengguna terdaftar',
                      iconData: Icons.person,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    inputForm(
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kata Sandi tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: passwordController,
                      hintTxt: 'Kata Sandi',
                      helperTxt: 'Masukkan kata sandi',
                      iconData: Icons.lock,
                      password: true, // Untuk menyembunyikan teks
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
                        if (formKey.currentState!.validate()) {
                          bool isValid = await checkLogin(
                            usernameController.text,
                            passwordController.text,
                          );
                          if (isValid) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const HomeView()),
                            );
                          } else {
                            showLoginErrorDialog(context);
                          }
                        }
                      },
                      child: const Text('Masuk'),
                    ),
                    
                    const SizedBox(height: 20),

                    // Logo fingerprint
                    GestureDetector(
                      onTap: authenticateWithFingerprint, // Panggil fungsi autentikasi saat ditekan
                      child: Column(
                        children: [
                          Icon(
                            Icons.fingerprint,
                            size: 50,
                            color: Colors.pink,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Login dengan Sidik Jari',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterView()),
                        );
                      },
                      child: const Text(
                        'Belum punya akun?',
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

  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Kata Sandi Salah'),
        content: const Text('Nama pengguna atau kata sandi salah.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
