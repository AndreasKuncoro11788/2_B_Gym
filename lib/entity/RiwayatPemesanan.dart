import 'dart:convert';

class RiwayatPemesanan {
  final int id;
  final String review;
  final int rating;
  final int id_pembayaran;

  RiwayatPemesanan({
    required this.id,
    required this.review,
    required this.rating,
    required this.id_pembayaran,
  });

  factory RiwayatPemesanan.fromRawJson(String str) =>
      RiwayatPemesanan.fromJson(json.decode(str));

  factory RiwayatPemesanan.fromJson(Map<String, dynamic> json) {
    return RiwayatPemesanan(
      id: json["id"],
      review: json["review"],
      rating: json["rating"],
      id_pembayaran: json["id_pembayaran"],
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "review": review,
        "rating": rating,
        "id_pembayaran": id_pembayaran,
      };

  // copyWith method with only optional fields that can change
  RiwayatPemesanan copyWith({
    int? rating,
    String? review,
  }) {
    return RiwayatPemesanan(
      id: this.id, 
      rating: rating ?? this.rating,
      review: review ?? this.review,
      id_pembayaran: this.id_pembayaran,
    );
  }
}
