import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/riwayatPage/review.dart';
import 'package:flutter_application_1/entity/RiwayatPemesanan.dart';
import 'package:flutter_application_1/client/RiwayatPemesananClient.dart';
import 'package:flutter_application_1/entity/Pembayaran.dart';
import 'package:flutter_application_1/client/PembayaranClient.dart';
import 'package:flutter_application_1/entity/DataPemesanan.dart';
import 'package:flutter_application_1/client/DataPemesananClient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider untuk riwayat pemesanan
final listRiwayatProvider = FutureProvider.autoDispose<List<RiwayatPemesanan>>((ref) async {
  return await RiwayatPemesananClient.fetchRiwayatPemesanan();
});

class RiwayatPage extends ConsumerWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riwayatAsyncValue = ref.watch(listRiwayatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: riwayatAsyncValue.when(
        data: (riwayatList) => ListView.builder(
          itemCount: riwayatList.length,
          itemBuilder: (context, index) {
            final riwayat = riwayatList[index];
            return FutureBuilder<DataPemesanan>(
              future: fetchCombinedData(riwayat.id_pembayaran),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  final dataPemesanan = snapshot.data!;
                  return RiwayatCard(
                    dataPemesanan: dataPemesanan,
                    riwayat: riwayat,
                    onDelete: () => deleteRiwayat(context, ref, riwayat.id),
                    ref: ref, // Pass ref to RiwayatCard
                  );
                } else {
                  return const Center(child: Text('Data not found'));
                }
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  // Fungsi untuk mengambil data gabungan pemesanan berdasarkan ID pembayaran
  Future<DataPemesanan> fetchCombinedData(int id_pembayaran) async {
    final pembayaran = await PembayaranClient.fetchPembayaranById(id_pembayaran);
    return await DataPemesananClient.fetchDataPemesananById(pembayaran.id_pemesanan);
  }

  // Fungsi untuk menghapus riwayat pemesanan
  Future<void> deleteRiwayat(BuildContext context, WidgetRef ref, int id) async {
    try {
      await RiwayatPemesananClient.deleteRiwayatPemesanan(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Riwayat berhasil dihapus')),
      );
      ref.invalidate(listRiwayatProvider); // Refresh data
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus: $e')),
      );
    }
  }
}

class RiwayatCard extends StatelessWidget {
  final DataPemesanan dataPemesanan;
  final VoidCallback onDelete;
  final WidgetRef ref;
  final RiwayatPemesanan riwayat; // Add ref parameter

  const RiwayatCard({
    super.key,
    required this.dataPemesanan,
    required this.onDelete,
    required this.ref,
    required this.riwayat,
  });

  // Ubah fungsi onAdd untuk menerima ref sebagai parameter
  void onAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewPage(
          namaKelas: dataPemesanan.namaKelas,
          namaTrainer: dataPemesanan.namaTrainer,
          namaAlat: dataPemesanan.namaAlat,
          jadwalKelas: dataPemesanan.jadwalKelas,
          riwayat: riwayat,
        ),
      ),
    ).then((value) => ref.refresh(listRiwayatProvider)); // Refresh list riwayat setelah kembali
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '', // Menambahkan teks untuk menggantikan Text yang kosong
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jenis Kelas: ${dataPemesanan.namaKelas}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Trainer: ${dataPemesanan.namaTrainer}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Alat GYM: ${dataPemesanan.namaAlat}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Jadwal: ${dataPemesanan.jadwalKelas}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Dipesan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: onDelete,
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // Ubah untuk memanggil onAdd dengan ref
                    onAdd(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Review',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
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
  }
}
