import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/entity/PersonalTrainer.dart';

class PersonalTrainerClient {
  static final String url = 'http://10.0.2.2:8000'; 
  static final String endpoint = '/api/personal-trainer'; 

  Future<List<PersonalTrainer>> fetchPersonalTrainers() async {
    final response = await http.get(Uri.parse('$url$endpoint'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((trainer) => PersonalTrainer.fromJson(trainer))
          .toList();
    } else {
      throw Exception('Failed to load personal trainers');
    }
  }

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

  Future<void> deletePersonalTrainer(int id) async {
    final response = await http.delete(
      Uri.parse('$url$endpoint/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete personal trainer');
    }
  }

  Future<PersonalTrainer> fetchPersonalTrainerById(int id) async {
    final response = await http.get(Uri.parse('$url$endpoint/$id'));
    if (response.statusCode == 200) {
      return PersonalTrainer.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load personal trainer');
    }
  }
}
