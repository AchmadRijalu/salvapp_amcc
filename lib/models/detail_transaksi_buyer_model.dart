// To parse this JSON data, do
//
//     final detailTransaksiBuyer = detailTransaksiBuyerFromJson(jsonString);

import 'dart:convert';

DetailTransaksiBuyer detailTransaksiBuyerFromJson(String str) => DetailTransaksiBuyer.fromJson(json.decode(str));

String detailTransaksiBuyerToJson(DetailTransaksiBuyer data) => json.encode(data.toJson());

class DetailTransaksiBuyer {
    int statusCode;
    String message;
    DetailTransaksiBuyerData data;

    DetailTransaksiBuyer({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    factory DetailTransaksiBuyer.fromJson(Map<String, dynamic> json) => DetailTransaksiBuyer(
        statusCode: json["status_code"],
        message: json["message"],
        data: DetailTransaksiBuyerData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data.toJson(),
    };
}

class DetailTransaksiBuyerData {
    String id;
    int ongoingWeight;
    int requestedWeight;
    String title;
    String category;
    String additionalInformation;
    int weight;
    int totalPrice;
    double latitude;
    double longitude;

    DetailTransaksiBuyerData({
        required this.id,
        required this.ongoingWeight,
        required this.requestedWeight,
        required this.title,
        required this.category,
        required this.additionalInformation,
        required this.weight,
        required this.totalPrice,
        required this.latitude,
        required this.longitude,
    });

    factory DetailTransaksiBuyerData.fromJson(Map<String, dynamic> json) => DetailTransaksiBuyerData(
        id: json["id"],
        ongoingWeight: json["ongoing_weight"],
        requestedWeight: json["requested_weight"],
        title: json["title"],
        category: json["category"],
        additionalInformation: json["additional_information"],
        weight: json["weight"],
        totalPrice: json["total_price"],
        latitude: json["latitude"],
        longitude: json["longitude"],
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
        "latitude": latitude,
        "longitude": longitude,
    };
}
