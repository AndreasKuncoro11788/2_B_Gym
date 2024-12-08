import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/kelasSayaPage/refund.dart';
import 'package:flutter_application_1/view/kelasSayaPage/detailTransaction.dart';
import 'package:flutter_application_1/client/dataPemesananClient.dart';
import 'package:flutter_application_1/entity/DataPemesanan.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listDataPemesananProvider = FutureProvider.autoDispose<List<DataPemesanan>>((ref) async {
  return await DataPemesananClient.fetchDataPemesanan();
});

class KelasSayaPage extends ConsumerWidget {
  const KelasSayaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataPemesananAsync = ref.watch(listDataPemesananProvider);

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
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(listDataPemesananProvider);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: dataPemesananAsync.when(
            data: (kelasData) {
              final filteredData = kelasData.where((kelas) => kelas.status != "done").toList();

              return ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final kelas = filteredData[index];
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kelas ${kelas.namaKelas}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Trainer: ${kelas.namaTrainer}'),
                                const SizedBox(height: 4),
                                Text('Alat Gym: ${kelas.namaAlat}'),
                                const SizedBox(height: 4),
                                Text('Jadwal: ${kelas.jadwalKelas}'),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailTransaction(
                                          pemesananId: kelas.id.toString(),
                                          jadwalKelas: kelas.jadwalKelas,
                                        ),
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
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await DataPemesananClient.updateStatusToDoneById(kelas.id);
                                      ref.refresh(listDataPemesananProvider);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Status berhasil diperbarui ke Done')),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error: $e')),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Mark as Done',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 100,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RefundPage(
                                          pemesananId: kelas.id.toString(),
                                          jadwalKelas: kelas.jadwalKelas,
                                        ),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    side: const BorderSide(color: Colors.red),
                                  ),
                                  child: const Text(
                                    'Batalkan',
                                    style: TextStyle(
                                      fontSize: 12,
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
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
        ),
      ),
    );
  }
}
