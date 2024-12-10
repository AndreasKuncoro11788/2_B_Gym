import 'package:flutter_application_1/entity/Pengguna.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Penggunaclient {
  static final String url = 'http://10.0.2.2:8000';
  static final String endpoint = '/api/pengguna';

  static Future<List<Pengguna>> fetchAll() async {
    try {
      final response = await get(Uri.parse('$url$endpoint'));

      if (response.statusCode != 200)
        throw Exception('Failed to load users: ${response.reasonPhrase}');

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Pengguna.fromJson(e)).toList();
    } catch (e) {
      return Future.error('Error fetching users: $e');
    }
  }

  static Future<Pengguna> find(int id) async {
    try {
      final response = await get(Uri.parse('$url$endpoint/$id'));

      if (response.statusCode != 200)
        throw Exception('Failed to find user: ${response.reasonPhrase}');

      return Pengguna.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error('Error finding user: $e');
    }
  }

  static Future<Pengguna> fetchUser(int id) async {
    return await find(id);
  }

  static Future<Pengguna> create(Pengguna pengguna) async {
    final response = await post(
      Uri.parse('$url$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: pengguna.toRawJson(),
    );

    if (response.statusCode == 201) {
      return Pengguna.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to create user: ${response.reasonPhrase}');
    }
  }

  static Future<Pengguna> update(Pengguna pengguna) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception("Token tidak ditemukan. Silakan login kembali.");
    }

    try {
      final response = await put(
        Uri.parse('$url/api/update'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: pengguna.toRawJson(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return Pengguna.fromJson(data);
      } else {
        throw Exception(
            'Gagal memperbarui data pengguna: ${response.reasonPhrase}');
      }
    } catch (e) {
      return Future.error('Error updating user: $e');
    }
  }

  static Future<void> destroy(int id) async {
    try {
      final response = await delete(Uri.parse('$url$endpoint/$id'));

      if (response.statusCode != 204)
        throw Exception('Failed to delete user: ${response.reasonPhrase}');
    } catch (e) {
      return Future.error('Error deleting user: $e');
    }
  }

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

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final token = responseBody['token'];

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('authToken', token);
        } else {
          throw Exception('Token is null');
        }
      } else {
        throw Exception('Failed to login: ${response.reasonPhrase}');
      }

      return response;
    } catch (e) {
      return Future.error('Error logging in: $e');
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception("Token tidak ditemukan. Anda mungkin sudah logout.");
    }

    final response = await post(
      Uri.parse('$url/api/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      await prefs.remove('authToken'); 
    } else {
      throw Exception(
        'Logout gagal: ${response.statusCode} - ${json.decode(response.body)['message']}',
      );
    }
  }

  static Future<Pengguna> fetchCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception("Token tidak ditemukan. Silakan login kembali.");
    }

    final response = await get(
      Uri.parse('$url/api/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil data pengguna: ${response.body}');
    }

    final data = json.decode(response.body)['data'];
    return Pengguna.fromJson(data);
  }
}
