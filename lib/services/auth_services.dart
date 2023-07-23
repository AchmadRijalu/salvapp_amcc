import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import '../blocs/shared/shared_values.dart';
import '../models/sign_in_form_model.dart';
import '../models/sign_up_form_model.dart';
import '../models/user_model.dart';

// 10.0.2.2:8080
class AuthService {
  //Turn into dynamic parameter cause of checking the user availability
  Future<dynamic> register(SignupFormModel data) async {
    // final modifiedJson = Map.from(data!.toJson())..remove('image');
    // print(modifiedJson);
    try {
      final response = await http.post(Uri.parse("${baseUrlSalv}register"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data.toJson()));

      if (response.statusCode == 200) {
        var resHolder = jsonDecode(response.body)['message'];
        if (resHolder == "username exist") {
          throw "Username sudah terpakai";
        } else {
          print("200");
          // print(response.body);
          if (jsonDecode(response.body)['data'] == "username exist") {
            throw "Username sudah terpakai";
          }
          print(response.body);
          final user = Userdata.fromJson(jsonDecode(response.body)['data']);
          // user.password = data.password;
          await storeCredentialToLocal(user);
          return user;
        }
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print("500");
      print(e);
      rethrow;
    }
  }

  Future<Userdata> login(SigninFormModel data) async {
    try {
      final response = await http.post(Uri.parse("${baseUrlSalv}login"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data.toJson()));

      if (response.statusCode == 200) {
        var resHolder = jsonDecode(response.body)['message'];
        print(resHolder);
        if (resHolder == "user not found") {
          throw "Username/Password Salah";
        } else {
          final user = Userdata.fromJson(jsonDecode(response.body)['data']);
          user.password = data.password;
          await storeCredentialToLocal(user);

          return user;
        }
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      // print("500");
      // print("eror");
      print(e);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrlSalv}logout"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await getToken(),
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        await clearLocalStorage();
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {}
  }

  //Saving credential Account into local
  Future<void> storeCredentialToLocal(Userdata userdata) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: userdata.token);
      await storage.write(key: 'username', value: userdata.username);
      await storage.write(key: 'password', value: userdata.password);
      await storage.write(key: 'type', value: userdata.type.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<SigninFormModel?> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, dynamic> values = await storage.readAll();
      if (values['username'] == null ||
          values['password'] == null ||
          values['type'] == null) {
        print("token : ${values['token']}");
        throw 'Belum Ter-Auth';
      } else {
        final SigninFormModel? data = SigninFormModel(
          username: values['username'],
          password: values['password'],
          type: values['type'],
        );

        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  //get Token Function
  Future<String> getToken() async {
    String? token = '';
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    if (value != null) {
      token = "Bearer " + value;
    }
    return token;
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
