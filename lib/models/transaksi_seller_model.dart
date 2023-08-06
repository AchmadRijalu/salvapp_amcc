// To parse this JSON data, do
//
//     final transaksiSeller = transaksiSellerFromJson(jsonString);

import 'dart:convert';

TransaksiSeller transaksiSellerFromJson(String str) => TransaksiSeller.fromJson(json.decode(str));

String transaksiSellerToJson(TransaksiSeller data) => json.encode(data.toJson());

class TransaksiSeller {
    int statusCode;
    String message;
    List<TransaksiSellerData> data;

    TransaksiSeller({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    factory TransaksiSeller.fromJson(Map<String, dynamic> json) => TransaksiSeller(
        statusCode: json["status_code"],
        message: json["message"],
        data: List<TransaksiSellerData>.from(json["data"].map((x) => TransaksiSellerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class TransaksiSellerData {
    String id;
    String status;
    int totalPrice;
    String title;
    String user;
    String image;

    TransaksiSellerData({
        required this.id,
        required this.status,
        required this.totalPrice,
        required this.title,
        required this.user,
        required this.image,
    });

    factory TransaksiSellerData.fromJson(Map<String, dynamic> json) => TransaksiSellerData(
        id: json["id"],
        status: json["status"],
        totalPrice: json["total_price"],
        title: json["title"],
        user: json["user"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "total_price": totalPrice,
        "title": title,
        "user": user,
        "image": image,
    };
}
