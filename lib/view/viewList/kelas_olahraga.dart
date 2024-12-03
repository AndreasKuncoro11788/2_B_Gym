import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/KelasOlahragaClient.dart'; // Import API client
import 'package:flutter_application_1/entity/KelasOlahraga.dart'; // Import KelasOlahraga model
import 'package:flutter_animate/flutter_animate.dart'; // Import animation package

class KelasOlahragaDetail extends StatelessWidget {
  const KelasOlahragaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<KelasOlahraga>>(
        future: KelasOlahragaClient().fetchKelasOlahraga(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No classes found.'));
          }

          final kelasList = snapshot.data!;

          return ListView.builder(
            itemCount: kelasList.length,
            itemBuilder: (context, index) {
              final kelas = kelasList[index];
              return KelasItem(
                namaKelas: kelas.namaKelas,
                jadwalKelas:
                    kelas.jadwalKelas, // Use jadwalKelas instead of jadwal
                id_alatGym: kelas.idAlatGym.toString(), // Use id_alatGym
                id_personalTrainer: kelas.idPersonalTrainer
                    .toString(), // Use id_personalTrainer
              ).animate().fade(duration: 500.ms).slide();
            },
          );
        },
      ),
    );
  }
}

class KelasItem extends StatelessWidget {
  final String namaKelas;
  final String jadwalKelas; // Updated to jadwalKelas
  final String id_alatGym; // Updated to id_alatGym
  final String id_personalTrainer; // Updated to id_personalTrainer

  const KelasItem({
    required this.namaKelas,
    required this.jadwalKelas,
    required this.id_alatGym,
    required this.id_personalTrainer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 120, // Adjust height as needed
        decoration: BoxDecoration(
          color: Colors.blueAccent, // Background color
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Styled Icon Container
            Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white, // Background color for the icon
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons
                    .fitness_center, // You can change this to any icon you prefer
                size: 40,
                color: Colors.blueAccent, // Icon color
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaKelas,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID Alat Gym: $id_alatGym', // Display id_alatGym
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ID Personal Trainer: $id_personalTrainer', // Display id_personalTrainer
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Jadwal: $jadwalKelas', // Display jadwalKelas
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
