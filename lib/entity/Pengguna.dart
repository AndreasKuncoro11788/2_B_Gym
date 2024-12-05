
import 'dart:convert';

class Pengguna {
  int? id;
  String namaPengguna;
  String nomorIdentitas;
  String jenisKelamin;
  String umur;
  String email;
  String kataSandi;
  String nomorTelepon;
  String fotoProfil;

  Pengguna({
    this.id,
    required this.namaPengguna,
    required this.nomorIdentitas,
    required this.jenisKelamin,
    required this.umur,
    required this.email,
    required this.kataSandi,
    required this.nomorTelepon,
    required this.fotoProfil,
  });

  factory Pengguna.fromRawJson(String str) => Pengguna.fromJson(jsonDecode(str));
  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      id: json['id'],
      namaPengguna: json['namaPengguna'],
      nomorIdentitas: json['nomorIdentitas'],
      jenisKelamin: json['jenisKelamin'],
      umur: json['umur'],
      email: json['email'],
      kataSandi: json['kataSandi'],
      nomorTelepon: json['nomorTelepon'],
      fotoProfil: json['fotoProfil'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'namaPengguna': namaPengguna,
      'nomorIdentitas': nomorIdentitas,
      'jenisKelamin': jenisKelamin,
      'umur': umur,
      'email': email,
      'kataSandi': kataSandi,
      'nomorTelepon': nomorTelepon,
      'fotoProfil': fotoProfil,
    };
  }
  String toRawJson() => json.encode(toJson());
}
