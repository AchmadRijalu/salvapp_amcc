import 'dart:convert';

import 'package:http/http.dart' as http;
import '../blocs/shared/shared_values.dart';
import '../models/aksi_transaksi_buyer_model.dart';
import '../models/aksi_transaksi_seller_model.dart';
import '../models/detail_transaksi_buyer_model.dart';
import '../models/detail_transaksi_seller_model.dart';
import '../models/jual_limbah_form_model.dart';
import '../models/jual_limbah_model.dart';
import '../models/transaksi_buyer_model.dart';
import '../models/transaksi_seller_model.dart';
import '../models/user_model.dart';

import 'auth_services.dart';

class TransaksiService {
  Future<TransaksiSeller> getTransaksiSeller(dynamic user) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}seller-transaction/index/${user}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      if (jsonDecode(response.body)['message'] ==
          'failed get all transaction') {
        throw Exception(jsonDecode(response.body)['message']);
      }
      return TransaksiSeller.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<TransaksiBuyer> getTransaksiBuyer(dynamic user) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}buyer-transaction/index/${user}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      return TransaksiBuyer.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailTransaksiSeller> getTransaksiSellerDetail(dynamic id) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}seller-transaction/${id}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      return DetailTransaksiSeller.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailTransaksiBuyer> getTransaksiBuyerDetail(dynamic id) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}buyer-transaction/${id}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      return DetailTransaksiBuyer.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<AksiTransaksiBuyer> getAksiTransaksiBuyer(
      dynamic transactionId, dynamic status) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}buyer-transaction/${transactionId}/${status}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      return AksiTransaksiBuyer.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<AksiTransaksiSeller> getAksiTransaksiSeller(
      dynamic transactionId, int status) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${baseUrlSalv}seller-transaction/${transactionId}/${status}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      print(transactionId);
      print(status);
      print(response.body);

      return AksiTransaksiSeller.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createTransaksi(JualLimbahForm jualLimbahForm) async {
    try {
      final response =
          await http.post(Uri.parse("${baseUrlSalv}seller-transaction"),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': await AuthService().getToken(),
              },
              body: jsonEncode(jualLimbahForm.toJson()));
      print(response.body);

      if (json.decode(response.body)["data"] == "weight exceed the target") {
        throw "Berat melebihi target";
      }
      return JualLimbah.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
