// To parse this JSON data, do
//
//     final searchIklan = searchIklanFromJson(jsonString);

import 'dart:convert';

SearchIklan searchIklanFromJson(String str) =>
    SearchIklan.fromJson(json.decode(str));

String searchIklanToJson(SearchIklan data) => json.encode(data.toJson());

class SearchIklan {
  int statusCode;
  String message;
  List<SearchIklanData> data;

  SearchIklan({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SearchIklan.fromJson(Map<String, dynamic> json) => SearchIklan(
        statusCode: json["status_code"],
        message: json["message"],
        data: List<SearchIklanData>.from(
            json["data"].map((x) => SearchIklanData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchIklanData {
  String id;
  String title;
  String category;
  int price;
  String user;
  String image;

  SearchIklanData({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.user,
    required this.image,
  });

  factory SearchIklanData.fromJson(Map<String, dynamic> json) =>
      SearchIklanData(
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
