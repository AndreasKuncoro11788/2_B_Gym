import 'dart:convert';

class KelasOlahraga {
  final int id;
  final String namaKelas;
  final String jadwalKelas;
  final int hargaKelas;
  final int idAlatGym;
  final int idPersonalTrainer; 

  KelasOlahraga({
    required this.id,
    required this.namaKelas,
    required this.jadwalKelas,
    required this.hargaKelas,
    required this.idAlatGym,
    required this.idPersonalTrainer,
  });

  factory KelasOlahraga.fromRawJson(String str) =>
      KelasOlahraga.fromJson(json.decode(str));

  factory KelasOlahraga.fromJson(Map<String, dynamic> json) {
    return KelasOlahraga(
      id: json["id"] is int ? json["id"] : int.parse(json["id"].toString()), 
      namaKelas: json["namaKelas"],
      jadwalKelas: json["jadwalKelas"],
      hargaKelas: json["hargaKelas"] is int ? json["hargaKelas"] : int.parse(json["hargaKelas"].toString()), 
      idAlatGym: json["id_alatGym"] is int ? json["id_alatGym"] : int.parse(json["id_alatGym"].toString()), 
      idPersonalTrainer: json["id_personalTrainer"] is int ? json["id_personalTrainer"] : int.parse(json["id_personalTrainer"].toString()), 
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    "id": id, 
    "namaKelas": namaKelas,
    "jadwalKelas": jadwalKelas,
    "hargaKelas": hargaKelas, 
    "id_alatGym": idAlatGym, 
    "id_personalTrainer": idPersonalTrainer, 
  };
}
