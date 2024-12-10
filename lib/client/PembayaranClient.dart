import 'package:flutter_application_1/entity/Pembayaran.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PembayaranClient {
  static final String url = 'http://10.0.2.2:8000';
  static final String endpoint = '/api/pembayaran';

  // Mengambil semua pembayaran
  static Future<List<Pembayaran>> fetchPembayaran() async {
    final response = await http.get(Uri.parse('$url$endpoint'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((data) => Pembayaran.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load pembayaran');
    }
  }

  // Membuat pembayaran baru
  static Future<Pembayaran> createPembayaran({
    required int idPemesanan, // Pastikan ini adalah int
    required String jenisPembayaran,
    required String statusPembayaran,
    required int totalPembayaran,
  }) async {
    final pembayaran = Pembayaran(
      id: null, // Set to null for new entries
      id_pemesanan: idPemesanan,
      jenisPembayaran: jenisPembayaran,
      statusPembayaran: statusPembayaran,
      totalPembayaran: totalPembayaran,
    );

    final response = await http.post(
      Uri.parse('$url$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: pembayaran.toRawJson(),
    );

    if (response.statusCode == 201) {
      return Pembayaran.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to create pembayaran');
    }
  }

  // Mengupdate pembayaran
  static Future<Pembayaran> updatePembayaran(Pembayaran pembayaran) async {
    final response = await http.put(
      Uri.parse('$url$endpoint/${pembayaran.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: pembayaran.toRawJson(),
    );

    if (response.statusCode == 200) {
      return Pembayaran.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to update pembayaran');
    }
  }

  // Menghapus pembayaran
  static Future<void> deletePembayaran(int id) async {
    final response = await http.delete(
      Uri.parse('$url$endpoint/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete pembayaran');
    }
  }

  // Mengambil pembayaran berdasarkan ID
  static Future<Pembayaran> fetchPembayaranById(int id) async {
    final response = await http.get(Uri.parse('$url$endpoint/$id'));

    if (response.statusCode == 200) {
      return Pembayaran.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to find pembayaran');
    }
  }

  // Mengambil pembayaran berdasarkan ID pemesanan
  static Future<List<Pembayaran>> fetchPembayaranByPemesananId(
      int idPemesanan) async {
    final response = await http.get(Uri.parse('$url$endpoint'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      List<Pembayaran> allPayments =
          jsonResponse.map((data) => Pembayaran.fromJson(data)).toList();
      return allPayments
          .where((pembayaran) => pembayaran.id_pemesanan == idPemesanan)
          .toList();
    } else {
      throw Exception('Gagal mengambil data pembayaran');
    }
  }

  // Menghapus pembayaran berdasarkan ID pemesanan
  static Future<void> deletePembayaranByPemesananId(int idPemesanan) async {
    final response = await http.delete(
      Uri.parse(
          '$url$endpoint/$idPemesanan'), // Endpoint untuk menghapus data pembayaran berdasarkan id_pemesanan
    );

    if (response.statusCode == 200) {
      // Data pembayaran berhasil dihapus
      print('Pembayaran dengan id_pemesanan $idPemesanan berhasil dihapus');
    } else {
      throw Exception('Gagal menghapus data pembayaran');
    }
  }
}
