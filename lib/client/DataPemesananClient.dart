import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/entity/DataPemesanan.dart';

class DataPemesananClient {
  static final String url = 'http://10.0.2.2:8000'; 
  static final String endpoint = '/api/data-pemesanan';


  static Future<List<DataPemesanan>> fetchDataPemesanan() async {
    final response = await http.get(Uri.parse('$url$endpoint'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((data) => DataPemesanan.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data pemesanan');
    }
  }

  static Future<DataPemesanan> createDataPemesanan(DataPemesanan dataPemesanan) async {
    final response = await http.post(
      Uri.parse('$url$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: dataPemesanan.toRawJson(),
    );

    if (response.statusCode == 201) {
      return DataPemesanan.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to create data pemesanan');
    }
  }

  static Future<DataPemesanan> updateDataPemesanan(DataPemesanan dataPemesanan) async {
    final response = await http.put(
      Uri.parse('$url$endpoint/${dataPemesanan.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: dataPemesanan.toRawJson(),
    );

    if (response.statusCode == 200) {
      return DataPemesanan.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to update data pemesanan');
    }
  }

  static Future<void> deleteDataPemesanan(int id) async {
    final response = await http.delete(
      Uri.parse('$url$endpoint/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data pemesanan');
    }
  }

  static Future<DataPemesanan> fetchDataPemesananById(int id) async {
    final response = await http.get(Uri.parse('$url$endpoint/$id'));

    if (response.statusCode == 200) {
      return DataPemesanan.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load data pemesanan');
    }
  }

  static Future<DataPemesanan> updateStatusToDoneById(int idPemesanan) async {
    final response = await http.put(
      Uri.parse('$url$endpoint/$idPemesanan'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'status': 'done',
      }),
    );

    if (response.statusCode == 200) {
      return DataPemesanan.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to update status pemesanan');
    }
  }

  
}