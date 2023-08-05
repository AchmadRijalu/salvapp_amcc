import 'dart:convert';

import 'package:http/http.dart' as http;

import '../blocs/shared/shared_values.dart';
import '../models/beranda_buyer_model.dart';
import '../models/beranda_seller_model.dart';

import 'auth_services.dart';

class BerandaService {
  Future<Beranda> getBerandaAllData() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}dashboard"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      return Beranda.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
