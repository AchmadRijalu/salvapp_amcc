import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salvapp_amcc/models/iklan_form_model.dart';
import 'package:salvapp_amcc/models/iklan_seller_detail_model.dart';


import '../blocs/shared/shared_values.dart';
import '../models/batal_iklan_buyer.dart';

import '../models/iklan_add_model.dart';
import '../models/iklan_buyer_detail_model.dart';
import '../models/pembeli_iklan_model.dart';
import '../models/penjual_iklan_model.dart';
import 'auth_services.dart';

class IklanService {
  //SELLER SIDE
  Future<IklanSeller> getIklanSeller() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}seller-advertisement/index"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      print(response.body);
      
      return IklanSeller.fromJson(json.decode(response.body));
    } catch (e) {
      print("Hasil error : ${e}");
      rethrow;
    }
  }

  Future<IklanSeller> getIklanRecommendation(dynamic categories) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}content-based/${categories}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      return IklanSeller.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<IklanSellerDetail> getIklanSellerDetail(dynamic id) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}seller-advertisement/${id}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      return IklanSellerDetail.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  //BUYER SERVICE SIDE

  Future<IklanBuyer> getIklanBuyer(dynamic user) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}buyer-advertisement/index/${user}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );

      return IklanBuyer.fromJson(json.decode(response.body));
    } catch (e) {
      print("errornya : $e");
      rethrow;
    }
  }

  Future<IklanBuyerDetail> getIklanBuyerDetail(dynamic id) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}buyer-advertisement/${id}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      return IklanBuyerDetail.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  //not done yet
  Future<dynamic> addIklanBuyer(TambahIklanForm tambahIklanForm) async {
    try {
      final response =
          await http.post(Uri.parse("${baseUrlSalv}buyer-advertisement"),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': await AuthService().getToken(),
              },
              body: jsonEncode(tambahIklanForm.toJson()));
      
      if (response.statusCode == 200) {
        print("200");
        print(response.body);
        final iklanAdded = IklanAddModel.fromJson(jsonDecode(response.body));
        return iklanAdded;
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<BatalIklanBuyer> batalIklanBuyer(dynamic transactionId) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}buyer-advertisement/cancel/${transactionId}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      print("PRINT: ${response.body}");
      return BatalIklanBuyer.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
