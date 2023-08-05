import 'dart:convert';
import 'package:http/http.dart' as http;

import '../blocs/shared/shared_values.dart';
import '../models/kategori_limbah_model.dart';
import 'auth_services.dart';

class KategoriLimbahService {
  Future<KategoriLimbah> getKategoriLimbah() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}buyer-advertisement/create"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      return KategoriLimbah.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
