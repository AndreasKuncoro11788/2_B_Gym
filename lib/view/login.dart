import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home.dart';
import 'package:flutter_application_1/view/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> checkLogin(String username, String password) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');
    if (savedUsername == username && savedPassword == password) {
      return true;
    }
  } catch (e) {
    print("Error checking login: $e");
  }
  return false;
}


  Future<bool> checkUsernameExists(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    return savedUsername == username;
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
                    // Username Field
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Nama Pengguna",
                        hintText: "Masukkan pengguna terdaftar",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nama Pengguna tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Kata sandi",
                        hintText: "Masukkan kata sandi",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Kata sandi tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
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
                    TextButton(
                      onPressed: () {
                        pushRegister(context);
                      },
                      child: const Text(
                        'Belum punya akun?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        showForgotPasswordDialog(context);
                      },
                      child: const Text(
                        'Lupa kata sandi?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterView()),
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
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showForgotPasswordDialog(BuildContext context) {
    final usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Lupa Kata Sandi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Masukkan username Anda untuk menerima kode verifikasi.'),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Masukkan username yang terdaftar',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              bool usernameExists = await checkUsernameExists(usernameController.text);
              if (usernameExists) {
                Navigator.pop(context); // Close dialog
                // Simulasi pengiriman kode OTP
                sendOTP(usernameController.text);
              } else {
                showErrorDialog("Akun tidak terdaftar atau username salah.");
              }
            },
            child: const Text('Kirim Kode OTP'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void sendOTP(String username) {
    // Simulasi pengiriman OTP, sebenarnya ini bisa dilakukan lewat server
    String otpCode = "123456";  // Anda bisa menggunakan metode lebih aman di backend.
    showOTPDialog(otpCode);
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showOTPDialog(String otpCode) {
    final otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Masukkan Kode OTP'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Kode OTP telah dikirim ke email Anda. Kode: $otpCode'),
            TextFormField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'Kode OTP',
                hintText: 'Masukkan kode OTP',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (otpController.text == otpCode) {
                Navigator.pop(context);  // Close OTP dialog
                // Tampilkan dialog untuk mengganti kata sandi
                showResetPasswordDialog();
              } else {
                // Kode OTP salah
                showErrorDialog("Kode OTP salah");
              }
            },
            child: const Text('Verifikasi'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void showResetPasswordDialog() {
  final newPasswordController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Ganti Kata Sandi'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Masukkan kata sandi baru.'),
          TextFormField(
            controller: newPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Kata Sandi Baru',
              hintText: 'Masukkan kata sandi baru',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.pink),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            String newPassword = newPasswordController.text;
            // Simpan kata sandi baru ke SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('password', newPassword);  // Simpan password baru

            Navigator.pop(context);
            // Informasikan kepada pengguna bahwa kata sandi berhasil diubah
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Kata Sandi Berhasil Diubah'),
                content: const Text('Kata sandi Anda telah berhasil diubah.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Ganti Kata Sandi'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
      ],
    ),
  );
}
}
