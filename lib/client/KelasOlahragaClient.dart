import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/entity/KelasOlahraga.dart';

class KelasOlahragaClient {
  // For emulator
  static final String url = 'http://10.0.2.2:8000'; // base URL
  static final String endpoint = '/api/kelas-olahraga'; // Correct endpoint

  // Fetch all Kelas Olahraga
  Future<List<KelasOlahraga>> fetchKelasOlahraga() async {
    final response = await http.get(Uri.parse('$url$endpoint'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((kelas) => KelasOlahraga.fromJson(kelas))
          .toList();
    } else {
      throw Exception('Failed to load kelas olahraga');
    }
  }

  // Create a new Kelas Olahraga
  Future<KelasOlahraga> createKelasOlahraga(KelasOlahraga kelasOlahraga) async {
    final response = await http.post(
      Uri.parse('$url$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: kelasOlahraga.toRawJson(),
    );

    if (response.statusCode == 201) {
      return KelasOlahraga.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to create kelas olahraga');
    }
  }

  // Update Kelas Olahraga
  Future<KelasOlahraga> updateKelasOlahraga(KelasOlahraga kelasOlahraga) async {
    final response = await http.put(
      Uri.parse('$url$endpoint/${kelasOlahraga.id}'), // Use id instead of idKelas
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: kelasOlahraga.toRawJson(),
    );

    if (response.statusCode == 200) {
      return KelasOlahraga.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to update kelas olahraga');
    }
  }

  // Delete Kelas Olahraga
  Future<void> deleteKelasOlahraga(int id) async { 
    final response = await http.delete(
      Uri.parse('$url$endpoint/$id'), 
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete kelas olahraga');
    }
  }

  // Fetch Kelas Olahraga by id
  Future<KelasOlahraga> fetchKelasOlahragaById(int id) async { 
    final response = await http.get(Uri.parse('$url$endpoint/$id'));
    if (response.statusCode == 200) {
      return KelasOlahraga.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load kelas olahraga');
    }
  }
}
