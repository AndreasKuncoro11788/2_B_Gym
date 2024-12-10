import 'package:flutter_application_1/entity/RiwayatPemesanan.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RiwayatPemesananClient {
  static final String url = 'http://10.0.2.2:8000';
  static final String endpoint = '/api/riwayat-pemesanan';

  // Fungsi untuk mengambil riwayat pemesanan
  static Future<List<RiwayatPemesanan>> fetchRiwayatPemesanan() async {
    final response = await http.get(Uri.parse('$url$endpoint'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'] ?? [];
      return jsonResponse
          .map((data) => RiwayatPemesanan.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load riwayat pemesanan');
    }
  }

  // Fungsi untuk membuat riwayat pemesanan baru
  static Future<RiwayatPemesanan> createRiwayatPemesanan(
      RiwayatPemesanan riwayatPemesanan) async {
    final response = await http.post(
      Uri.parse('$url$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: riwayatPemesanan.toRawJson(),
    );

    if (response.statusCode == 201) {
      return RiwayatPemesanan.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to create riwayat pemesanan');
    }
  }

  // Fungsi untuk mengupdate riwayat pemesanan (termasuk review dan rating)
  static Future<RiwayatPemesanan> updateRiwayatPemesanan(
      RiwayatPemesanan riwayatPemesanan) async {
    try {
      final response = await http.put(
        Uri.parse('$url$endpoint/${riwayatPemesanan.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'rating': riwayatPemesanan.rating, // Send rating
          'review': riwayatPemesanan.review, // Send review
        }),
      );

      if (response.statusCode == 200) {
        // Successfully updated
        return RiwayatPemesanan.fromJson(json.decode(response.body)['data']);
      } else {
        // Handle non-200 responses
        throw Exception(
            'Failed to update riwayat pemesanan: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      throw Exception('Error updating riwayat pemesanan: $e');
    }
  }

  // Fungsi untuk menghapus riwayat pemesanan
  static Future<void> deleteRiwayatPemesanan(int id) async {
    final response = await http.delete(
      Uri.parse('$url$endpoint/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete riwayat pemesanan');
    }
  }

  // Fungsi untuk mengambil riwayat pemesanan berdasarkan ID
  static Future<RiwayatPemesanan> fetchRiwayatPemesananById(int id) async {
    final response = await http.get(Uri.parse('$url$endpoint/$id'));

    if (response.statusCode == 200) {
      return RiwayatPemesanan.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load riwayat pemesanan by id');
    }
  }

  static Future<List<RiwayatPemesanan>> fetchRiwayatPemesananByPembayaranId(
      int idPembayaran) async {
    final response =
        await http.get(Uri.parse('$url$endpoint')); // Ambil semua data riwayat

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      List<RiwayatPemesanan> allRiwayat =
          jsonResponse.map((data) => RiwayatPemesanan.fromJson(data)).toList();
      List<RiwayatPemesanan> filteredRiwayat = allRiwayat
          .where((riwayat) => riwayat.id_pembayaran == idPembayaran)
          .toList();
      return filteredRiwayat;
    } else {
      throw Exception('Gagal mengambil data riwayat pemesanan');
    }
  }
}
