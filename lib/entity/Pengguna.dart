import 'dart:convert';

class Pengguna {
  final int id;
  final String namaPengguna;
  final String nomorIdentitas;
  final String? jenisKelamin; // Nullable
  final String email;
  final String? umur; // Nullable
  final String? kataSandi; // Nullable
  final String nomorTelepon;

  Pengguna({
    required this.id,
    required this.namaPengguna,
    required this.nomorIdentitas,
    this.jenisKelamin,
    required this.email,
    this.umur,
    this.kataSandi,
    required this.nomorTelepon,
  });

  // Parsing dari String JSON mentah
  factory Pengguna.fromRawJson(String str) => Pengguna.fromJson(json.decode(str));

  // Parsing dari Map JSON
  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      id: json["id"] ?? 0, // Default value jika null
      namaPengguna: json["namaPengguna"] ?? "Tidak tersedia",
      nomorIdentitas: json["nomorIdentitas"] ?? "Tidak tersedia",
      jenisKelamin: json["jeniKelamin"], // Nullable
      email: json["email"] ?? "Email tidak tersedia",
      umur: json["umur"], // Nullable
      kataSandi: json["kataSandi"], // Nullable
      nomorTelepon: json["nomorTelepon"] ?? "Tidak tersedia",
    );
  }

  // Mengubah objek ke JSON mentah (String)
  String toRawJson() => json.encode(toJson());

  // Mengubah objek ke Map JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "namaPengguna": namaPengguna,
        "nomorIdentitas": nomorIdentitas,
        "jeniKelamin": jenisKelamin, // Nullable
        "email": email,
        "umur": umur, // Nullable
        "kataSandi": kataSandi, // Nullable
        "nomorTelepon": nomorTelepon,
      };
}
