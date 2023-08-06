// To parse this JSON data, do
//
//     final jualLimbahForm = jualLimbahFormFromJson(jsonString);

import 'dart:convert';

JualLimbahForm jualLimbahFormFromJson(String str) =>
    JualLimbahForm.fromJson(json.decode(str));

String jualLimbahFormToJson(JualLimbahForm data) => json.encode(data.toJson());

class JualLimbahForm {
  JualLimbahForm(
      {required this.userId,
      required this.advertisementId,
      required this.weight,
      required this.image});

  String userId;
  String advertisementId;
  int weight;

  dynamic image;

  factory JualLimbahForm.fromJson(Map<String, dynamic> json) => JualLimbahForm(
      userId: json["user_id"],
      advertisementId: json["1"],
      weight: json["weight"],
      image: json["image"]);

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "advertisement_id": advertisementId,
        "weight": weight,
        "image": image
      };
}
