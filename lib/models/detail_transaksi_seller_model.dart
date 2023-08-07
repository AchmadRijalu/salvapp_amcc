// To parse this JSON data, do
//
//     final detailTransaksiSeller = detailTransaksiSellerFromJson(jsonString);

import 'dart:convert';

DetailTransaksiSeller detailTransaksiSellerFromJson(String str) => DetailTransaksiSeller.fromJson(json.decode(str));

String detailTransaksiSellerToJson(DetailTransaksiSeller data) => json.encode(data.toJson());

class DetailTransaksiSeller {
    int statusCode;
    String message;
    DetailTransaksiSellerData data;

    DetailTransaksiSeller({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    factory DetailTransaksiSeller.fromJson(Map<String, dynamic> json) => DetailTransaksiSeller(
        statusCode: json["status_code"],
        message: json["message"],
        data: DetailTransaksiSellerData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data.toJson(),
    };
}

class DetailTransaksiSellerData {
    String id;
    int ongoingWeight;
    int requestedWeight;
    String title;
    String category;
    String additionalInformation;
    int weight;
    int totalPrice;

    DetailTransaksiSellerData({
        required this.id,
        required this.ongoingWeight,
        required this.requestedWeight,
        required this.title,
        required this.category,
        required this.additionalInformation,
        required this.weight,
        required this.totalPrice,
    });

    factory DetailTransaksiSellerData.fromJson(Map<String, dynamic> json) => DetailTransaksiSellerData(
        id: json["id"],
        ongoingWeight: json["ongoing_weight"],
        requestedWeight: json["requested_weight"],
        title: json["title"],
        category: json["category"],
        additionalInformation: json["additional_information"],
        weight: json["weight"],
        totalPrice: json["total_price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ongoing_weight": ongoingWeight,
        "requested_weight": requestedWeight,
        "title": title,
        "category": category,
        "additional_information": additionalInformation,
        "weight": weight,
        "total_price": totalPrice,
    };
}
