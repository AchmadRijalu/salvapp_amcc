// To parse this JSON data, do
//
//     final beranda = berandaFromJson(jsonString);

import 'dart:convert';

Beranda berandaFromJson(String str) => Beranda.fromJson(json.decode(str));

String berandaToJson(Beranda data) => json.encode(data.toJson());

class Beranda {
  int statusCode;
  String message;
  List<BerandaData> data;
  List<Transaction> transactions;

  Beranda({
    required this.statusCode,
    required this.message,
    required this.data,
    required this.transactions,
  });

  factory Beranda.fromJson(Map<String, dynamic> json) => Beranda(
        statusCode: json["status_code"],
        message: json["message"],
        data: List<BerandaData>.from(
            json["data"].map((x) => BerandaData.fromJson(x))),
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class BerandaData {
  String category;
  int totalWeight;
  String? image;
  int transactionCount;

  BerandaData({
    required this.category,
    required this.totalWeight,
    required this.transactionCount,
    this.image
  });

  factory BerandaData.fromJson(Map<String, dynamic> json) => BerandaData(
        category: json["category"],
        totalWeight: json["total_weight"],
        transactionCount: json["transaction_count"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "total_weight": totalWeight,
        "transaction_count": transactionCount,
        "image": image,
      };
}

class Transaction {
  DateTime createdAt;
  String status;
  String title;
  int totalPrice;
  String user;
  String? image;

  Transaction({
    required this.createdAt,
    required this.status,
    required this.title,
    required this.totalPrice,
    required this.user,
    this.image,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        title: json["title"],
        totalPrice: json["total_price"],
        user: json["user"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "title": title,
        "total_price": totalPrice,
        "user": user,
        "image": image,
      };
}
