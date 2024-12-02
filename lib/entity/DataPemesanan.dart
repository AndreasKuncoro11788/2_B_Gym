import 'dart:convert';

class DataPemesanan {
  final int id;
  final String namaPengguna;
  final String namaKelas;
  final String namaTrainer;
  final String namaAlat;
  final String jadwalKelas;
  final String id_pengguna;
  final String id_kelasOlahraga;
  final String id_PersonalTrainer;
  final String id_alatGym;

  DataPemesanan({
    required this.id,
    required this.namaPengguna,
    required this.namaKelas,
    required this.namaTrainer,
    required this.namaAlat,
    required this.jadwalKelas,
    required this.id_pengguna,
    required this.id_kelasOlahraga,
    required this.id_PersonalTrainer,
    required this.id_alatGym,

  });

  factory DataPemesanan.fromRawJson(String str) => DataPemesanan.fromJson(json.decode(str));

  factory DataPemesanan.fromJson(Map<String, dynamic> json) {
    return DataPemesanan(
      id: json["id"],
      namaPengguna: json["namaPengguna"],
      namaKelas: json["namaKelas"],
      namaTrainer: json["namaTrainer"],
      namaAlat: json["namaAlat"],
      jadwalKelas: json["jadwalKelas"],
      id_pengguna: json["id_pengguna"],
      id_kelasOlahraga: json["id_kelasOlahraga"],
      id_PersonalTrainer: json["id_PersonalTrainer"],
      id_alatGym: json["id_alatGym"],
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    "id": id,
    "namaPengguna": namaPengguna,
    "namaKelas": namaKelas,
    "namaTrainer": namaTrainer,
    "namaAlat": namaAlat,
    "jadwalKelas": jadwalKelas,
    "id_pengguna": id_pengguna,
    "id_kelasOlahraga": id_kelasOlahraga,
    "id_PersonalTrainer": id_PersonalTrainer,
    "id_alatGym": id_alatGym,
  };
}
