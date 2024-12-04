import 'dart:convert';

class KelasOlahraga {
  final int id; // Primary key
  final String namaKelas;
  final String jadwalKelas;
  final int idAlatGym; // Field for alat gym ID
  final int idPersonalTrainer; // Field for personal trainer ID

  KelasOlahraga({
    required this.id,
    required this.namaKelas,
    required this.jadwalKelas,
    required this.idAlatGym,
    required this.idPersonalTrainer,
  });

  factory KelasOlahraga.fromRawJson(String str) =>
      KelasOlahraga.fromJson(json.decode(str));

  factory KelasOlahraga.fromJson(Map<String, dynamic> json) {
    return KelasOlahraga(
      id: json["id"] is int ? json["id"] : int.parse(json["id"].toString()), // Ensure it's an int
      namaKelas: json["namaKelas"],
      jadwalKelas: json["jadwalKelas"],
      idAlatGym: json["id_alatGym"] is int ? json["id_alatGym"] : int.parse(json["id_alatGym"].toString()), // Ensure it's an int
      idPersonalTrainer: json["id_personalTrainer"] is int ? json["id_personalTrainer"] : int.parse(json["id_personalTrainer"].toString()), // Ensure it's an int
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id, // Ensure this matches the database column name
        "namaKelas": namaKelas,
        "jadwalKelas": jadwalKelas,
        "id_alatGym": idAlatGym, // Ensure this matches the database column name
        "id_personalTrainer": idPersonalTrainer, // Ensure this matches the database column name
      };
}
