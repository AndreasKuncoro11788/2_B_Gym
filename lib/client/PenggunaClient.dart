import 'package:flutter_application_1/entity/Pengguna.dart';
import 'dart:convert';
import 'package:http/http.dart';

class Penggunaclient {
  static final String url = 'http://10.0.2.2:8000';
  static final String endpoint = '/api/pengguna';

  // Mengambil semua data pengguna dari API
  static Future<List<Pengguna>> fetchAll() async {
    try {
      final response = await get(Uri.parse('$url$endpoint'));

      if (response.statusCode != 200) throw Exception('Failed to load users: ${response.reasonPhrase}');

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Pengguna.fromJson(e)).toList();
    } catch (e) {
      return Future.error('Error fetching users: $e');
    }
  }

  // Mencari pengguna berdasarkan ID
  static Future<Pengguna> find(int id) async {
    try {
      final response = await get(Uri.parse('$url$endpoint/$id'));

      if (response.statusCode != 200) throw Exception('Failed to find user: ${response.reasonPhrase}');

      return Pengguna.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error('Error finding user: $e');
    }
  }

  // Mengambil data pengguna berdasarkan ID untuk profil
  static Future<Pengguna> fetchUser(int id) async {
    return await find(id);
  }

  // Membuat pengguna baru
  static Future<Response> create(Pengguna pengguna) async {
      final response = await post(
        Uri.parse('$url$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pengguna.toJson()),
      );

      if (response.statusCode != 201) {
        print('Response body: ${response.body}');
        throw Exception('Failed to create user: ${response.reasonPhrase}');
      }
      return response;
  }

  // Memperbarui data pengguna
  static Future<void> update(Pengguna pengguna) async {
    try {
      final response = await put(
        Uri.parse('$url$endpoint/${pengguna.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(pengguna.toJson()),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('User updated successfully');
      } else {
        throw Exception('Failed to update user. Status: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('Error updating user: $e');
    }
  }

  // Menghapus pengguna berdasarkan ID
  static Future<void> destroy(int id) async {
    try {
      final response = await delete(Uri.parse('$url$endpoint/$id'));

      if (response.statusCode != 204) throw Exception('Failed to delete user: ${response.reasonPhrase}');
    } catch (e) {
      return Future.error('Error deleting user: $e');
    }
  }

  // Metode untuk login pengguna
  static Future<Response> login(String namaPengguna, String password) async {
    try {
      final response = await post(
        Uri.parse('$url$endpoint/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'namaPengguna': namaPengguna,
          'kataSandi': password,
        }),
      );


      if (response.statusCode != 200) throw Exception('Failed to login: ${response.reasonPhrase}');

      return response;
    } catch (e) {
      return Future.error('Error logging in: $e');
    }
  }
}
