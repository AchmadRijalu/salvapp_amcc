import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salvapp_amcc/models/update_address_model.dart';
import 'package:salvapp_amcc/models/user_model.dart';

import '../blocs/shared/shared_values.dart';

import 'auth_services.dart';

class LokasiService {
  Future<UpdateAddress> updateLokasi(UpdatedAddress updatedLocation) async {
    try {
      final response =
          await http.post(Uri.parse("${baseUrlSalv}address/update"),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': await AuthService().getToken(),
              },
              body: jsonEncode(updatedLocation.toJson()));

      return UpdateAddress.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
