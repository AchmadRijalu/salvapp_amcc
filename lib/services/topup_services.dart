import 'package:salvapp_amcc/blocs/shared/shared_values.dart';
import 'package:salvapp_amcc/models/midtrans_model.dart';

import '../models/topup_form_model.dart';
import 'auth_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TopUpServices {
  Future<MidtransPayment> topUp(TopupFormModel data) async {
    try {
      final res = await http.get(
        Uri.parse('${baseUrlSalv}midtrans/top-up/${int.parse(data.amount!)}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      if (res.statusCode == 200) {
        return MidtransPayment.fromJson(jsonDecode(res.body));
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
