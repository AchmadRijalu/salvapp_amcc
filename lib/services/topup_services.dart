import 'package:salvapp_amcc/blocs/shared/shared_values.dart';

import '../models/topup_form_model.dart';
import 'auth_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TopUpServices{
   Future<String> topUp(TopupFormModel data) async {
    try {
      print(data.toJson());
      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse('{$baseUrlSalv}midtrans/top-up/${data.amount}}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: data.toJson(),
      );

      print(res.body);

      if (res.statusCode == 200) {
        return jsonDecode(res.body)['redirect_url'];
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}