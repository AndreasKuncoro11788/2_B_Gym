import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/entity/AlatGym.dart';

class AlatGymClient {

  static final String url = 'http://10.0.2.2:8000'; 
  static final String endpoint = '/api/alat-gym';

  Future<List<AlatGym>> fetchAlatGym() async {
    final response = await http.get(Uri.parse('$url$endpoint'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((alat) => AlatGym.fromJson(alat)).toList();
    } else {
      throw Exception('Failed to load alat gym');
    }
  }

  Future<AlatGym> createAlatGym(AlatGym alatGym) async {
    final response = await http.post(
      Uri.parse('$url$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: alatGym.toRawJson(),
    );

    if (response.statusCode == 201) {
      return AlatGym.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to create alat gym');
    }
  }

  Future<AlatGym> updateAlatGym(AlatGym alatGym) async {
    final response = await http.put(
      Uri.parse('$url$endpoint/${alatGym.alatId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: alatGym.toRawJson(),
    );

    if (response.statusCode == 200) {
      return AlatGym.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to update alat gym');
    }
  }

  Future<void> deleteAlatGym(String alatId) async {
    final response = await http.delete(
      Uri.parse('$url$endpoint/$alatId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete alat gym');
    }
  }

  Future<AlatGym> fetchAlatGymById(int pemesananId) async {
    final response = await http.get(Uri.parse('$url$endpoint/$pemesananId'));
    if (response.statusCode == 200) {
      return AlatGym.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load alat gym');
    }
  }

}
