import 'package:flutter/material.dart';
import 'package:flutter_application_1/entity/DataPemesanan.dart';
import 'package:flutter_application_1/entity/Pembayaran.dart';
import 'package:flutter_application_1/entity/AlatGym.dart';
import 'package:flutter_application_1/entity/KelasOlahraga.dart';
import 'package:flutter_application_1/entity/Pengguna.dart';
import 'package:flutter_application_1/view/kelasSayaPage/viewPDF.dart';
import 'package:flutter_application_1/client/PembayaranClient.dart';
import 'package:flutter_application_1/client/AlatGymClient.dart';
import 'package:flutter_application_1/client/KelasOlahragaClient.dart';
import 'package:flutter_application_1/client/DataPemesananClient.dart';
import 'package:flutter_application_1/client/PenggunaClient.dart';

class DetailTransaction extends StatelessWidget {
  final String pemesananId;
  final String jadwalKelas;

  const DetailTransaction({
    super.key,
    required this.pemesananId,
    required this.jadwalKelas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text(
            'Detail Transaction',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
        body: FutureBuilder<DataPemesanan>(
          future: DataPemesananClient.fetchDataPemesananById(
              int.parse(pemesananId)),
          builder: (context, snapshotPemesanan) {
            if (snapshotPemesanan.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshotPemesanan.hasError) {
              return Center(child: Text('Error: ${snapshotPemesanan.error}'));
            } else if (snapshotPemesanan.hasData) {
              DataPemesanan dataPemesanan = snapshotPemesanan.data!;

              // Panggil data pengguna berdasarkan id_pengguna
              return FutureBuilder<Pengguna>(
                future: Penggunaclient.fetchCurrentUser(),
                builder: (context, snapshotPengguna) {
                  if (snapshotPengguna.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshotPengguna.hasError) {
                    return Center(
                        child: Text('Error: ${snapshotPengguna.error}'));
                  } else if (snapshotPengguna.hasData) {
                    Pengguna pengguna = snapshotPengguna.data!;

                    // Lanjutkan untuk mengambil data alat gym, kelas olahraga, dan pembayaran
                    return FutureBuilder<List<dynamic>>(
                      future: Future.wait([
                        AlatGymClient()
                            .fetchAlatGymById(dataPemesanan.id_alatGym),
                        KelasOlahragaClient().fetchKelasOlahragaById(
                            dataPemesanan.id_kelasOlahraga),
                        PembayaranClient.fetchPembayaranByPemesananId(
                            int.parse(pemesananId)),
                      ]),
                      builder: (context, snapshotData) {
                        if (snapshotData.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshotData.hasError) {
                          return Center(
                              child: Text('Error: ${snapshotData.error}'));
                        } else if (snapshotData.hasData) {
                          AlatGym alatGym = snapshotData.data![0];
                          KelasOlahraga kelasOlahraga = snapshotData.data![1];

                          // Ambil data pembayaran dari List<Pembayaran>
                          List<Pembayaran> listPembayaran =
                              snapshotData.data![2];
                          Pembayaran pembayaran = listPembayaran.isNotEmpty
                              ? listPembayaran.first
                              : throw Exception(
                                  'Data pembayaran tidak ditemukan');

                          return _buildDetailPage(context, dataPemesanan,
                              alatGym, kelasOlahraga, pembayaran, pengguna);
                        } else {
                          return const Center(child: Text('No Data Available'));
                        }
                      },
                    );
                  } else {
                    return const Center(child: Text('No Data Available'));
                  }
                },
              );
            } else {
              return const Center(child: Text('No Data Available'));
            }
          },
        ));
  }

  Widget _buildDetailPage(
      BuildContext context,
      DataPemesanan dataPemesanan,
      AlatGym alatGym,
      KelasOlahraga kelasOlahraga,
      Pembayaran pembayaran,
      Pengguna pengguna) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF9F9F9),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Detail',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'ID Pemesanan: ${dataPemesanan.id}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'ID Pembayaran: ${pembayaran.id}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          _buildClassInfoCard(alatGym, kelasOlahraga, dataPemesanan),
          const SizedBox(height: 20),
          const Divider(
            color: Color(0xFFD9D9D9),
            thickness: 2,
          ),
          const SizedBox(height: 10),
          _buildPaymentInfo(pembayaran),
          const Spacer(),
          _buildActionButton(context, dataPemesanan, pembayaran, kelasOlahraga,
              alatGym, pengguna),
        ],
      ),
    );
  }

  Widget _buildClassInfoCard(AlatGym alatGym, KelasOlahraga kelasOlahraga,
      DataPemesanan dataPemesanan) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jenis Kelas: ${kelasOlahraga.namaKelas}',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 5),
          Text('Trainer: ${dataPemesanan.namaTrainer}',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 5),
          Text('Alat GYM: ${alatGym.namaAlat}',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 5),
          Text('Jadwal: $jadwalKelas', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo(Pembayaran pembayaran) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Metode Pembayaran: ${pembayaran.jenisPembayaran}',
            style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        Text('Status: ${pembayaran.statusPembayaran}',
            style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total Pembayaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Rp. ${pembayaran.totalPembayaran}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context,
      DataPemesanan dataPemesanan,
      Pembayaran pembayaran,
      KelasOlahraga kelasOlahraga,
      AlatGym alatGym,
      Pengguna pengguna) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFB3286),
          minimumSize: const Size(200, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          // Pindah ke PdfGenerator dan kirimkan data pengguna
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfGenerator(
                paymentId: pembayaran.id.toString(), // Use pembayaran.id
                orderId: dataPemesanan.id.toString(), // Use dataPemesanan.id
                name: pengguna.namaPengguna,
                email: pengguna.email,
                phone: pengguna.nomorTelepon,
                address: pengguna
                    .jenisKelamin, // Assuming this is the correct field for address
                orderDate: dataPemesanan
                    .jadwalKelas, // Assuming this is the correct field for order date
                paymentMethod: pembayaran.jenisPembayaran,
                paymentNumber: pembayaran.id.toString(),
                totalPayment: pembayaran.totalPembayaran.toString(),
                kelasOlahraga: [
                  {
                    'name': 'Kelas ${kelasOlahraga.namaKelas}',
                    'price': '${kelasOlahraga.hargaKelas}',
                  },
                ],
                dataAlatGym: [
                  {
                    'name': alatGym.namaAlat,
                    'price': '${alatGym.harga}',
                  },
                ],
              ),
            ),
          );
        },
        child: const Text(
          'Buka PDF',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
