// To parse this JSON data, do
//
//     final iklanBuyer = iklanBuyerFromJson(jsonString);

import 'dart:convert';

IklanBuyer iklanBuyerFromJson(String str) =>
    IklanBuyer.fromJson(json.decode(str));

String iklanBuyerToJson(IklanBuyer data) => json.encode(data.toJson());

class IklanBuyer {
    int statusCode;
    String message;
    List<IklanBuyerData> data;

    IklanBuyer({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    factory IklanBuyer.fromJson(Map<String, dynamic> json) => IklanBuyer(
        statusCode: json["status_code"],
        message: json["message"],
        data: List<IklanBuyerData>.from(json["data"].map((x) => IklanBuyerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class IklanBuyerData {
    String id;
    String title;
    String category;
    int price;
    String user;
    String image;

    IklanBuyerData({
        required this.id,
        required this.title,
        required this.category,
        required this.price,
        required this.user,
        required this.image,
    });

    factory IklanBuyerData.fromJson(Map<String, dynamic> json) => IklanBuyerData(
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
