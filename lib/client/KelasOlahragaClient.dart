import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/entity/KelasOlahraga.dart';

class KelasOlahragaClient {
  static final String url = 'http://10.0.2.2:8000'; 
  static final String endpoint = '/api/kelas-olahraga'; 

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

  Future<KelasOlahraga> updateKelasOlahraga(KelasOlahraga kelasOlahraga) async {
    final response = await http.put(
      Uri.parse('$url$endpoint/${kelasOlahraga.id}'), 
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

  Future<void> deleteKelasOlahraga(int id) async { 
    final response = await http.delete(
      Uri.parse('$url$endpoint/$id'), 
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete kelas olahraga');
    }
  }

  Future<KelasOlahraga> fetchKelasOlahragaById(int id) async { 
    final response = await http.get(Uri.parse('$url$endpoint/$id'));
    if (response.statusCode == 200) {
      return KelasOlahraga.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load kelas olahraga');
    }
  }
}
