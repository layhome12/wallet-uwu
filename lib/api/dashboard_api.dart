import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallet_uwu/models/berita_model.dart';
import 'package:wallet_uwu/models/carousel_model.dart';
import 'package:wallet_uwu/models/response_server.dart';

class DashboardApi {
  final baseUrl = 'http://192.168.2.4:8081/api/';

  Future getBanner(String? bearer) async {
    final response = await http.get(Uri.parse(baseUrl + 'dashboard/get_banner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + bearer!
        }).timeout(
      const Duration(seconds: 5),
    );

    return GetDataBanner.fromJson(json.decode(response.body));
  }

  Future getBerita(String? bearer) async {
    final response = await http.get(
        Uri.parse(baseUrl + '/dashboard/get_berita'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + bearer!
        }).timeout(const Duration(seconds: 5));

    return GetDataBerita.fromJson(json.decode(response.body));
  }

  Future getAmmount(String? bearer) async {
    final response = await http.get(
        Uri.parse(baseUrl + '/dashboard/get_ammount'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + bearer!
        }).timeout(const Duration(seconds: 5));

    return WalletAmmountResponse.fromJson(json.decode(response.body));
  }
}
