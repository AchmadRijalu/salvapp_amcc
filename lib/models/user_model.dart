// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.data,
    this.message,
    this.statusCode,
    this.tokenType,
  });

  final Userdata? data;
  final String? message;
  final int? statusCode;

  final String? tokenType;

  factory User.fromJson(Map<String, dynamic> json) => User(
        data: Userdata.fromJson(json["data"]),
        message: json["message"],
        statusCode: json["status_code"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "status_code": statusCode,
        "token_type": tokenType,
      };
}

class Userdata {
  Userdata(
      {this.address,
      this.password,
      this.token,
      this.city,
      this.id,
      this.image,
      this.name,
      this.email,
      this.phoneNumber,
      this.postalCode,
      this.province,
      this.subdistrict,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.username,
      this.ward,
      this.latitude,
      this.longitude,
      this.point});

  final int? type;
  final String? token;
  final String? name;
  final String? password;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final String? province;
  final String? city;
  final String? subdistrict;
  final String? ward;
  final String? address;
  final String? postalCode;
  final int? point;
  final String? image;
  final dynamic latitude;
  final dynamic longitude;
  final String? id;
  final String? createdAt;
  final dynamic updatedAt;

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        address: json["address"],
        id: json["id"],
        password: json["password"],
        token: json["token"],
        city: json["city"],
        image: json["image"],
        email: json["email"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        postalCode: json["postal_code"],
        province: json["province"],
        subdistrict: json["subdistrict"],
        type: json["type"],
        username: json["username"],
        ward: json["ward"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        point: json["point"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['address'] = address;
  //   data['city'] = city;
  //   data['id'] = id;
  //   data['image'] = image;
  //   data['name'] = name;
  //   data['password'] = password;
  //   data['phone_number'] = phoneNumber;
  //   data['postal_code'] = postalCode;
  //   data['province'] = province;
  //   data['subdistrict'] = subdistrict;
  //   data['token'] = token;
  //   data['type'] = type;
  //   data['username'] = name;
  //   data['ward'] = ward;
  //   data['latitude'] = latitude;
  //   data['longitude'] = longitude;
  //   data['point'] = point;

  //   return data;
  // }
  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "password": password,
        "username": username,
        "email": email,
        "token": token,
        "phone_number": phoneNumber,
        "province": province,
        "city": city,
        "subdistrict": subdistrict,
        "ward": ward,
        "address": address,
        "postal_code": postalCode,
        "point": point,
        "image": image,
        "latitude": latitude,
        "longitude": longitude,
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);


