import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/entity/DataPemesanan.dart';
import 'package:flutter_application_1/client/DataPemesananClient.dart';
import 'package:flutter_application_1/view/riwayatPage/review.dart';

final listDataPemesananProvider = FutureProvider.autoDispose<List<DataPemesanan>>((ref) async {
  return await DataPemesananClient.fetchDataPemesanan();
});

class RiwayatPage extends ConsumerWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  void onAdd(BuildContext context, DataPemesanan dataPemesanan, WidgetRef ref) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewPage(
          idPemesanan: dataPemesanan.id,
          namaKelas: dataPemesanan.namaKelas,
          namaTrainer: dataPemesanan.namaTrainer,
          namaAlat: dataPemesanan.namaAlat,
          jadwalKelas: dataPemesanan.jadwalKelas,
        ),
      ),
    ).then((value) => ref.refresh(listDataPemesananProvider));
  }

  Future<void> onDelete(BuildContext context, int id, WidgetRef ref) async {
    try {
      await DataPemesananClient.deleteDataPemesanan(id);
      // Refresh the list after deletion
      ref.refresh(listDataPemesananProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data pemesanan berhasil dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataPemesananAsync = ref.watch(listDataPemesananProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Riwayat',
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
      body: dataPemesananAsync.when(
        data: (dataPemesananList) {
          // Filter data yang memiliki status 'done'
          final filteredList = dataPemesananList.where((item) => item.status == 'done').toList();

          if (filteredList.isEmpty) {
            return const Center(child: Text('Tidak ada riwayat dengan status selesai.'));
          }

          return ListView.builder(
            itemCount: filteredList.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              final dataPemesanan = filteredList[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kelas ${dataPemesanan.namaKelas}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Selesai',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Trainer: ${dataPemesanan.namaTrainer}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Alat GYM: ${dataPemesanan.namaAlat}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Jadwal: ${dataPemesanan.jadwalKelas}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Divider(height: 24, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              onDelete(context, dataPemesanan.id, ref);
                            },
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              onAdd(context, dataPemesanan, ref);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Review',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
