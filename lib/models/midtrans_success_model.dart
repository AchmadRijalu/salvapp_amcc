// To parse this JSON data, do
//
//     final midtransSuccess = midtransSuccessFromJson(jsonString);

import 'dart:convert';

MidtransSuccess midtransSuccessFromJson(String str) => MidtransSuccess.fromJson(json.decode(str));

String midtransSuccessToJson(MidtransSuccess data) => json.encode(data.toJson());

class MidtransSuccess {
    int statusCode;
    String message;

    MidtransSuccess({
        required this.statusCode,
        required this.message,
    });

    factory MidtransSuccess.fromJson(Map<String, dynamic> json) => MidtransSuccess(
        statusCode: json["status_code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
    };
}
