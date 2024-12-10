import 'dart:convert';

class Pembayaran {
  final int? id;
  final int id_pemesanan;
  final String jenisPembayaran;
  final String statusPembayaran;
  final int totalPembayaran;

  Pembayaran({
    this.id,
    required this.id_pemesanan,
    required this.jenisPembayaran,
    required this.statusPembayaran,
    required this.totalPembayaran,
  });

  factory Pembayaran.fromRawJson(String str) =>
      Pembayaran.fromJson(json.decode(str));

  factory Pembayaran.fromJson(Map<String, dynamic> json) {
    return Pembayaran(
      id: json["id"],
      id_pemesanan: json["id_pemesanan"],
      jenisPembayaran: json["jenisPembayaran"],
      statusPembayaran: json["statusPembayaran"],
      totalPembayaran: json["totalPembayaran"],
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pemesanan": id_pemesanan,
        "jenisPembayaran": jenisPembayaran,
        "statusPembayaran": statusPembayaran,
        "totalPembayaran": totalPembayaran,
      };
}
