import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/login.dart';
import 'package:flutter_application_1/component/form_component.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController namaDepanController = TextEditingController();
  TextEditingController namaBelakangController = TextEditingController();
  TextEditingController nomorIdentitasController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController umurController = TextEditingController();
  TextEditingController alamatEmailController = TextEditingController();
  TextEditingController kataSandiController = TextEditingController();
  TextEditingController konfirmasiKataSandiController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: namaDepanController,
                    hintTxt: 'Nama Depan',
                    helperTxt: '',
                    iconData: Icons.person),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: namaBelakangController,
                    hintTxt: 'Nama Belakang',
                    helperTxt: '',
                    iconData: Icons.person),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: nomorIdentitasController,
                    hintTxt: 'ID Number',
                    helperTxt: 'ktp/sim',
                    iconData: Icons.card_membership),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: umurController,
                    hintTxt: 'Umur',
                    helperTxt: '',
                    iconData: Icons.view_agenda),  
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'tidak boleh kosong';
                      }

                      return null;
                    },
                    controller: alamatEmailController,
                    hintTxt: 'Alamat Online',
                    helperTxt: '@gmail.com',
                    iconData: Icons.email),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (p0.length < 8) {
                        return 'Min. 8 digit';
                      }
                      return null;
                    },
                    controller: kataSandiController,
                    hintTxt: 'Kata Sandi',
                    helperTxt: '12345678',
                    iconData: Icons.password,
                    password: true),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Confirm password cannot be empty';
                      }
                      if (p0 != kataSandiController.text) {
                        return 'Wrong Password';
                      }
                      return null;
                    },
                    controller: konfirmasiKataSandiController,
                    hintTxt: 'Konfirmasi Kata Sandi',
                    helperTxt: '12345678',
                    iconData: Icons.password,
                    password: true),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: nomorTeleponController,
                    hintTxt: 'Phone',
                    helperTxt: '08211223344',
                    iconData: Icons.phone_android),
                  

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> formData = {};
                        formData['namaDepan'] = namaDepanController.text;
                        formData['namaBelakang'] = namaBelakangController.text;
                        formData['nomorIdentitas'] = nomorIdentitasController.text;
                        formData['jenisKelamin'] = jenisKelaminController.text;
                        formData['umur'] = umurController.text;
                        formData['alamatEmail'] = alamatEmailController.text;
                        formData['kataSandi'] = kataSandiController.text;
                        formData['konfirmasiKataSandi'] = konfirmasiKataSandiController.text;
                        formData['nomorTelepon'] = nomorTeleponController.text;

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

                  ElevatedButton(
                    onPressed: () {          
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginView(),
                        ),
                      );
                    },
                    child: const Text('Sudah punya akun? Kembali ke Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
