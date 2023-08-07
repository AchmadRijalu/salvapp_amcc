// To parse this JSON data, do
//
//     final iklanSellerDetail = iklanSellerDetailFromJson(jsonString);

import 'dart:convert';

IklanBuyerDetail iklanSellerDetailFromJson(String str) =>
    IklanBuyerDetail.fromJson(json.decode(str));

String iklanSellerDetailToJson(IklanBuyerDetail data) =>
    json.encode(data.toJson());

class IklanBuyerDetail {
  IklanBuyerDetail({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  IklanBuyerDetailData data;
  String message;
  int statusCode;

  factory IklanBuyerDetail.fromJson(Map<String, dynamic> json) =>
      IklanBuyerDetail(
        data: IklanBuyerDetailData.fromJson(json["data"]),
        message: json["message"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status_code": statusCode,
      };
}

class IklanBuyerDetailData {
  IklanBuyerDetailData(
      {required this.additionalInformation,
      required this.category,
      required this.id,
      required this.maximumWeight,
      required this.minimumWeight,
      required this.price,
      required this.ongoingWeight,
      required this.requestedWeight,
      required this.title,
      this.status
      });

  String id;
  int ongoingWeight;
  int requestedWeight;
  String title;
  String category;
  String additionalInformation;
  int maximumWeight;
  int minimumWeight;
  int price;
  String? status;

  factory IklanBuyerDetailData.fromJson(Map<String, dynamic> json) =>
      IklanBuyerDetailData(
        additionalInformation: json["additional_information"],
        category: json["category"],
        id: json["id"],
        maximumWeight: json["maximum_weight"],
        minimumWeight: json["minimum_weight"],
        price: json["price"],
        title: json["title"],
        ongoingWeight: json["ongoing_weight"],
        requestedWeight: json["requested_weight"],
        status: json["status"]
      );

  Map<String, dynamic> toJson() => {
        "additional_information": additionalInformation,
        "category": category,
        "id": id,
        "maximum_weight": maximumWeight,
        "minimum_weight": minimumWeight,
        "price": price,
        "title": title,
        "ongoing_weight": ongoingWeight,
        "requested_weight": requestedWeight,
        "status": status
      };
}
