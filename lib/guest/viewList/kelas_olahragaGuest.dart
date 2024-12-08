import 'package:flutter/material.dart';

class KelasOlahragaDetailGuest extends StatelessWidget {
  const KelasOlahragaDetailGuest({super.key});

  final List<Map<String, dynamic>> kelasData = const [
    {
      "name": "Yoga",
      "idKelas": "YOGA856#57",
      "idPemesan": "FG6980#",
      "jadwal": ["06.00 - 07.00", "08.00 - 09.00", "10.00 - 11.00"],
    },
    {
      "name": "Zumba",
      "idKelas": "ZUMBA856#58",
      "idPemesan": "FG6981#",
      "jadwal": ["10.30 - 12.00", "13.30 - 15.00", "16.00 - 17.30"],
    },
    {
      "name": "Boxing",
      "idKelas": "BOXING856#59",
      "idPemesan": "FG6982#",
      "jadwal": ["12.00 - 14.00", "16.00 - 18.00"],
    },
    {
      "name": "Pilates",
      "idKelas": "PILATES856#60",
      "idPemesan": "FG6983#",
      "jadwal": ["10.00 - 11.00", "15.00 - 16.00", "18.00 - 19.00"],
    },
    {
      "name": "Body Combat",
      "idKelas": "BODYCOMBAT856#61",
      "idPemesan": "FG6984#",
      "jadwal": ["16.00 - 17.00", "19.00 - 20.00"],
    },
  ];

  IconData getClassIcon(String className) {
    switch (className) {
      case 'Yoga':
        return Icons.self_improvement; 
      case 'Zumba':
        return Icons.music_note; 
      case 'Boxing':
        return Icons.sports_mma; 
      case 'Pilates':
        return Icons.sports_gymnastics; 
      case 'Body Combat':
        return Icons.fitness_center; 
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: kelasData.length,
        itemBuilder: (context, index) {
          final kelas = kelasData[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: const Color.fromARGB(91, 224, 224, 224),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12.0),
              leading: Icon(
                getClassIcon(kelas['name']),
                size: 40,
                color: Colors.pink,
              ),
              title: Text(
                kelas['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text("ID Kelas: ${kelas['idKelas']}"),
                  Text("ID Pemesanan: ${kelas['idPemesan']}"),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: kelas['jadwal']
                        .map<Widget>((jadwal) => Chip(
                              label: Text(jadwal),
                            ))
                        .toList(),
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
