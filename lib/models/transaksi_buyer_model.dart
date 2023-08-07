// To parse this JSON data, do
//
//     final transaksiBuyer = transaksiBuyerFromJson(jsonString);

import 'dart:convert';

TransaksiBuyer transaksiBuyerFromJson(String str) => TransaksiBuyer.fromJson(json.decode(str));

String transaksiBuyerToJson(TransaksiBuyer data) => json.encode(data.toJson());

class TransaksiBuyer {
    int statusCode;
    String message;
    List<TransaksiBuyerData> data;

    TransaksiBuyer({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    factory TransaksiBuyer.fromJson(Map<String, dynamic> json) => TransaksiBuyer(
        statusCode: json["status_code"],
        message: json["message"],
        data: List<TransaksiBuyerData>.from(json["data"].map((x) => TransaksiBuyerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class TransaksiBuyerData{
    String id;
    String status;
    String title;
    String user;
    String image;
    int weight;
    DateTime createdAt;

    TransaksiBuyerData({
        required this.id,
        required this.status,
        required this.title,
        required this.user,
        required this.image,
        required this.weight,
        required this.createdAt,
    });

    factory TransaksiBuyerData.fromJson(Map<String, dynamic> json) => TransaksiBuyerData(
        id: json["id"],
        status: json["status"],
        title: json["title"],
        user: json["user"],
        image: json["image"],
        weight: json["weight"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "title": title,
        "user": user,
        "image": image,
        "weight": weight,
        "created_at": createdAt.toIso8601String(),
    };
}
