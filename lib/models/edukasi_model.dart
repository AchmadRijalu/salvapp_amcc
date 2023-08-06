// To parse this JSON data, do
//
//     final edukasi = edukasiFromJson(jsonString);

import 'dart:convert';

Edukasi edukasiFromJson(String str) => Edukasi.fromJson(json.decode(str));

String edukasiToJson(Edukasi data) => json.encode(data.toJson());

class Edukasi {
    int statusCode;
    String message;
    List<EdukasiData> data;

    Edukasi({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    factory Edukasi.fromJson(Map<String, dynamic> json) => Edukasi(
        statusCode: json["status_code"],
        message: json["message"],
        data: List<EdukasiData>.from(json["data"].map((x) => EdukasiData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class EdukasiData {
    String id;
    String thumbnail;
    String title;
    String category;
    DateTime createdAt;

    EdukasiData({
        required this.id,
        required this.thumbnail,
        required this.title,
        required this.category,
        required this.createdAt,
    });

    factory EdukasiData.fromJson(Map<String, dynamic> json) => EdukasiData(
        id: json["id"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "title": title,
        "category": category,
        "created_at": createdAt.toIso8601String(),
    };
}
