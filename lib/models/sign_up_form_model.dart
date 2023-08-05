import 'dart:ffi';

class SignupFormModel {
  final String? name;
  final String? email;
  final String? password;
  final String? username;
  final String? phoneNumber;
  final dynamic type;
  final String? province;
  final String? city;
  final String? ward;
  final String? subdistrict;
  final String? postal_code;
  final String? address;
  final dynamic image;
  final dynamic longitude;
  final dynamic latitude;

  SignupFormModel(
      {this.email,
      this.name,
      this.password,
      this.username,
      this.phoneNumber,
      this.type,
      this.province,
      this.city,
      this.ward,
      this.subdistrict,
      this.postal_code,
      this.address,
      this.image,
      this.latitude,
      this.longitude});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      'password': password,
      'username': username,
      'phone_number': phoneNumber,
      'type': type,
      'province': province,
      'city': city,
      'ward': ward,
      'subdistrict': subdistrict,
      'postal_code': postal_code,
      'address': address,
      'image': image,
      'latitude': latitude,
      'longitude': longitude
    };
  }

  SignupFormModel copyWith(
          {String? name,
          String? email,
          String? password,
          String? username,
          String? phoneNumber,
          String? type,
          dynamic latitude,
          dynamic longitude,
          String? province,
          String? city,
          String? ward,
          String? subdistrict,
          String? postal_code,
          String? address,
          String? image}) =>
      SignupFormModel(
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password,
          username: username ?? this.username,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          type: type ?? this.type,
          province: province ?? this.province,
          city: city ?? this.city,
          ward: ward ?? this.ward,
          subdistrict: subdistrict ?? this.subdistrict,
          postal_code: postal_code ?? this.postal_code,
          address: address ?? this.address,
          latitude: latitude ?? this.latitude,
          longitude: longitude ?? this.longitude,
          image: image ?? this.image);
}
