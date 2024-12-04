import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/entity/PersonalTrainer.dart';

class PersonalTrainerClient {
  // Untuk emulator
  static final String url = 'http://10.0.2.2:8000'; // Base URL
  static final String endpoint = '/api/personal-trainer'; // Endpoint yang benar

  // Mendapatkan semua personal trainer
  Future<List<PersonalTrainer>> fetchPersonalTrainers() async {
    final response = await http.get(Uri.parse('$url$endpoint'));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Debugging line
      final jsonResponse = json.decode(response.body);

      // Ensure that response is Map and contains list
      if (jsonResponse is Map && jsonResponse['data'] is List) {
        return (jsonResponse['data'] as List)
            .map((trainer) => PersonalTrainer.fromJson(trainer))
            .toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception(
          'Failed to load personal trainers: ${response.statusCode}');
    }
  }

  // Menambahkan personal trainer baru
  Future<PersonalTrainer> createPersonalTrainer(PersonalTrainer trainer) async {
    final response = await http.post(
      Uri.parse('$url$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: trainer.toRawJson(),
    );

    if (response.statusCode == 201) {
      return PersonalTrainer.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to create personal trainer');
    }
  }

  // Mengupdate personal trainer
  Future<PersonalTrainer> updatePersonalTrainer(PersonalTrainer trainer) async {
    final response = await http.put(
      Uri.parse('$url$endpoint/${trainer.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: trainer.toRawJson(),
    );

    if (response.statusCode == 200) {
      return PersonalTrainer.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to update personal trainer');
    }
  }

  // Menghapus personal trainer
  Future<void> deletePersonalTrainer(int id) async {
    final response = await http.delete(
      Uri.parse('$url$endpoint/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete personal trainer');
    }
  }

  Future<PersonalTrainer> fetchPersonalTrainerById(int pemesananId) async {
    final response = await http.get(Uri.parse('$url$endpoint/$pemesananId'));
    if (response.statusCode == 200) {
      return PersonalTrainer.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load personal trainer');
    }
  }
}
