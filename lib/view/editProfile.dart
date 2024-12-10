  import 'package:flutter/material.dart';
  import 'package:flutter_application_1/component/form_component.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:flutter_application_1/client/PenggunaClient.dart';
  import 'package:flutter_application_1/entity/Pengguna.dart';
  import 'dart:io';

  final profileProvider = FutureProvider<Pengguna>((ref) async {
    return await Penggunaclient.fetchCurrentUser();
  });

  class Editprofile extends ConsumerStatefulWidget {
    const Editprofile({Key? key}) : super(key: key);

    @override
    ConsumerState<Editprofile> createState() => _EditProfileState();
  }

  class _EditProfileState extends ConsumerState<Editprofile> {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController nomorIdentitasController = TextEditingController();
    final TextEditingController genderController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    @override
    void dispose() {
      nameController.dispose();
      nomorIdentitasController.dispose();
      genderController.dispose();
      ageController.dispose();
      emailController.dispose();
      phoneController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      final profileData = ref.watch(profileProvider);

      return Scaffold(
        backgroundColor: const Color(0xFFEFEFEF),
        appBar: AppBar(
          title: const Text(
            "Edit Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: profileData.when(
          data: (pengguna) {
            return _buildForm(pengguna);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $error'),
                ElevatedButton(
                  onPressed: () => ref.refresh(profileProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildForm(Pengguna pengguna) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFD9D9D9),
                    backgroundImage: (pengguna.fotoProfil != null && pengguna.fotoProfil.isNotEmpty)
                        ? FileImage(File(pengguna.fotoProfil)) // Gunakan foto lokal
                        : null as ImageProvider, // Gunakan foto default
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => print('Upload new profile picture clicked'),
                    child: const Text(
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

            inputForm(
              (value) => value!.isEmpty ? 'Nama Pengguna tidak boleh kosong' : null,
              controller: nameController,
              hintTxt: 'Masukkan Nama Pengguna',
              helperTxt: 'Masukkan Nama Pengguna Anda',
              iconData: Icons.person,
            ),
            const SizedBox(height: 20),

            inputForm(
              (value) => value!.isEmpty ? 'Nomor Identitas tidak boleh kosong' : null,
              controller: nomorIdentitasController,
              hintTxt: 'Masukkan Nomor ID',
              helperTxt: 'Masukkan Nomor ID Anda',
              iconData: Icons.credit_card,
            ),
            const SizedBox(height: 20),

            inputForm(
              (value) => value!.isEmpty ? 'Jenis Kelamin tidak boleh kosong' : null,
              controller: genderController,
              hintTxt: 'Masukkan Jenis Kelamin',
              helperTxt: 'Masukkan Jenis Kelamin Anda',
              iconData: Icons.transgender,
            ),
            const SizedBox(height: 20),

            inputForm(
              (value) => value!.isEmpty ? 'Umur tidak boleh kosong' : null,
              controller: ageController,
              hintTxt: 'Masukkan Umur',
              helperTxt: 'Masukkan Umur Anda',
              iconData: Icons.calendar_today,
            ),
            const SizedBox(height: 20),

            inputForm(
              (value) => value!.isEmpty ? 'Alamat Email tidak boleh kosong' : null,
              controller: emailController,
              hintTxt: 'Masukkan Email',
              helperTxt: 'Masukkan Alamat Email Anda',
              iconData: Icons.email,
            ),
            const SizedBox(height: 20),

            inputForm(
              (value) => value!.isEmpty ? 'Nomor Telepon tidak boleh kosong' : null,
              controller: phoneController,
              hintTxt: 'Masukkan Nomor Telepon',
              helperTxt: 'Masukkan Nomor Telepon Anda',
              iconData: Icons.phone,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFB3286),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                try {
                  final updatedUser = Pengguna(
                    id: pengguna.id,
                    namaPengguna: nameController.text,
                    nomorIdentitas: nomorIdentitasController.text,
                    jenisKelamin: genderController.text,
                    umur: ageController.text,
                    email: emailController.text,
                    nomorTelepon: phoneController.text,kataSandi: pengguna.kataSandi, 
                    fotoProfil: pengguna.fotoProfil,
                  );

                  await Penggunaclient.update(updatedUser);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profil berhasil diperbarui')),
                  );

                  ref.refresh(profileProvider);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
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
          ],
        ),
      );
    }
  }
