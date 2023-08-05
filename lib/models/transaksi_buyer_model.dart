// To parse this JSON data, do
//
//     final transaksiBuyer = transaksiBuyerFromJson(jsonString);

import 'dart:convert';

TransaksiBuyer transaksiBuyerFromJson(String str) =>
    TransaksiBuyer.fromJson(json.decode(str));

String transaksiBuyerToJson(TransaksiBuyer data) => json.encode(data.toJson());

class TransaksiBuyer {
  TransaksiBuyer({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  List<TransaksiBuyerData> data;
  String message;
  int statusCode;

  factory TransaksiBuyer.fromJson(Map<String, dynamic> json) => TransaksiBuyer(
        data: List<TransaksiBuyerData>.from(
            json["data"].map((x) => TransaksiBuyerData.fromJson(x))),
        message: json["message"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status_code": statusCode,
      };
}

class TransaksiBuyerData {
  TransaksiBuyerData({
    required this.createdAt,
    required this.id,
    required this.user,
    required this.status,
    required this.title,
    required this.weight,
    required this.image,
  });

  String createdAt;
  String id;
  String user;
  int status;
  String title;
  int weight;
  String image;

  factory TransaksiBuyerData.fromJson(Map<String, dynamic> json) =>
      TransaksiBuyerData(
        createdAt: json["created_at"],
        id: json["id"],
        user: json["user"],
        status: json["status"],
        title: json["title"],
        weight: json["weight"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "id": id,
        "user": user,
        "status": status,
        "title": title,
        "weight": weight,
        "image": image,
      };
}
