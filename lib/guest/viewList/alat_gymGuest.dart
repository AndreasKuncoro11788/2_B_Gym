import 'package:flutter/material.dart';

class AlatGymDetailGuest extends StatelessWidget {
  const AlatGymDetailGuest({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> gymEquipments = [
      {
        "name": "Barbell",
        "id": "BARBELL856#31",
        "bookingId": "YOGA856#57",
      },
      {
        "name": "Treadmill",
        "id": "TREADMILL856#32",
        "bookingId": "YOGA856#58",
      },
      {
        "name": "Bola Gym",
        "id": "BOLAGYM856#33",
        "bookingId": "YOGA856#59",
      },
      {
        "name": "Yoga Mat",
        "id": "YOGAMAT856#34",
        "bookingId": "YOGA856#60",
      },
      {
        "name": "Punching Bag",
        "id": "PUNCHINGBAG856#35",
        "bookingId": "YOGA856#61",
      },
    ];

    IconData getEquipmentIcon(String equipmentName) {
      switch (equipmentName) {
        case 'Barbell':
          return Icons.fitness_center; 
        case 'Treadmill':
          return Icons.directions_run; 
        case 'Bola Gym':
          return Icons.sports_baseball; 
        case 'Yoga Mat':
          return Icons.self_improvement; 
        case 'Punching Bag':
          return Icons.sports_mma; 
        default:
          return Icons.help_outline; 
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: gymEquipments.length,
        itemBuilder: (context, index) {
          final equipment = gymEquipments[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            color: const Color.fromARGB(91, 224, 224, 224),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(
                getEquipmentIcon(equipment["name"]!),
                size: 40,
                color: Colors.grey[700],
              ),
              title: Text(
                equipment["name"]!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID Alat: ${equipment["id"]}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "ID Pemesanan: ${equipment["bookingId"]}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
