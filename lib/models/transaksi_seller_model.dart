// To parse this JSON data, do
//
//     final transaksiSeller = transaksiSellerFromJson(jsonString);

import 'dart:convert';

TransaksiSeller transaksiSellerFromJson(String str) =>
    TransaksiSeller.fromJson(json.decode(str));

String transaksiSellerToJson(TransaksiSeller data) =>
    json.encode(data.toJson());

class TransaksiSeller {
  TransaksiSeller({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  List<TransaksiSellerData> data;
  String message;
  int statusCode;

  factory TransaksiSeller.fromJson(Map<String, dynamic> json) =>
      TransaksiSeller(
        data: List<TransaksiSellerData>.from(
            json["data"].map((x) => TransaksiSellerData.fromJson(x))),
        message: json["message"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status_code": statusCode,
      };
}

class TransaksiSellerData {
  TransaksiSellerData({
    required this.createdAt,
    required this.id,
    required this.user,
    required this.status,
    required this.title,
    required this.totalPrice,
    required this.image
  });

  String createdAt;
  String id;
  String user;
  int status;
  String title;
  int totalPrice;
  String image;

  factory TransaksiSellerData.fromJson(Map<String, dynamic> json) =>
      TransaksiSellerData(
        createdAt: json["created_at"],
        id: json["id"],
        user: json["user"],
        status: json["status"],
        title: json["title"],
        totalPrice: json["total_price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "id": id,
        "user": userValues.reverse[user],
        "status": status,
        "title": title,
        "total_price": totalPrice,
        "image": image,
      };
}

enum User { JON_MEDINA, JAMES_MARSH, ACHMAD_RIJALU }

final userValues = EnumValues({
  "Achmad Rijalu": User.ACHMAD_RIJALU,
  "James Marsh": User.JAMES_MARSH,
  "Jon Medina": User.JON_MEDINA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
