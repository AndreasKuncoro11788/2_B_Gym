import 'package:flutter_application_1/entity/Pengguna.dart';
import 'dart:convert';
import 'package:http/http.dart';

class Penggunaclient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/pengguna';

  // Mengambil semua data pengguna dari API
  static Future<List<Pengguna>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint)); // Request ke API dan menyimpan responsenya

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // Mengambil bagian data dari response body
      Iterable list = json.decode(response.body)['data'];

      // List.map untuk membuat list objek Pengguna berdasarkan tiap elemen dari list
      return list.map((e) => Pengguna.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Mencari pengguna berdasarkan ID
  static Future<Pengguna> find(int id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id')); // Request ke API untuk pengguna tertentu

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // Mengembalikan objek Pengguna dari response body
      return Pengguna.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Mengambil data pengguna berdasarkan ID untuk profil
  static Future<Pengguna> fetchUser(int id) async {
    return await find(id); // Menggunakan metode find untuk mengambil pengguna berdasarkan ID
  }

  // Membuat pengguna baru
  static Future<Pengguna> create(Pengguna pengguna) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pengguna.toJson()), // Mengonversi objek Pengguna ke JSON
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);

      // Mengembalikan objek Pengguna yang baru dibuat
      return Pengguna.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Memperbarui data pengguna
  static Future<Pengguna> update(Pengguna pengguna) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${pengguna.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pengguna.toJson()), // Mengonversi objek Pengguna ke JSON
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // Mengembalikan objek Pengguna yang diperbarui
      return Pengguna.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Menghapus pengguna berdasarkan ID
  static Future<void> destroy(int id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id')); // Request ke API untuk menghapus pengguna

      if (response.statusCode != 204) throw Exception(response.reasonPhrase);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
