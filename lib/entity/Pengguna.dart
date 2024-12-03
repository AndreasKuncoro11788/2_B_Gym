
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
  String fotoProfile;

  Pengguna({
    this.id,
    required this.namaPengguna,
    required this.nomorIdentitas,
    required this.jenisKelamin,
    required this.umur,
    required this.email,
    required this.kataSandi,
    required this.nomorTelepon,
    required this.fotoProfile,
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
      fotoProfile: json['fotoProfile'],
    );
  }

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() {
    return {
      'namaPengguna': namaPengguna,
      'nomorIdentitas': nomorIdentitas,
      'jenisKelamin': jenisKelamin,
      'umur': umur,
      'email': email,
      'kataSandi': kataSandi,
      'nomorTelepon': nomorTelepon,
      'fotoProfile': fotoProfile,
    };
  }
}
