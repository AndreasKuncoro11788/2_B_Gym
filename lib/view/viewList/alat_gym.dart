import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/alatGymClient.dart';
import 'package:flutter_application_1/entity/AlatGym.dart';

class AlatGymDetail extends StatefulWidget {
  const AlatGymDetail({super.key});

  @override
  _AlatGymDetailState createState() => _AlatGymDetailState();
}

class _AlatGymDetailState extends State<AlatGymDetail> {
  late Future<List<AlatGym>> futureAlatGym;

  @override
  void initState() {
    super.initState();
    futureAlatGym = AlatGymClient().fetchAlatGym();
  }

  IconData _getIconForAlat(String namaAlat) {
    switch (namaAlat) {
      case 'Barbell':
        return Icons.fitness_center;
      case 'Treadmill':
        return Icons.directions_run;
      case 'Bola Gym':
        return Icons.accessibility;
      case 'Yoga Mat':
        return Icons.border_all;
      case 'Punching Bag':
        return Icons.sports_martial_arts;
      default:
        return Icons.fitness_center; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlatGym>>(
      future: futureAlatGym,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                ...snapshot.data!.map((item) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        leading: Icon(
                          _getIconForAlat(item.namaAlat),
                          size: 40,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          item.namaAlat,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          'Harga: Rp ${item.harga}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          // Tambahkan aksi saat item ditekan jika diperlukan
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Anda memilih ${item.namaAlat}')),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        }
      },
    );
  }
}
