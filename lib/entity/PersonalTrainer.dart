import 'dart:convert';

class PersonalTrainer {
  final int id; 
  final String namaTrainer;
  final String nomorIdentitas;

  PersonalTrainer({
    required this.id,
    required this.namaTrainer,
    required this.nomorIdentitas,
  });

  factory PersonalTrainer.fromRawJson(String str) =>
      PersonalTrainer.fromJson(json.decode(str));

  factory PersonalTrainer.fromJson(Map<String, dynamic> json) {
    return PersonalTrainer(
      id: json['id'], 
      namaTrainer: json['namaTrainer'],
      nomorIdentitas: json['nomorIdentitas'],
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id, 
        'namaTrainer': namaTrainer,
        'nomorIdentitas': nomorIdentitas,
      };
}
