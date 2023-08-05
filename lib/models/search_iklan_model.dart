// To parse this JSON data, do
//
//     final searchIklan = searchIklanFromJson(jsonString);

import 'dart:convert';

SearchIklan searchIklanFromJson(String str) =>
    SearchIklan.fromJson(json.decode(str));

String searchIklanToJson(SearchIklan data) => json.encode(data.toJson());

class SearchIklan {
  List<Datum> data;
  String message;
  int statusCode;

  SearchIklan({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory SearchIklan.fromJson(Map<String, dynamic> json) => SearchIklan(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status_code": statusCode,
      };
}

class Datum {
  String category;
  String id;
  int ongoingWeight;
  int price;
  int requestedWeight;
  String title;
  String endDate;

  Datum({
    required this.category,
    required this.id,
    required this.ongoingWeight,
    required this.price,
    required this.requestedWeight,
    required this.title,
    required this.endDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        category: json["category"],
        id: json["id"],
        ongoingWeight: json["ongoing_weight"],
        price: json["price"],
        requestedWeight: json["requested_weight"],
        title: json["title"],
        endDate: json["end_date"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "id": id,
        "ongoing_weight": ongoingWeight,
        "price": price,
        "requested_weight": requestedWeight,
        "title": title,
        "end_date": endDate,
      };
}
