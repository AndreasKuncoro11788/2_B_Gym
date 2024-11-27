import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Paket untuk animasi

class AlatGymDetail extends StatelessWidget {
  const AlatGymDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),
          ..._buildGymItems()
              .map((item) => item.animate().fade(duration: 500.ms).slide())
              .toList(),
        ],
      ),
    );
  }

  List<GymItem> _buildGymItems() {
    return const [
      GymItem(
        alatId: 'BARBELL856#31',
        pemesananId: 'YOGA856#57',
        icon: Icons.fitness_center,
        title: 'Barbell',
        backgroundColor: Colors.blueAccent,
      ),
      GymItem(
        alatId: 'TREADMILL856#32',
        pemesananId: 'YOGA856#58',
        icon: Icons.directions_run,
        title: 'Treadmill',
        backgroundColor: Colors.greenAccent,
      ),
      GymItem(
        alatId: 'BOLAGYM856#33',
        pemesananId: 'YOGA856#59',
        icon: Icons.accessibility,
        title: 'Bola Gym',
        backgroundColor: Colors.orangeAccent,
      ),
      GymItem(
        alatId: 'YOGAMAT856#34',
        pemesananId: 'YOGA856#60',
        icon: Icons.border_all,
        title: 'Yoga Mat',
        backgroundColor: Colors.purpleAccent,
      ),
      GymItem(
        alatId: 'PUNCHINGBAG856#35',
        pemesananId: 'YOGA856#61',
        icon: Icons.sports_martial_arts,
        title: 'Punching Bag',
        backgroundColor: Colors.redAccent,
      ),
    ];
  }
}

class GymItem extends StatelessWidget {
  final String alatId;
  final String pemesananId;
  final IconData icon;
  final String title;
  final Color backgroundColor;

  const GymItem({
    required this.alatId,
    required this.pemesananId,
    required this.icon,
    required this.title,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 100,
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
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID Alat: $alatId',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ID Pemesanan: $pemesananId',
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
