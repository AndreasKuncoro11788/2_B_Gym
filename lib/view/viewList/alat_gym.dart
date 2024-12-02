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
                ...snapshot.data!
                    .map((item) => Card(
                          child: ListTile(
                            title: Text(
                                item.namaAlat), // Hanya menampilkan nama alat
                            subtitle: Text(
                                'Harga: ${item.harga}'), // Menampilkan harga
                          ),
                        ))
                    .toList(),
              ],
            ),
          );
        }
      },
    );
  }
}
