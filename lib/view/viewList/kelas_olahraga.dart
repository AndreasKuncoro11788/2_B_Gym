import 'package:flutter/material.dart';

class KelasOlahragaDetail extends StatelessWidget {
  const KelasOlahragaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildKelasItem(
            'Yoga',
            'FG6980#',
            'YOGA856#57',
            'Senin-Jumat\n06.00 - 07.00 | 08.00 - 09.00 | 10.00 - 11.00',
            Icons.accessibility_new),
        _buildKelasItem('Boxing', 'FG6982#', 'BOXING856#59',
            'Senin-Jumat\n12.00 - 14.00 | 16.00 - 18.00', Icons.fitness_center),
        _buildKelasItem(
            'Pilates',
            'FG6983#',
            'PILATES856#60',
            'Senin-Jumat\n10.00 - 11.00 | 15.00 - 16.00 | 18.00 - 19.00',
            Icons.pool),
        _buildKelasItem('Body Combat', 'FG6984#', 'BODYCOMBAT856#61',
            'Senin-Jumat\n16.00 - 17.00 | 19.00 - 20.00', Icons.directions_run),
        _buildKelasItem(
            'Zumba',
            'FG6981#',
            'ZUMBA856#58',
            'Senin-Jumat\n10.30 - 12.00 | 13.30 - 15.00 | 16.00 - 17.30',
            Icons.music_note),
      ],
    );
  }

  Widget _buildKelasItem(String namaKelas, String idPemesanan, String idKelas,
      String jadwal, IconData icon) {
    return Container(
      width: 400,
      height: 108,
      margin: const EdgeInsets.only(bottom: 8, left: 6, top: 10),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 400,
              height: 108,
              decoration: ShapeDecoration(
                color: const Color(0xFFBBBBBB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 32,
            child: Icon(
              icon,
              color: Colors.black,
              size: 24,
            ),
          ),
          Positioned(
            left: 54,
            top: 11,
            child: Text(
              namaKelas,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 54,
            top: 33,
            child: Text(
              'ID Kelas: $idKelas',
              style: const TextStyle(
                color: Color(0xFF696969),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 54,
            top: 63,
            child: Text(
              'Jadwal: $jadwal',
              style: const TextStyle(
                color: Color(0xFF696969),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 54,
            top: 48,
            child: Text(
              'ID pemesanan: $idPemesanan',
              style: const TextStyle(
                color: Color(0xFF696969),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
