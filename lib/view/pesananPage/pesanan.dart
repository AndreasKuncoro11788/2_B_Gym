import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/KelasOlahragaClient.dart';
import 'package:flutter_application_1/client/PersonalTrainerClient.dart';
import 'package:flutter_application_1/client/AlatGymClient.dart';
import 'package:flutter_application_1/client/PenggunaClient.dart';
import 'package:flutter_application_1/entity/KelasOlahraga.dart';
import 'package:flutter_application_1/entity/PersonalTrainer.dart';
import 'package:flutter_application_1/entity/AlatGym.dart';
import 'package:flutter_application_1/entity/Pengguna.dart';
import 'package:flutter_application_1/view/pembayaranPage/pembayaran.dart';
import 'package:flutter_application_1/entity/DataPemesanan.dart';
import 'package:flutter_application_1/client/DataPemesananClient.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({super.key});

  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  final KelasOlahragaClient kelasClient = KelasOlahragaClient();
  final PersonalTrainerClient trainerClient = PersonalTrainerClient();
  final AlatGymClient alatClient = AlatGymClient();

  late Future<List<KelasOlahraga>> kelasList;
  late Future<List<PersonalTrainer>> trainerList;
  late Future<List<AlatGym>> alatGymList;

  KelasOlahraga? selectedKelas;
  PersonalTrainer? selectedTrainer;
  AlatGym? selectedAlat;
  String? selectedJadwal;
  String? namaPengguna; 
  int? idPengguna;
  Pengguna? pengguna; 

  @override
  void initState() {
    super.initState();
    kelasList = kelasClient.fetchKelasOlahraga();
    trainerList = trainerClient.fetchPersonalTrainers();
    alatGymList = alatClient.fetchAlatGym();
    fetchUserData(); 
  }

  Future<void> fetchUserData() async {
    try {
      pengguna =
          await Penggunaclient.fetchCurrentUser(); 
      setState(() {
        if (pengguna != null) {
          idPengguna = pengguna!.id; 
          namaPengguna = pengguna!.namaPengguna;
        } else {
          idPengguna = null;
          namaPengguna = null; 
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User data is not available.')),
          );
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user data: $e')),
      );
    }
  }

  Future<void> saveData() async {
    if (selectedKelas == null ||
        selectedJadwal == null ||
        idPengguna == null ||
        selectedTrainer == null ||
        selectedAlat == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    DataPemesanan newPemesanan = DataPemesanan(
      id: 0, 
      namaPengguna: namaPengguna ?? 'Unknown User',
      namaKelas: selectedKelas!.namaKelas,
      namaTrainer: selectedTrainer!.namaTrainer,
      namaAlat: selectedAlat!.namaAlat,
      jadwalKelas: selectedJadwal!,
      status: 'on going',
      id_pengguna: idPengguna!,
      id_kelasOlahraga: selectedKelas!.id,
      id_personalTrainer: selectedTrainer!.id,
      id_alatGym: selectedAlat!.alatId,
    );

    try {
      
      DataPemesanan createdPemesanan =
          await DataPemesananClient.createDataPemesanan(newPemesanan);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Pembayaran(
            jenisKelas: selectedKelas!.namaKelas,
            namaTrainer: selectedTrainer!.namaTrainer,
            alatGym: selectedAlat!.namaAlat,
            jadwalKelas: selectedJadwal!,
            hargaAlatGym: selectedAlat!.harga, 
            hargaKelas: selectedKelas!.hargaKelas, 
            idPemesanan:
                createdPemesanan.id, 
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesanan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.pink,
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Nama Pengguna',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (value) {
                    namaPengguna = value; 
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    hintText: 'Masukkan nama pengguna',
                    prefixIcon: const Icon(Icons.person, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Kelas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<KelasOlahraga>>(
                  future: kelasList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return DropdownButtonFormField<KelasOlahraga>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          prefixIcon: const Icon(Icons.fitness_center,
                              color: Colors.black),
                        ),
                        items: snapshot.data!.map((KelasOlahraga kelas) {
                          return DropdownMenuItem<KelasOlahraga>(
                            value: kelas,
                            child: Text(kelas.namaKelas),
                          );
                        }).toList(),
                        onChanged: (KelasOlahraga? newValue) {
                          setState(() {
                            selectedKelas = newValue; 
                            selectedJadwal = newValue
                                ?.jadwalKelas; 
                          });
                        },
                        hint: const Text('Pilih kelas'),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Trainer',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<PersonalTrainer>>(
                  future: trainerList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return DropdownButtonFormField<PersonalTrainer>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          prefixIcon:
                              const Icon(Icons.person_pin, color: Colors.black),
                        ),
                        items: snapshot.data!.map((PersonalTrainer trainer) {
                          return DropdownMenuItem<PersonalTrainer>(
                            value: trainer,
                            child: Text(trainer.namaTrainer),
                          );
                        }).toList(),
                        onChanged: (PersonalTrainer? newValue) {
                          setState(() {
                            selectedTrainer =
                                newValue; 
                          });
                        },
                        hint: const Text('Pilih trainer'),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Alat Gym',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<AlatGym>>(
                  future: alatGymList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return DropdownButtonFormField<AlatGym>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          prefixIcon: const Icon(Icons.sports_gymnastics,
                              color: Colors.black),
                        ),
                        items: snapshot.data!.map((AlatGym alat) {
                          return DropdownMenuItem<AlatGym>(
                            value: alat,
                            child: Text(alat.namaAlat),
                          );
                        }).toList(),
                        onChanged: (AlatGym? newValue) {
                          setState(() {
                            selectedAlat =
                                newValue; 
                          });
                        },
                        hint: const Text('Pilih alat gym'),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Jadwal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    prefixIcon: const Icon(Icons.schedule, color: Colors.black),
                  ),
                  value: selectedJadwal,
                  items: selectedKelas != null
                      ? [selectedKelas!.jadwalKelas].map((String jadwal) {
                          return DropdownMenuItem<String>(
                            value: jadwal,
                            child: Text(jadwal),
                          );
                        }).toList()
                      : [],
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedJadwal = newValue; 
                    });
                  },
                  hint: const Text('Pilih jadwal'),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      saveData(); 
                    },
                    child: const Text(
                      'Pesan Sekarang',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
