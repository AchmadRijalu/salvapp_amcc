// To parse this JSON data, do
//
//     final iklanSeller = iklanSellerFromJson(jsonString);

import 'dart:convert';

IklanSeller iklanSellerFromJson(String str) =>
    IklanSeller.fromJson(json.decode(str));

String iklanSellerToJson(IklanSeller data) => json.encode(data.toJson());

class IklanSeller {
  IklanSeller({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  List<IklanSellerData> data;
  String message;
  int statusCode;

  factory IklanSeller.fromJson(Map<String, dynamic> json) => IklanSeller(
        data: List<IklanSellerData>.from(
            json["data"].map((x) => IklanSellerData.fromJson(x))),
        message: json["message"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status_code": statusCode,
      };
}

class IklanSellerData {
  String id;
  String title;
  String category;
  int price;
  String user;
  String image;

  IklanSellerData({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.user,
    required this.image,
  });

  factory IklanSellerData.fromJson(Map<String, dynamic> json) => IklanSellerData(
        id: json["id"],
        title: json["title"],
        category: json["category"],
        price: json["price"],
        user: json["user"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category,
        "price": price,
        "user": user,
        "image": image,
      };
}
