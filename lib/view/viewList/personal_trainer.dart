import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Paket untuk animasi

class PersonalTrainerDetail extends StatelessWidget {
  const PersonalTrainerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),
          ..._buildTrainerCards()
              .map((item) => item.animate().fade(duration: 500.ms).slide())
              .toList(),
        ],
      ),
    );
  }

  List<Widget> _buildTrainerCards() {
    return const [
      TrainerCard(
        trainerName: 'Agus',
        trainerType: 'Yoga',
        identityNumber: '1234567',
        orderId: 'YOGA856#57',
        backgroundColor: Colors.lightGreen,
      ),
      TrainerCard(
        trainerName: 'Deven',
        trainerType: 'Pilates',
        identityNumber: '4567890',
        orderId: 'PILATES856#60',
        backgroundColor: Colors.pinkAccent,
      ),
      TrainerCard(
        trainerName: 'Charlie',
        trainerType: 'Boxing',
        identityNumber: '3456789',
        orderId: 'BOXING856#59',
        backgroundColor: Colors.redAccent,
      ),
      TrainerCard(
        trainerName: 'Bowo',
        trainerType: 'Zumba',
        identityNumber: '2345678',
        orderId: 'ZUMBA856#58',
        backgroundColor: Colors.orangeAccent,
      ),
      TrainerCard(
        trainerName: 'Evan',
        trainerType: 'Body Combat',
        identityNumber: '5678901',
        orderId: 'BODYCOMBAT856#61',
        backgroundColor: Colors.blueAccent,
      ),
    ].map((card) {
      return Container(
        width: 400, // Set the desired width here
        margin: const EdgeInsets.only(left: 6.5), // Set the left margin here
        child: card,
      );
    }).toList();
  }
}

class TrainerCard extends StatelessWidget {
  final String trainerName;
  final String trainerType;
  final String identityNumber;
  final String orderId;
  final Color backgroundColor;

  const TrainerCard({
    required this.trainerName,
    required this.trainerType,
    required this.identityNumber,
    required this.orderId,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                      _getImageByType(trainerType)), // Memuat gambar dari aset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trainerName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Trainer: $trainerType',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'ID pemesanan: $orderId',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Nomor identitas: $identityNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getImageByType(String type) {
    switch (type.toLowerCase()) {
      case 'yoga':
        return 'lib/assets/yoga_trainer.png';
      case 'pilates':
        return 'lib/assets/pilates_trainer.jpg';
      case 'boxing':
        return 'lib/assets/boxing_trainer.jpg';
      case 'zumba':
        return 'lib/assets/zumba_trainer.jpg';
      case 'body combat':
        return 'lib/assets/body_combat_trainer.jpg';
      default:
        return 'lib/assets/default_trainer.jpg'; // Gambar default jika tidak ada yang cocok
    }
  }
}
