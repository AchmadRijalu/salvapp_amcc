// To parse this JSON data, do
//
//     final iklanSellerDetail = iklanSellerDetailFromJson(jsonString);

import 'dart:convert';

IklanSellerDetail iklanSellerDetailFromJson(String str) =>
    IklanSellerDetail.fromJson(json.decode(str));

String iklanSellerDetailToJson(IklanSellerDetail data) =>
    json.encode(data.toJson());

class IklanSellerDetail {
  IklanSellerDetailData data;
  String message;
  int statusCode;

  IklanSellerDetail({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory IklanSellerDetail.fromJson(Map<String, dynamic> json) =>
      IklanSellerDetail(
        data: IklanSellerDetailData.fromJson(json["data"]),
        message: json["message"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status_code": statusCode,
      };
}

class IklanSellerDetailData {
  String id;
  int ongoingWeight;
  int requestedWeight;
  String title;
  String category;
  String additionalInformation;
  int maximumWeight;
  int minimumWeight;
  int price;

  IklanSellerDetailData({
    required this.additionalInformation,
    required this.requestedWeight,
    required this.category,
    required this.id,
    required this.maximumWeight,
    required this.minimumWeight,
    required this.ongoingWeight,
    required this.price,
    required this.title,
  });

  factory IklanSellerDetailData.fromJson(Map<String, dynamic> json) =>
      IklanSellerDetailData(
        additionalInformation: json["additional_information"],
        category: json["category"],
        id: json["id"],
        maximumWeight: json["maximum_weight"],
        requestedWeight: json["requested_weight"],
        minimumWeight: json["minimum_weight"],
        ongoingWeight: json["ongoing_weight"],
        price: json["price"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "additional_information": additionalInformation,
        "category": category,
        "id": id,
        "maximum_weight": maximumWeight,
        "minimum_weight": minimumWeight,
        "ongoing_weight": ongoingWeight,
        "requested_weight": requestedWeight,
        "price": price,
        "title": title,
      };
}
