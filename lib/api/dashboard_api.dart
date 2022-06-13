import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallet_uwu/models/carousel_model.dart';

class DashboardApi {
  final baseUrl = 'http://192.168.0.2:8081/api/';

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
}
