import 'dart:convert';

class AlatGym {
  final String alatId;
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
      alatId: json["id"].toString(), // Pastikan ini sesuai dengan nama kolom di database
      namaAlat: json["namaAlat"],
      harga: json["harga"].toDouble(),
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    "id": alatId, // Pastikan ini sesuai dengan nama kolom di database
    "namaAlat": namaAlat,
    "harga": harga,
  };
}
