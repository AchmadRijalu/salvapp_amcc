import 'dart:convert';

import '../blocs/shared/shared_values.dart';
import '../models/detail_edukasi_model.dart';
import '../models/edukasi_model.dart';
import 'package:http/http.dart' as http;

import 'auth_services.dart';

class EdukasiService {
  Future<Edukasi> getEdukasi() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}education/index"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      return Edukasi.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<EdukasiDetail> getEdukasiDetail(dynamic educationId) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}education/${educationId}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      if (response.statusCode == 200) {
        var edukasiDetail = EdukasiDetail.fromJson(json.decode(response.body));
        return edukasiDetail;
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
