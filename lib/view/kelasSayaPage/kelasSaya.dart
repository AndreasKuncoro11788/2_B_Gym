import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/kelasSayaPage/refund.dart';

class KelasSayaPage extends StatelessWidget {
  const KelasSayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> kelasData = [
      {
        'namaKelas': 'Kelas Yoga',
        'trainer': 'Trainer A',
        'alatGym': 'Matras Yoga',
        'jadwal': 'Pagi'
      },
      {
        'namaKelas': 'Kelas Pilates',
        'trainer': 'Trainer B',
        'alatGym': 'Reformer',
        'jadwal': 'Siang'
      },
      {
        'namaKelas': 'Kelas Zumba',
        'trainer': 'Trainer C',
        'alatGym': 'Dumbbell',
        'jadwal': 'Sore'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelas Saya',
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
              Icons.arrow_back,
              color: Colors.pink,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: kelasData.length,
          itemBuilder: (context, index) {
            final kelas = kelasData[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Nomor di sebelah kiri
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Informasi Kelas
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kelas['namaKelas']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Trainer: ${kelas['trainer']}'),
                          const SizedBox(height: 4),
                          Text('Alat Gym: ${kelas['alatGym']}'),
                          const SizedBox(height: 4),
                          Text('Jadwal: ${kelas['jadwal']}'),
                        ],
                      ),
                    ),
                    // Tombol "Lihat Detail" dan "Batalkan"
                    Column(
                      children: [
                        SizedBox(
                          width: 100, // Menyamakan lebar tombol
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RefundPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Lihat Detail',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12, // Ukuran teks lebih kecil
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 100, // Menyamakan lebar tombol
                          child: OutlinedButton(
                            onPressed: () {
                              // Aksi untuk membatalkan
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.pink,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: const BorderSide(color: Colors.pink),
                            ),
                            child: const Text(
                              'Batalkan',
                              style: TextStyle(
                                fontSize: 12, // Ukuran teks lebih kecil
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
