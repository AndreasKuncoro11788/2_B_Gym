import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Paket untuk animasi

class KelasOlahragaDetail extends StatelessWidget {
  const KelasOlahragaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),
          ..._buildKelasItems()
              .map((item) => item.animate().fade(duration: 500.ms).slide())
              .toList(),
        ],
      ),
    );
  }

  List<KelasItem> _buildKelasItems() {
    return const [
      KelasItem(
        namaKelas: 'Yoga',
        idKelas: 'YOGA856#57',
        idPemesanan: 'FG6980#',
        jadwal: 'Senin-Jumat\n06.00 - 07.00 | 08.00 - 09.00 | 10.00 - 11.00',
        icon: Icons.accessibility_new,
        backgroundColor: Colors.blueAccent,
      ),
      KelasItem(
        namaKelas: 'Boxing',
        idKelas: 'BOXING856#59',
        idPemesanan: 'FG6982#',
        jadwal: 'Senin-Jumat\n12.00 - 14.00 | 16.00 - 18.00',
        icon: Icons.fitness_center,
        backgroundColor: Colors.greenAccent,
      ),
      KelasItem(
        namaKelas: 'Pilates',
        idKelas: 'PILATES856#60',
        idPemesanan: 'FG6983#',
        jadwal: 'Senin-Jumat\n10.00 - 11.00 | 15.00 - 16.00 | 18.00 - 19.00',
        icon: Icons.pool,
        backgroundColor: Colors.orangeAccent,
      ),
      KelasItem(
        namaKelas: 'Body Combat',
        idKelas: 'BODYCOMBAT856#61',
        idPemesanan: 'FG6984#',
        jadwal: 'Senin-Jumat\n16.00 - 17.00 | 19.00 - 20.00',
        icon: Icons.directions_run,
        backgroundColor: Colors.purpleAccent,
      ),
      KelasItem(
        namaKelas: 'Zumba',
        idKelas: 'ZUMBA856#58',
        idPemesanan: 'FG6981#',
        jadwal: 'Senin-Jumat\n10.30 - 12.00 | 13.30 - 15.00 | 16.00 - 17.30',
        icon: Icons.music_note,
        backgroundColor: Colors.redAccent,
      ),
    ];
  }
}

class KelasItem extends StatelessWidget {
  final String namaKelas;
  final String idKelas;
  final String idPemesanan;
  final String jadwal;
  final IconData icon;
  final Color backgroundColor;

  const KelasItem({
    required this.namaKelas,
    required this.idKelas,
    required this.idPemesanan,
    required this.jadwal,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: backgroundColor,
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
            Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(
                icon,
                size: 40,
                color: backgroundColor,
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
                    'ID Kelas: $idKelas',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ID Pemesanan: $idPemesanan',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Jadwal: $jadwal',
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
