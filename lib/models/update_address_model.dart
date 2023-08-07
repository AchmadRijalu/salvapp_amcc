// To parse this JSON data, do
//
//     final updateAddress = updateAddressFromJson(jsonString);

import 'dart:convert';

UpdateAddress updateAddressFromJson(String str) =>
    UpdateAddress.fromJson(json.decode(str));

String updateAddressToJson(UpdateAddress data) => json.encode(data.toJson());

class UpdateAddress {
  int statusCode;
  String message;
  UpdateAddressData data;

  UpdateAddress({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UpdateAddress.fromJson(Map<String, dynamic> json) => UpdateAddress(
        statusCode: json["status_code"],
        message: json["message"],
        data: UpdateAddressData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class UpdateAddressData {
  UpdateAddressData();

  factory UpdateAddressData.fromJson(Map<String, dynamic> json) =>
      UpdateAddressData();

  Map<String, dynamic> toJson() => {};
}
