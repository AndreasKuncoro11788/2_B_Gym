import 'dart:convert';

class DataPemesanan {
  final int id;
  final String namaPengguna;
  final String namaKelas;
  final String namaTrainer;
  final String namaAlat;
  final String jadwalKelas;
  final String status;
  final int id_pengguna;
  final int id_kelasOlahraga;
  final int id_personalTrainer;
  final int id_alatGym;

  DataPemesanan({
    required this.id,
    required this.namaPengguna,
    required this.namaKelas,
    required this.namaTrainer,
    required this.namaAlat,
    required this.jadwalKelas,
    required this.status,
    required this.id_pengguna,
    required this.id_kelasOlahraga,
    required this.id_personalTrainer,
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
      status: json["status"],
      id_pengguna: json["id_pengguna"],
      id_kelasOlahraga: json["id_kelasOlahraga"],
      id_personalTrainer: json["id_personalTrainer"],
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
    "status": status,
    "id_pengguna": id_pengguna,
    "id_kelasOlahraga": id_kelasOlahraga,
    "id_personalTrainer": id_personalTrainer,
    "id_alatGym": id_alatGym,
  };
}
