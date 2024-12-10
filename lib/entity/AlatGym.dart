import 'dart:convert';

class AlatGym {
  final int alatId;
  final String namaAlat;
  final double harga;

  AlatGym({
    required this.alatId,
    required this.namaAlat,
    required this.harga,
  });

  factory AlatGym.fromRawJson(String str) => AlatGym.fromJson(json.decode(str));

  factory AlatGym.fromJson(Map<String, dynamic> json) {
    return AlatGym(
      alatId: json["id"],
      namaAlat: json["namaAlat"],
      harga: json["harga"].toDouble(),
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": alatId,
        "namaAlat": namaAlat,
        "harga": harga,
      };
}
